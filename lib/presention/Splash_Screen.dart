import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/presention/customs/custom_text.dart';
import 'package:untitled/presention/customs/share_per.dart';
import 'package:untitled/presention/resorces/color_app.dart';
import 'package:untitled/presention/resorces/routes_manager.dart';

import '../data/bloc/auth/auth_cubit.dart';
import '../model/DataModel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
   @override
  void initState() {
     _timer=Timer(Duration(seconds: 3), _goNext);
    super.initState();
  }
  _goNext() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userName = await SharePer.getData("userName");
      String userPhone = await SharePer.getData("userPhone");
      userData['userName'] = userName;
      userData['userPhone'] = userPhone;
      Navigator.pushReplacementNamed(context, Routes.homeRoute);
    } else {
      Navigator.pushReplacementNamed(context, Routes.onboardingRoute);
    }
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
                child: Image.asset("assets/images/logo.png")),
           const SizedBox(height: 5,),
           CustomText(name: "حول", fontWeight: FontWeight.bold, font: 20)
          ],
        ),
      ),
    );
  }
}
