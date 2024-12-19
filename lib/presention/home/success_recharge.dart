import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/presention/customs/appbar_custom.dart';
import 'package:intl/intl.dart' as intl;
import '../customs/custom_text.dart';

class SuccessRecharge extends StatelessWidget {
  final Map<String, dynamic>? arguments;
  const SuccessRecharge({Key? key, this.arguments}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String userName = arguments?['userName'] ?? 'اسم المستخدم غير محدد';
    final String recipientPhone = arguments?['recipientPhone'] ?? 'رقم الهاتف غير محدد';
    final double amount = arguments?['amount'] ?? 0.0;
    final Timestamp transactionDate = arguments?['date'] ?? Timestamp.now();
    String formattedDate = intl.DateFormat('yyyy/MM/dd HH:mm').format(transactionDate.toDate());
    return Scaffold(
      appBar: appBarCustom(context, "نجاح الشحن"),
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
                  color: Colors.grey[200], // خلفية مخصصة
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      name: "اسم الشركة: $userName",
                      fontWeight: FontWeight.bold,
                      font: 18,
                    ),
                    const SizedBox(height: 8.0),
                    CustomText(
                      name: "رقم الهاتف: $recipientPhone",
                      fontWeight: FontWeight.normal,
                      font: 16,
                    ),
                    const SizedBox(height: 8.0),
                    CustomText(
                      name: "المبلغ: $amount جنيه",
                      fontWeight: FontWeight.normal,
                      font: 16,
                    ),
                    const SizedBox(height: 8.0),
                    CustomText(
                      name: "التاريخ: $formattedDate",
                      fontWeight: FontWeight.normal,
                      font: 16,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
