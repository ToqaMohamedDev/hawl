import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/data/bloc/auth/auth_cubit.dart'; // استيراد الـ AuthCubit
import 'package:untitled/presention/customs/custom_outlinebottom.dart';
import 'package:untitled/presention/customs/custom_text.dart';
import 'package:untitled/presention/customs/textfield_custom.dart';
import 'package:untitled/presention/resorces/routes_manager.dart';
import '../resorces/color_app.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String gender = '';
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ColorManager.whiteColor,
        body: Center(
          child: BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(),
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
              builder: (context, state) {
                return ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    Center(
                      child: CustomText(
                        name: 'إنشاء حساب',
                        fontWeight: FontWeight.bold,
                        font: 22,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      iconData: Icons.person,
                      controller: nameController,
                      hint: "الاسم",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      iconData: Icons.phone,
                      controller: phoneController,
                      hint: "رقم الهاتف",
                    ),
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null && picked != selectedDate) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          selectedDate == null
                              ? "اختر تاريخ الميلاد"
                              : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            value: "ذكر",
                            groupValue: gender,
                            title: const Text("ذكر"),
                            activeColor: Colors.blue,
                            onChanged: (value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            value: "أنثى",
                            groupValue: gender,
                            title: const Text("أنثى"),
                            activeColor: Colors.blue,
                            onChanged: (value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    CustomOutLineWithIcon(
                      name: "إنشاء حساب",
                      iconData: Icons.app_registration,
                      onPressed: () {
                        if (nameController.text.isNotEmpty &&
                            phoneController.text.isNotEmpty &&
                            emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty &&
                            gender.isNotEmpty &&
                            selectedDate != null) {
                          context.read<AuthCubit>().signUp(
                            name: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            birthDate: selectedDate!,
                            gender: gender,
                          );
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
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: CustomText(
                          name: 'لديك حساب؟ تسجيل الدخول',
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
