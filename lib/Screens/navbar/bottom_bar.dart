// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, sort_child_properties_last

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_auth/charts/statistics.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:side_bar_custom/side_bar_custom.dart';

import 'package:flutter_auth/Screens/Myprop/myprop.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/Screens/addpage/add.dart';
import 'package:flutter_auth/Screens/chatspage/chatspage.dart';
import 'package:flutter_auth/Screens/contactpage/contact.dart';
import 'package:flutter_auth/Screens/homepage/home.dart';
import 'package:flutter_auth/Screens/notification/notificationView.dart';
import 'package:flutter_auth/Screens/notification/notification_service.dart';
import 'package:flutter_auth/Screens/profilepage/profile.dart';
import 'package:flutter_auth/Screens/profilepage/utils/user_preferences.dart';
import 'package:flutter_auth/Screens/savedItemspage/save.dart';
import 'package:flutter_auth/Screens/searchpage/search.dart';
import 'package:flutter_auth/components/lang.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/SignUpData.dart';
import 'package:flutter_auth/locale/locale_controller.dart';
import 'package:flutter_auth/responsive.dart';
import 'package:flutter_auth/services/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomBar(),
    );
  }
}

class CustomIcon extends StatelessWidget {
  final Image image;
  final double size;
  final Color color;

  CustomIcon(
      {required this.image, this.size = 24.0, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: image,
      ),
    );
  }
}

class BottomBar extends StatefulWidget {
  @override
  String? email;
  BottomBar({
    Key? key,
    this.email,
  }) : super(key: key);
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  String selectedOption = 'Nablus';
  int index = 2;

  final _advancedDrawerController = AdvancedDrawerController();
  MylocalController Controllerlang = Get.find();
  final screens = [
    savepage(),
    searchpage(),
    homepage(),
    addpage(),
    contactpage(),
  ];

  int selected = 0;
  bool isVisible = true;
  int activeTab = 0;

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<Services>(context).userRes;
    final image;
    if (user!.image != null) {
      image = NetworkImage("http://192.168.68.51:8083${user.image}");
    } else {
      image = const AssetImage("assets/images/userAvatar.png");
    }
    Get.put(MylocalController());

    final items = <Widget>[
      const Icon(
        Icons.bookmark,
        size: 35,
      ),
      const Icon(
        Icons.search_sharp,
        size: 35,
      ),
      const Icon(
        Icons.home,
        size: 35,
      ),
      const Icon(
        Icons.add,
        size: 35,
      ),
      const Icon(
        Icons.phone,
        size: 35,
      ),
    ];

    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [kPrimaryColor, kPrimaryColor.withOpacity(0.2)],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: isEnglish ? false : true,
      childDecoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        body: Responsive(
          mobile: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.white.withOpacity(0.9),
              elevation: 0,
              leading: IconButton(
                onPressed: _handleMenuButtonPressed,
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: _advancedDrawerController,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: value.visible
                            ? Icon(
                                Icons.clear,
                                color: kPrimaryColor,
                                key: ValueKey<bool>(value.visible),
                                size: 30,
                              )
                            : Icon(
                                Icons.filter_list_outlined,
                                color: kPrimaryColor,
                                key: ValueKey<bool>(value.visible),
                                size: 30,
                              ));
                  },
                ),
              ),
              flexibleSpace: Center(
                child: Container(
                  width: 100,
                  margin: EdgeInsets.only(top: 20),
                ),
              ),
              actions: [
                Container(
                  // color: Colors.amber,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.notifications,
                          size: 30,
                        ),

                        color: kPrimaryColor, // Example: A notification icon
                        onPressed: () {
                          // NotificationService.showNotification(
                          //     title: "Title of the notification",
                          //     body: "Body of the notification",
                          //     payload: {
                          //       "navigate": "true",
                          //     },
                          //     actionButtons: [
                          //       NotificationActionButton(
                          //         key: 'check',
                          //         label: 'Check it out',
                          //         actionType: ActionType.SilentAction,
                          //         color: kPrimaryColor,
                          //       )
                          //     ]);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            extendBody: true,
            body: SafeArea(
              child: screens[index],
            ),
            bottomNavigationBar: Theme(
              data: Theme.of(context)
                  .copyWith(iconTheme: IconThemeData(color: kPrimaryColor)),
              child: CurvedNavigationBar(
                height: 60,
                animationCurve: Curves.easeInOut,
                animationDuration: Duration(milliseconds: 400),
                items: items,
                index: index,
                color: kPrimaryLightColor,
                backgroundColor: Colors.transparent,
                onTap: (int tappedIndex) {
                  if (mounted)
                    setState(() {
                      index = tappedIndex;
                    });
                },
              ),
            ),
          ),
          desktop: Scaffold(
            body: SideBar(
              config: SideBarConfig(
                enablePageView: true,
                backgroundColor: kPrimaryLightColor,
                bottomIconColor: kPrimaryColor,
                dividerColor: kPrimaryColor,
                selectedBoxColor: kPrimaryColor,
                selectedIconColor: kPrimaryLightColor,
                unselectedBoxColor: kPrimaryLightColor,
                unselectedIconColor: kPrimaryColor,
                dividerIndent: 10,
                fontSize: 20,
                iconSize: 30,
                selectedTextStyle: TextStyle(color: kPrimaryLightColor),
                unselectedTextStyle: TextStyle(color: kPrimaryColor),
              ),
              children: [
                Center(child: homepage()),
                Center(
                  child: addpage(),
                ),
                Center(
                  child: searchpage(),
                ),
                Center(
                  child: savepage(),
                ),
                Center(
                  child: contactpage(),
                ),
              ],
              items: [
                SideBarItem(
                  text: "HomePage".tr,
                  icon: Icons.home,
                  //tooltipText: "Dashboard page",
                ),
                SideBarItem(
                  text: "AddProparity".tr,
                  icon: Icons.add,
                ),
                SideBarItem(
                  text: "Search".tr,
                  icon: Icons.search,
                ),
                SideBarItem(
                  text: "SavedProparites".tr,
                  icon: Icons.bookmark,
                ),
                SideBarItem(
                  text: "ContactUs".tr,
                  icon: Icons.phone,
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: Ink.image(
                      image: image,
                      fit: BoxFit.cover,
                      width: 128,
                      height: 128,
                      child: InkWell(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return profilepage();
                        },
                      ),
                    );
                  },
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('Profile'.tr),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return chatspage();
                        },
                      ),
                    );
                  },
                  leading: Icon(Icons.chat),
                  title: Text('My Chats'.tr),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return NotificationView();
                        },
                      ),
                    );
                  },
                  leading: Icon(Icons.notifications),
                  title: Text('Notifications'.tr),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Myproperties();
                        },
                      ),
                    );
                  },
                  leading: Icon(Icons.home),
                  title: Text('Myproperties'.tr),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Statistics();
                        },
                      ),
                    );
                  },
                  leading: Icon(Icons.auto_graph),
                  title: Text('Statistics'.tr),
                ),
                ListTile(
                  onTap: () {
                    toggleLanguage();
                  },
                  leading: Icon(Icons.language),
                  title: Text(
                    buttonText,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  void toggleLanguage() {
    setState(() {
      isEnglish = !isEnglish;
      buttonText = isEnglish ? 'English' : 'العربية';
      if (isEnglish) {
        Controllerlang.changeLang("en");
      } else {
        Controllerlang.changeLang("ar");
      }
    });
  }
}
