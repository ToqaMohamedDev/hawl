import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:untitled/presention/customs/share_per.dart';
part 'pay_state.dart';

class PayCubit extends Cubit<PayState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String selectedUniversity='جامعة الخرطوم';
  String selectedCompanies='Sudani';

  PayCubit() : super(PayInitial());
 static PayCubit get(context)=>BlocProvider.of(context);

  Future<void> transferMoney({
    required String recipientPhone,
    required double amount,
  }) async
  {

    try {
      emit(PayLoading());
      final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.none)) {
        emit(PayFailure("لا يوجد اتصال بالإنترنت"));
        return;
      }

      String senderPhone = await SharePer.getData("userPhone");

      DocumentSnapshot senderWalletSnapshot = await _firestore.collection('wallets').doc(senderPhone).get();
      if (!senderWalletSnapshot.exists) {
        emit(PayFailure("لا يوجد حساب في هذا الرقم"));
        return;
      }
      double senderBalance = senderWalletSnapshot['balance'];

      if (senderBalance < amount) {
        emit(PayFailure("الرصيد غير كافٍ لإتمام التحويل"));
        return;
      }

      DocumentSnapshot recipientWalletSnapshot = await _firestore.collection('wallets').doc(recipientPhone).get();
      if (!recipientWalletSnapshot.exists) {
        emit(PayFailure("لا يوجد حساب في هذا الرقم"));
        return;
      }
      double recipientBalance = recipientWalletSnapshot['balance'];

      DocumentSnapshot recipientSnapshot = await _firestore.collection('users').doc(recipientPhone).get();
      if (!recipientSnapshot.exists) {
        emit(PayFailure("المستلم غير موجود في قاعدة البيانات"));
        return;
      }
      String recipientName = recipientSnapshot['name'];

      await _firestore.collection('wallets').doc(senderPhone).update({
        'balance': senderBalance - amount,
      });
      await _firestore.collection('wallets').doc(recipientPhone).update({
        'balance': recipientBalance + amount,
      });

      await _firestore.collection('transactionLogs').add({
        'amount': amount,
        'transactionType': 'تحويل اموال',
        'date': Timestamp.now(),
      });

      Map<String, dynamic> transferData = {
        'senderPhone': recipientName,
        'recipientPhone': recipientPhone,
        'amount': amount,
        'date': Timestamp.now(),
      };

      emit(PaySuccess(transferData));
    } catch (e) {
      emit(PayFailure("فشل في إتمام التحويل: ${e.toString()}"));
    }
  }


  Future<void> payEducationalServices({
    required String studentName,
    required String studentId,
    required String universityAccount,
    required double amount,
    required String college,
    required String specialization,
  }) async
  {
    emit(PayLoading());
    try {
      final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.none)) {
        emit(PayFailure("لا يوجد اتصال بالإنترنت"));
        return;
      }
      DocumentSnapshot studentWalletSnapshot = await _firestore.collection('wallets').doc(studentId).get();
      if (!studentWalletSnapshot.exists) {
        emit(PayFailure("رقم الطال غير صحيح"));
        return;
      }
      double studentBalance = studentWalletSnapshot['balance'];
      if (studentBalance < amount) {
        emit(PayFailure("رقم الطال غير صحيح"));
        return;
      }

      await _firestore.collection('wallets').doc(studentId).update({
        'balance': studentBalance - amount,
      });

      await _firestore.collection('transactionLogs').add({
        'amount': amount,
        'transactionType': 'خدمات الجامعه',
        'date': Timestamp.now(),
      });

      Map<String, dynamic> transferData = {
        'studentName': studentName,
        'studentId': studentId,
        'universityAccount': universityAccount,
        'amount': amount,
        'college': college,
        'specialization': specialization,
        'date': Timestamp.now(),
      };

      emit(PaySuccess(transferData));
    } catch (e) {
      emit(PayFailure("فشل في إتمام الدفع: ${e.toString()}"));
    }
  }


  Future<void> rechargeBalance({
    required String phone,
    required double amount,
    required String userName,
  }) async
  {
    emit(PayLoading());
    try {
      final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.none)) {
        emit(PayFailure("لا يوجد اتصال بالإنترنت"));
        return;
      }
      String senderPhone = await SharePer.getData("userPhone");


      DocumentSnapshot walletSnapshot = await _firestore.collection('wallets').doc(senderPhone).get();
      if (!walletSnapshot.exists) {
        emit(PayFailure("لا يوجد حساب في هذا الرقم"));
        return;
      }
      double userBalance = walletSnapshot['balance'];
      if (userBalance < amount) {
        emit(PayFailure("الرصيد غير كافٍ لإتمام التحويل"));
        return;
      }
      await _firestore.collection('wallets').doc(senderPhone).update({
        'balance': userBalance - amount,
      });

      await _firestore.collection('transactionLogs').add({
        'amount': amount,
        'transactionType': 'شحن رصيد',
        'date': Timestamp.now(),
      });
      Map<String, dynamic> transferData = {
        'userName': userName,
        'recipientPhone': phone,
        'amount': amount,
        'date': Timestamp.now(),
      };

      emit(PaySuccess(transferData));
    } catch (e) {
      emit(PayFailure("فشل في إتمام الشحن: ${e.toString()}"));
    }
  }
}
