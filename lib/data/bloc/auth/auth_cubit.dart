import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import '../../../presention/customs/share_per.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthCubit() : super(AuthInitial());

  Future<void> signInWithEmailPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      QuerySnapshot userQuerySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (userQuerySnapshot.docs.isNotEmpty) {
        var userDoc = userQuerySnapshot.docs.first;
        String name = userDoc['name'];
        String phone = userDoc['phone'];

        await SharePer.saveData('userName', name);
        await SharePer.saveData('userPhone', phone);

        emit(AuthSuccess(userCredential.user!.uid));
      } else {
        emit(AuthFailure("لم يتم العثور على مستخدم بهذا البريد الإلكتروني"));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure("فشل في تسجيل الدخول: ${e.message}"));
    }
  }

  Future<void> signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
    required DateTime birthDate,
    required String gender,
  }) async {
    emit(AuthLoading());
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = phone;
      await _firestore.collection('users').doc(userId).set({
        'name': name,
        'phone': phone,
        'email': email,
        'birthDate': birthDate,
        'gender': gender,
      });

      await _firestore.collection('wallets').doc(userId).set({
        'phone': phone,
        'balance': 1000.0,
        'currency': 'EGP',
      });

      // تخزين البيانات في SharedPreferences
      await SharePer.saveData('userName', name);
      await SharePer.saveData('userPhone', phone);

      emit(AuthSuccess(userId)); // إرسال الـ userId في حالة النجاح
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure("فشل في إنشاء الحساب: ${e.message}"));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    emit(AuthInitial());
  }
}
