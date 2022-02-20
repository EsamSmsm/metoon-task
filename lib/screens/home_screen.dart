import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metoon_task/cubit/app_cubit.dart';
import 'package:metoon_task/shared/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGColor,
      body: SingleChildScrollView(
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.16,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            'الاحتفاظ بما في صدرك أولى من درس ما في الكتب',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                                fontSize: 16),
                          ),
                        ),
                        Text(
                          'الخليل ابن أحمد',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kSecondaryColor),
                        )
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(25)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.28,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 1)
                          ]),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'مرحبا بك في حفاظ المتون',
                                style: TextStyle(
                                    color: kSecondaryColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'احرص علي الا يخلو يومك من حفظ أو مراجعة ولو بيت واحد أو بيتين فانك تجد ثمرته مع مرور الوقت.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                wordSpacing: 2,
                                height: 1.5,
                                fontSize: 15,
                                color: kPrimaryColor),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width * 0.40,
                                decoration: BoxDecoration(
                                    color: kSecondaryColor,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: kPrimaryColor,
                                    ),
                                    Text(
                                      'خطة جديدة',
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      left: -5,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/books.png'),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                cubit.isSigned
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: kSecondaryColor,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'أوراد اليوم',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20,
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
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.18,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.20,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          padding: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 1)
                                              ]),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'العقيدة الطحاوية',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: kPrimaryColor),
                                                  ),
                                                  Icon(
                                                    Icons.more_horiz_rounded,
                                                    color: kSecondaryColor,
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text('ورد اليوم : 8 أسطر',
                                                      style: TextStyle(
                                                          color: kPrimaryColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 3,
                                                      decoration: BoxDecoration(
                                                        color: kSecondaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '12.00 %',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(),
                                  itemCount: 4)),
                          SizedBox(
                            height: 30,
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
                                width: 20,
                              ),
                              Text(
                                'الانجازات',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20,
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
                            height: 100,
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'قم بتسجيل الدخول لتتمكن من الحفظ و اضافة الأوراد',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ],
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
