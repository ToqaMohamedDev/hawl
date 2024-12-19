import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:untitled/presention/customs/appbar_custom.dart';
import 'package:untitled/presention/customs/mediaquery.dart';

import '../resorces/color_app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: appBarHome(context, "حول"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            List<Map<String, String>> menuItems = [
              {
                'title': 'المعاملات',
                'image': 'assets/images/customization.svg',
                'route': '/pay_utilities',
              },
              {
                'title': 'خدمات جامعات',
                'image': 'assets/images/unver.svg',
                'route': '/pay_educational_services',
              },
              {
                'title': 'شحن رصيد',
                'image': 'assets/images/undraw_transfer-money_h9s3.svg',
                'route': '/recharge',
              },
              {
                'title': 'تحويل اموال',
                'image': 'assets/images/undraw_transfer-money_h9s3.svg',
                'route': '/transfer_money',
              },
            ];

            return _buildMenuItem(
              context,
              title: menuItems[index]['title']!,
              imagePath: menuItems[index]['image']!,
              onTap: () {
                Navigator.pushNamed(context, menuItems[index]['route']!);
              },
            );
          },
        ),
      ),
    );
  }


  Widget _buildMenuItem(BuildContext context,
      {required String title, required String imagePath, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: width(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SvgPicture.asset(
                imagePath,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: 4),

          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

}
