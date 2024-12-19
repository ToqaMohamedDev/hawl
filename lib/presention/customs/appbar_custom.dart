import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/bloc/auth/auth_cubit.dart';
import '../resorces/color_app.dart';
import '../resorces/routes_manager.dart';
import '../resorces/string_manager.dart';
import 'custom_text.dart';

AppBar appBarCustom(BuildContext context, String name) {
  return AppBar(
    scrolledUnderElevation: 0,
    elevation: 10,
    backgroundColor: ColorManager.appbarColor,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_outlined,
          color:ColorManager.whiteColor,
        )),
    centerTitle: true,
    title: CustomText(
      name: name,
      fontFa: AppStrings.fontFamily,
      fontWeight: FontWeight.bold,
      font: 16,
      color: ColorManager.whiteColor,
    ),
  );
}


AppBar appBarHome(BuildContext context, String name) {
  return AppBar(
    scrolledUnderElevation: 0,
    elevation: 10,
    backgroundColor: ColorManager.appbarColor,
    leading: Container(),
    centerTitle: true,
    actions: [
      BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(),
        child: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.exit_to_app,color: ColorManager.whiteColor,),
              onPressed: () async {
                await context.read<AuthCubit>().signOut();
                Navigator.pushReplacementNamed(context, Routes.loginRoute);
              },
            );
          },
        ),
      ),
    ],
    title: CustomText(
      name: name,
      fontFa: AppStrings.fontFamily,
      fontWeight: FontWeight.bold,
      font: 17,
      color: ColorManager.whiteColor,
    ),
  );
}
