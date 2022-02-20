import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metoon_task/screens/register_screen.dart';
import 'package:metoon_task/shared/components/defaults.dart';
import 'package:metoon_task/shared/constants.dart';
import 'package:nil/nil.dart';

import '../cubit/app_cubit.dart';
import 'faq_screen.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey();

class HomeLayout extends StatelessWidget {
  HomeLayout({this.selectedIndex});
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, AppState state) {},
        builder: (context, AppState state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: _key,
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              elevation: 0,
              title: Text('حفاظ المتون',
                  style: TextStyle(
                      color: kSecondaryColor, fontWeight: FontWeight.bold)),
              iconTheme: IconThemeData(color: kSecondaryColor),
              leading: IconButton(
                icon:
                    Icon(Icons.menu_rounded, size: 30, color: kSecondaryColor),
                onPressed: () {
                  _key.currentState.openDrawer();
                },
              ),
              actions: [
                Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(Icons.search_rounded),
                    SizedBox(width: 10),
                    Icon(Icons.notifications),
                    SizedBox(width: 10),
                  ],
                )
              ],
            ),
            drawer: Drawer(
              backgroundColor: kBGColor,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.16,
                    color: kPrimaryColor,
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: kSecondaryColor,
                          radius: 25,
                          child: Icon(Icons.person,
                              color: kPrimaryColor, size: 40),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        cubit.isSigned
                            ? Text('')
                            : GestureDetector(
                                onTap: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                child: Text(
                                  'تسجيل الدخول',
                                  style: TextStyle(
                                      color: kSecondaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      children: [
                        DrawerTile(
                          icon: Icons.home,
                          color: kSecondaryColor,
                          label: 'الصفحة الرئيسية',
                        ),
                        DrawerTile(
                          icon: Icons.bookmark_border,
                          color: kPrimaryColor,
                          label: 'المحفوظات',
                        ),
                        DrawerTile(
                          icon: Icons.download_done_rounded,
                          color: kPrimaryColor,
                          label: 'التنزيلات',
                        ),
                        DrawerTile(
                          icon: Icons.settings,
                          color: kPrimaryColor,
                          label: 'الاعدادات',
                        ),
                        DrawerTile(
                          icon: Icons.info_outline,
                          color: kPrimaryColor,
                          label: 'عن التطبيق',
                        ),
                        DrawerTile(
                          icon: Icons.arrow_back_ios,
                          color: kPrimaryColor,
                          label: 'الأسئلة الشائعة',
                          onTap: () {
                            navigateTo(context, FAQScreen());
                          },
                        ),
                        DrawerTile(
                          icon: Icons.monetization_on_outlined,
                          color: kPrimaryColor,
                          label: 'ادعمنا',
                        ),
                        DrawerTile(
                          icon: Icons.star_border_rounded,
                          color: kPrimaryColor,
                          label: 'تقييم التطبيق',
                        ),
                        DrawerTile(
                          icon: Icons.person_add_alt,
                          color: kPrimaryColor,
                          label: 'انضم الى فريقنا',
                        ),
                        DrawerTile(
                          icon: Icons.share_outlined,
                          color: kPrimaryColor,
                          label: 'شارك التطبيق',
                        ),
                        DrawerTile(
                          icon: Icons.headset_mic_rounded,
                          color: kPrimaryColor,
                          label: 'الدعم الفني',
                        ),
                        cubit.isSigned
                            ? DrawerTile(
                                icon: Icons.logout,
                                color: kPrimaryColor,
                                onTap: () {
                                  navigateAndFinish(context, RegisterScreen());
                                  cubit.isSigned = false;
                                },
                                label: 'تسجيل الخروج',
                              )
                            : nil,
                      ],
                    ),
                  )
                ],
              ),
            ),
            body: IndexedStack(
              children: cubit.screens,
              index: cubit.selectedIndex,
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 1, spreadRadius: 0.8),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                child: Container(
                  height: 70,
                  child: BottomNavigationBar(
                    backgroundColor: kBGColor,
                    currentIndex: cubit.selectedIndex,
                    type: BottomNavigationBarType.fixed,
                    onTap: (value) {
                      cubit.changeNavBar(value);
                    },
                    elevation: 10,
                    unselectedFontSize: 13,
                    selectedFontSize: 13,
                    unselectedItemColor: kPrimaryColor,
                    fixedColor: kSecondaryColor,
                    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: ' الرئيسية ',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.fact_check_outlined),
                        label: ' الورد اليومي ',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.menu_book_sharp),
                        label: ' قائمة المتون ',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.bookmark_border_outlined),
                        label: ' المحفوظات ',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    Key key,
    this.color,
    this.label,
    this.icon,
    this.onTap,
  }) : super(key: key);

  final Color color;
  final String label;
  final IconData icon;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 25),
                SizedBox(
                  width: 10,
                ),
                Text(
                  label,
                  style: TextStyle(
                      color: color, fontWeight: FontWeight.bold, fontSize: 17),
                )
              ],
            ),
          ),
          Divider(
            color: kSecondaryColor,
          ),
        ],
      ),
    );
  }
}
