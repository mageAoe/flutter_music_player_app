import 'package:flutter/material.dart';
import './app_theme.dart';
import './home_screen.dart';
import 'custom_drawer/drawer_user_controller.dart';

class NavigationHomeScreen extends StatefulWidget {
  const NavigationHomeScreen({super.key});

  @override
  State<NavigationHomeScreen> createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: const SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            // screenIndex: drawerIndex,
            // drawerWidth: MediaQuery.of(context).size.width * 0.75,
            // onDrawerCall: (DrawerIndex drawerIndexdata) {
            //   changeIndex(drawerIndexdata);
            //   //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            // },
            screenView: MyHomePage(title: 'my flutter music player'),
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }
}