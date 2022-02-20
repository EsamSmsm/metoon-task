import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metoon_task/cubit/app_cubit.dart';
import 'package:metoon_task/screens/home_layout.dart';
import 'package:metoon_task/shared/components/custom_text_form_field.dart';
import 'package:metoon_task/shared/components/defaults.dart';
import 'package:metoon_task/shared/constants.dart';

import '../cubit/auth_cubit.dart';
import '../shared/components/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is SignUpSuccessState || state is LoginSuccessState) {
              navigateAndFinish(context, HomeLayout());
              AppCubit.get(context).isSigned = true;
            } else if (state is SignUpErrorState || state is LoginErrorState) {
              showToast(text: 'فشل التسجيل', color: Colors.red);
            }
          },
          builder: (context, state) {
            AuthCubit cubit = AuthCubit.get(context);
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'))),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: kBGColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: DefaultTabController(
                        length: 2,
                        initialIndex: 0,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xfff2ecde),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TabBar(
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Tajawal'),
                                unselectedLabelColor: kPrimaryColor,
                                indicator: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                labelColor: kSecondaryColor,
                                tabs: [
                                  Tab(
                                    text: 'تسجيل الدخول',
                                  ),
                                  Tab(
                                    text: 'انشاء حساب',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  LoginTab(
                                    cubit: cubit,
                                    state: state,
                                  ),
                                  SignUpTab(cubit: cubit, state: state),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: kSecondaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'أو سجل الدخول عبر',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: kSecondaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    cubit.signInWithGoogle();
                                  },
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/google.png'))),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cubit.signInWithFacebook();
                                  },
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/facebook .png'))),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
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

class SignUpTab extends StatelessWidget {
  const SignUpTab({
    Key key,
    this.cubit,
    this.state,
  }) : super(key: key);

  final AuthCubit cubit;
  final AuthStates state;
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    return Container(
      child: Column(
        children: [
          CustomTextFormField(
            hintText: 'البريد الالكتروني',
            controller: emailController,
          ),
          SizedBox(
            height: 20,
          ),
          CustomPasswordFormField(
            hintText: 'كلمة المرور',
            controller: passwordController,
          ),
          SizedBox(
            height: 20,
          ),
          CustomPasswordFormField(
            hintText: 'تأكيد كلمة المرور',
            controller: confirmPasswordController,
          ),
          SizedBox(
            height: 20,
          ),
          state is SignUpLoadingState
              ? CircularProgressIndicator(
                  color: kSecondaryColor,
                )
              : CustomButton(
                  text: 'انشاء حساب جديد',
                  onTap: () {
                    if (emailController.text.length == 0 ||
                        passwordController.text.length == 0) {
                      showToast(
                          text: 'تأكد من ملئ البيانات', color: Colors.red);
                    } else if (confirmPasswordController.text ==
                        passwordController.text) {
                      cubit.signUp(
                          email: emailController.text,
                          password: passwordController.text);
                    } else {
                      showToast(
                          text: 'كلمة المرور غير متطابقة', color: Colors.red);
                    }
                  },
                ),
        ],
      ),
    );
  }
}

class LoginTab extends StatelessWidget {
  const LoginTab({
    Key key,
    this.cubit,
    this.state,
  }) : super(key: key);

  final AuthCubit cubit;
  final AuthStates state;
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Container(
      child: Column(
        children: [
          CustomTextFormField(
            hintText: 'البريد الالكتروني',
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: 20,
          ),
          CustomPasswordFormField(
            hintText: 'كلمة المرور',
            controller: passwordController,
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Text(
                'نسيت كلمة المرور؟',
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          state is LoginLoadingState
              ? CircularProgressIndicator(
                  color: kSecondaryColor,
                )
              : CustomButton(
                  text: 'تسجيل الدخول',
                  onTap: () {
                    if (emailController.text.length == 0 ||
                        passwordController.text.length == 0) {
                      showToast(
                          text: 'تأكد من ملئ البيانات', color: Colors.red);
                    } else {
                      cubit.logIn(
                          email: emailController.text,
                          password: passwordController.text);
                    }
                  },
                ),
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              navigateTo(context, HomeLayout());
            },
            child: Text(
              'تسجيل الدخول لاحقا',
              style: TextStyle(
                  color: kSecondaryColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
