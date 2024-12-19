import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/presention/customs/appbar_custom.dart';
import 'package:untitled/presention/customs/need_bloc.dart';
import 'package:untitled/presention/resorces/color_app.dart';
import 'package:untitled/presention/resorces/routes_manager.dart';
import '../../data/bloc/pay/pay_cubit.dart';
import '../customs/custom_drop_menu.dart';
import '../customs/textfield_custom.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({Key? key}) : super(key: key);
  @override
  _RechargeScreenState createState() => _RechargeScreenState();
}
class _RechargeScreenState extends State<RechargeScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  List<String> telecomCompanies = [
    'Sudani',
    'MTN',
    'Zain',
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PayCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarCustom(context, 'شحن رصيد'),
        body: BlocConsumer<PayCubit, PayState>(
          listener: (context, state) {
            if (state is PayLoading) {
              showDialog(
                context: context,
                builder: (_) => const Center(child: CircularProgressIndicator()),
              );
            } else if (state is PaySuccess) {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, Routes.succesRechargeRoute,arguments: state.transferData);
              NeedBloc.showshowSnackBar("تم شحن الرصيد بنجاح!");
            } else if (state is PayFailure) {

              NeedBloc.showshowSnackBar(state.errorMessage);
            }
          },
          builder: (context, state) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    CustomDropDownMenu(
                      items: telecomCompanies,
                      name: "اسم الجامعه",
                      selectedValue: PayCubit.get(context).selectedCompanies,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: phoneController,
                      hint: "رقم الهاتف",
                      iconData: Icons.phone,
                      textInputType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: amountController,
                      hint: "المبلغ",
                      textInputType: TextInputType.number,
                      iconData: Icons.monetization_on,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        String phone = phoneController.text;
                        double? amount = double.tryParse(amountController.text);

                        if (phone.isEmpty || amount == null || amount <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("الرجاء إدخال رقم الهاتف والمبلغ بشكل صحيح")),
                          );
                          return;
                        }
                        PayCubit.get(context).rechargeBalance(
                          phone: phone,
                          amount: amount,
                          userName: PayCubit.get(context).selectedCompanies,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.appbarColor,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'شحن الرصيد',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// دالة شحن الرصيد في PayCubit
