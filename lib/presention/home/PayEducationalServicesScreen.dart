import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/presention/customs/need_bloc.dart';

import '../../data/bloc/pay/pay_cubit.dart';
import '../customs/appbar_custom.dart';
import '../customs/custom_drop_menu.dart';
import '../customs/textfield_custom.dart';
import '../resorces/color_app.dart';
import '../resorces/routes_manager.dart';

class PayEducationalServicesScreen extends StatelessWidget {
  const PayEducationalServicesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TextEditingController studentNameController = TextEditingController();
    final TextEditingController studentIdController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    final TextEditingController collegeController = TextEditingController();
    final TextEditingController specializationController = TextEditingController();
    final List<String> universities = [
      'جامعة الخرطوم',
      'جامعة الجزيرة',
      'جامعة الزعيم الأزهري',
      'جامعة النيلين',
      'جامعة السودان',
      'جامعة كرري',
      'جامعة الإمام الهادي',
      'جامعة قاردن سيتي',
      'جامعة الأحفاد',
      'جامعة إبن سينا',
    ];

    return BlocProvider(
      create: (_)=>PayCubit(),
      child: BlocConsumer<PayCubit, PayState>(
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
              Routes.succeseducationRoute,
              arguments: state.transferData,
            );
            NeedBloc.showshowSnackBar('تم تحويل بنجاح');

          } else if (state is PayFailure) {
            Navigator.pop(context);
            NeedBloc.showshowSnackBar(state.errorMessage);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorManager.whiteColor,
            appBar: appBarCustom(context, 'دفع خدمات جامعات ومدارس'),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: studentNameController,
                      hint: "اسم الطالب",
                      iconData: Icons.person,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: studentIdController,
                      hint: "ID الطالب",
                      iconData: Icons.perm_identity,
                    ),
                    const SizedBox(height: 16),
                    CustomDropDownMenu(
                      items: universities,
                      name: "اسم الجامعه",
                      selectedValue: PayCubit.get(context).selectedUniversity,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: amountController,
                      hint: "المبلغ",
                      iconData: Icons.money,
                      textInputType: TextInputType.number,

                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: collegeController,
                      hint: "الكلية",
                      iconData: Icons.school,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: specializationController,
                      hint: "التخصص",
                      iconData: Icons.book,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final String studentName = studentNameController.text;
                          final String studentId = studentIdController.text;

                          final String amount = amountController.text;
                          final String college = collegeController.text;
                          final String specialization = specializationController.text;

                          if (studentName.isEmpty ||
                              studentId.isEmpty ||
                              amount.isEmpty ||
                              college.isEmpty ||
                              specialization.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('يرجى ملء جميع الحقول')),
                            );
                            return;
                          }

                          context.read<PayCubit>().payEducationalServices(
                            studentName:studentName ,
                            studentId: studentId,
                            universityAccount: PayCubit.get(context).selectedUniversity!,
                            amount: double.parse(amount),
                            college: college,
                            specialization: specialization,
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
      ),
    );
  }
}
