import 'package:flutter/material.dart';
import 'package:metoon_task/models/faq.dart';
import 'package:metoon_task/shared/constants.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('الأسئلة الشائعة', style: TextStyle(color: kSecondaryColor)),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: kSecondaryColor),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => ExpansionTile(
                  collapsedIconColor: kPrimaryColor,
                  iconColor: kSecondaryColor,
                  title: Text(faqList[index]["question"],
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold)),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(faqList[index]["answer"],
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600)),
                    ),
                  ]),
          separatorBuilder: (context, index) => Divider(color: kSecondaryColor),
          itemCount: faqList.length),
    );
  }
}
