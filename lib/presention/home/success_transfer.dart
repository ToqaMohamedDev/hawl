import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/presention/customs/appbar_custom.dart';
import '../customs/custom_text.dart';
import 'package:intl/intl.dart' as intl;

class SuccessTransfer extends StatelessWidget {
  final Map<String, dynamic>? arguments;
  const SuccessTransfer({Key? key, this.arguments}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final senderPhone = arguments?['senderPhone'] ?? "غير محدد";
    final recipientPhone = arguments?['recipientPhone'] ?? "غير محدد";
    final amount = arguments?['amount'] ?? 0.0;
    final Timestamp transactionDate = arguments?['date'] ?? Timestamp.now();
    String formattedDate = intl.DateFormat('yyyy/MM/dd HH:mm').format(transactionDate.toDate());
    return Scaffold(
      appBar: appBarCustom(context, 'نجاح التحويل'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      name: "التحويل من: $senderPhone",
                      fontWeight: FontWeight.bold,
                      font: 18,
                    ),
                    const SizedBox(height: 16),
                    CustomText(
                      name: "رقم الحساب المستلم: $recipientPhone",
                      fontWeight: FontWeight.bold,
                      font: 18,
                    ),
                    const SizedBox(height: 16),
                    CustomText(
                      name: "المبلغ: $amount جنيه",
                      fontWeight: FontWeight.bold,
                      font: 18,
                    ),
                    const SizedBox(height: 16),
                    CustomText(
                      name: "التاريخ والوقت: ${formattedDate}",
                      fontWeight: FontWeight.bold,
                      font: 18,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
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
