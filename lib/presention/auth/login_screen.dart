import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/presention/customs/custom_text.dart';  // استيراد مكونات الواجهة
import 'package:untitled/presention/customs/custom_outlinebottom.dart';
import 'package:untitled/presention/customs/textfield_custom.dart';
import 'package:untitled/presention/resorces/color_app.dart';
import 'package:untitled/presention/resorces/routes_manager.dart';

import '../../data/bloc/auth/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Directionality(
       textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ColorManager.whiteColor,
        body: Center(
          child: BlocProvider<AuthCubit>(
            create: (_) => AuthCubit(),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(child: CircularProgressIndicator()),
                  );
                } else if (state is AuthSuccess) {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, Routes.splashRoute);
                } else if (state is AuthFailure) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context,  state) {
                return  ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    Center(
                      child: CustomText(
                        name: 'تسجيل الدخول',
                        fontWeight: FontWeight.bold,
                        font: 22,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      iconData: Icons.email,
                      controller: emailController,
                      hint: "البريد الإلكتروني",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      iconData: Icons.password,
                      controller: passwordController,
                      hint: "كلمة المرور",

                    ),
                    const SizedBox(height: 30),
                    CustomOutLineWithIcon(
                      name: "تسجيل الدخول",
                      iconData: Icons.login,
                      onPressed: () {
                        final email = emailController.text;
                        final password = passwordController.text;

                        if (email.isNotEmpty && password.isNotEmpty) {
                          context.read<AuthCubit>().signInWithEmailPassword(
                              email, password);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("من فضلك أكمل جميع الحقول")),
                          );
                        }
                      },
                      color: Colors.black,
                      colorr: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup'); // الانتقال لشاشة التسجيل
                      },
                      child: Center(
                        child: CustomText(
                          name: 'ليس لديك حساب؟ إنشاء حساب',
                          fontWeight: FontWeight.w400,
                          font: 16,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
