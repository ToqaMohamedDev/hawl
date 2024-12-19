import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' as intl;
import 'package:untitled/presention/customs/appbar_custom.dart';
import '../../model/DataModel.dart';
import '../customs/custom_text.dart';
import '../resorces/color_app.dart';

class PayTransactionsScreen extends StatelessWidget {
  const PayTransactionsScreen({Key? key}) : super(key: key);

  Future<double> fetchBalance(String userId) async {
    final docSnapshot = await FirebaseFirestore.instance.collection('wallets').doc(userId).get();
    if (docSnapshot.exists) {
      return docSnapshot['balance'] ?? 0.0;
    } else {
      return 0.0;
    }
  }
  Future<List<QueryDocumentSnapshot>> fetchTransactions() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('transactionLogs')
        .orderBy('date', descending: true)
        .get();
    return snapshot.docs;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: appBarCustom(context, 'المعاملات'),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              FutureBuilder<double>(
                future: fetchBalance(userData['userPhone']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text("حدث خطأ في جلب الرصيد"));
                  }
                  final balance = snapshot.data ?? 0.0;
                  return CustomText(
                    name: "الرصيد: ${balance.toString()} جنيه",
                    fontWeight: FontWeight.bold,
                    font: 16,
                  );
                },
              ),
              const SizedBox(height: 20),
              CustomText(
                name: "الاسم: ${userData['userName']}",
                fontWeight: FontWeight.bold,
                font: 16,
              ),
              const SizedBox(height: 20),
              CustomText(
                name: "رقم الحساب: ${userData['userPhone']}",
                fontWeight: FontWeight.bold,
                font: 16,
              ),
              const SizedBox(height: 40),
              CustomText(
                name: "العمليات",
                fontWeight: FontWeight.bold,
                font: 20,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<QueryDocumentSnapshot>>(
                  future: fetchTransactions(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text("حدث خطأ"));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("لا توجد معاملات"));
                    }
                    final transactions = snapshot.data!;
                    return ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = transactions[index];
                        final amount = transaction['amount'];
                        final transactionType = transaction['transactionType'];
                        final date = (transaction['date'] as Timestamp).toDate();
                        String formattedDate = intl.DateFormat('dd/MM/yyyy').format(date);
                        return ListTile(
                          title: Text(
                            "$transactionType",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "المبلغ: $amount",
                          ),
                          onTap: () {},
                          trailing: Text('$formattedDate'),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
