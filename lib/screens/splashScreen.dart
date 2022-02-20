import 'package:flutter/material.dart';
import 'package:metoon_task/screens/register_screen.dart';
import 'package:metoon_task/shared/components/defaults.dart';
import 'package:metoon_task/shared/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 3),
      () => navigateTo(context, RegisterScreen()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: kPrimaryColor,
        child: Center(
            child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/images/logo.png'))),
        )),
      ),
    );
  }
}
