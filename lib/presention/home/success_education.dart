import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/presention/customs/appbar_custom.dart';
import '../customs/custom_text.dart';
import 'package:intl/intl.dart' as intl;

class SuccessEducation extends StatelessWidget {
  final Map<String, dynamic>? arguments;

  const SuccessEducation({Key? key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final studentName = arguments?['studentName'] ?? "غير متوفر";
    final studentId = arguments?['studentId'] ?? "غير متوفر";
    final accountNumber = arguments?['universityAccout'] ?? "121212";
    final amount = arguments?['amount'] ?? "غير متوفر";
    final faculty = arguments?['college'] ?? "غير متوفر";
    final specialization = arguments?['specialization'] ?? "غير متوفر";
    final Timestamp transactionDate = arguments?['date'] ?? Timestamp.now();
    String formattedDate = intl.DateFormat('yyyy/MM/dd HH:mm').format(transactionDate.toDate());
    return Scaffold(
      appBar: appBarCustom(context, 'نجاح العملية'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // لون مختلف
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      name: "اسم الطالب: $studentName",
                      fontWeight: FontWeight.bold,
                      font: 18,
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      name: "ID الطالب: $studentId",
                      fontWeight: FontWeight.bold,
                      font: 18,
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      name: "رقم الحساب: $accountNumber",
                      fontWeight: FontWeight.bold,
                      font: 18,
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      name: "المبلغ: $amount جنيه",
                      fontWeight: FontWeight.bold,
                      font: 18,
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      name: "الكلية: $faculty",
                      fontWeight: FontWeight.bold,
                      font: 18,
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      name: "التخصص: $specialization",
                      fontWeight: FontWeight.bold,
                      font: 18,
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      name: "التاريخ والوقت: $formattedDate",
                      fontWeight: FontWeight.bold,
                      font: 18,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // زر تأكيد التحويل
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 50,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
