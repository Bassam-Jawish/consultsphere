import 'package:consultsphere/config/theme/colors.dart';
import 'package:consultsphere/features/chat/presentation/pages/messages_page.dart';
import 'package:consultsphere/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

List<PersistentBottomNavBarItem> bottomItems(context) {
  var theme = Theme.of(context).colorScheme;
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.home,
        size: 26,
      ),
      title: 'Home',
      activeColorPrimary: theme.primary,
      inactiveColorPrimary: AppColor.gray500,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.message,
        size: 26,
      ),
      title: 'Messages',
      activeColorPrimary: theme.primary,
      inactiveColorPrimary: AppColor.gray500,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.event,
        size: 26,
      ),
      title: 'Appointment',
      activeColorPrimary: theme.primary,
      inactiveColorPrimary: AppColor.gray500,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.person,
        size: 26,
      ),
      title: 'Profile',
      activeColorPrimary: theme.primary,
      inactiveColorPrimary: AppColor.gray500,
    ),
  ];
}

List<Widget> screens = const [
  HomePage(),
  MessagesPage(),
  HomePage(),
  HomePage(),
  //SearchPage(),
  //LoyalityPage(),
  //OrdersPage(),
  //SettingsPage(),
];
