import 'package:flutter/material.dart';
import 'package:untitled/presention/auth/login_screen.dart';
import 'package:untitled/presention/auth/sgnup_screen.dart';
import 'package:untitled/presention/home/home_screen.dart';
import 'package:untitled/presention/home/success_education.dart';
import 'package:untitled/presention/home/success_recharge.dart';
import 'package:untitled/presention/home/success_transfer.dart';
import 'package:untitled/presention/onboarding/onboarding_screen.dart';
import 'package:untitled/presention/resorces/string_manager.dart';
import '../Splash_Screen.dart';
import '../home/PayEducationalServicesScreen.dart';
import '../home/PayTransactionsScreen.dart';
import '../home/RechargeScreen.dart';
import '../home/TransferMoneyScreen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onboardingRoute = "/onboarding";
  static const String loginRoute = "/login";
  static const String signupRoute = "/signup";
  static const String homeRoute = "/home";
  static const String transferMoneyRoute = "/transfer_money";
  static const String payEducationalServicesRoute = "/pay_educational_services";
  static const String rechargeRoute = "/recharge";
  static const String payUtilitiesRoute = "/pay_utilities";
  static const String succestransferRoute = "/succestransfer";
  static const String succeseducationRoute = "/succeseducation";
  static const String succesRechargeRoute = "/succesrecharge";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.signupRoute:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case Routes.transferMoneyRoute:
        return MaterialPageRoute(builder: (_) => const TransferMoneyScreen());
      case Routes.payEducationalServicesRoute:
        return MaterialPageRoute(builder: (_) => const PayEducationalServicesScreen());
      case Routes.rechargeRoute:
        return MaterialPageRoute(builder: (_) => const RechargeScreen());
      case Routes.payUtilitiesRoute:
        return MaterialPageRoute(builder: (_) => const PayTransactionsScreen());

      case Routes.succestransferRoute:
        final arguments = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(builder: (_) => SuccessTransfer(arguments: arguments,));

      case Routes.succeseducationRoute:
        final arguments = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(builder: (_) =>  SuccessEducation(arguments: arguments));

      case Routes.succesRechargeRoute:
        final arguments = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(builder: (_) =>  SuccessRecharge(arguments: arguments));

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.noRouteFound),
          ),
          body: const Center(child: Text(AppStrings.noRouteFound)),
        ));
  }
}
