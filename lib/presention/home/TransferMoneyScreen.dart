import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/presention/customs/appbar_custom.dart';
import 'package:untitled/presention/resorces/routes_manager.dart';
import '../../data/bloc/pay/pay_cubit.dart';
import '../customs/need_bloc.dart';
import '../customs/textfield_custom.dart';
import '../resorces/color_app.dart';

class TransferMoneyScreen extends StatelessWidget {
  const TransferMoneyScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final accountNumberController = TextEditingController();
    final amountController = TextEditingController();
    return BlocProvider(
      create: (_) => PayCubit(),
      child: BlocConsumer<PayCubit, PayState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorManager.whiteColor,
            appBar: appBarCustom(context, 'تحويل مبلغ'),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 16),
                    CustomTextField(
                      textInputType:TextInputType.number ,
                      iconData: Icons.account_circle,
                      controller: accountNumberController,
                      hint: "رقم الحساب",
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      textInputType:TextInputType.number ,
                      iconData: Icons.monetization_on,
                      controller: amountController,
                      hint: "المبلغ",
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final recipientPhone =
                              accountNumberController.text; // رقم هاتف المستلم
                          final amount = double.tryParse(amountController.text) ?? 0.0; // المبلغ
                          context.read<PayCubit>().transferMoney(
                                recipientPhone: recipientPhone,
                                amount: amount,
                              );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.appbarColor,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'تحويل',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is PayLoading) {
            showDialog(
              context: context,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else if (state is PaySuccess) {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(
              context,
              Routes.succestransferRoute,
              arguments: state.transferData,
            );
            NeedBloc.showshowSnackBar('تم تحويل بنجاح');

          } else if (state is PayFailure) {
              Navigator.pop(context);
              NeedBloc.showshowSnackBar(state.errorMessage);
          }
        },
      ),
    );
  }
}
