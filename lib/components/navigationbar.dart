import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_hekmat/home/addpost_page.dart';
import 'package:senior_hekmat/home/home_page.dart';
import 'package:senior_hekmat/profile/profile_user.dart';

import '../auth_page.dart/provider/provider.dart';
import '../models/user.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
   final items = const [
    Icon(
      Icons.home,
      size: 30,
    ),
    Icon(
      Icons.add,
      size: 50,
    ),
    Icon(
      Icons.person,
      size: 30,
    ),

  ];
  int index = 0;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() async {
    UserProvider userprovider = Provider.of(context, listen: false);
    await userprovider.refreshUser();
  }

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage();

  @override
  Widget build(BuildContext context) {



    return 
    Scaffold(
      backgroundColor: Colors.orange,
      
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor:  Colors.orange,
        items: items,
        index: index,
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
            
          });
        },
        height: 67,
        
        animationDuration: const Duration(milliseconds: 300),
        
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: getSelectedWidget(index: index),
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
      switch (index) {
      case 0:
        widget = const HomePage();
        break;
      case 1:
        widget =  const AddPost();
        break;
      case 2:
        widget = const PorfileUser();
        break;
      default:
        widget = const HomePage();
        break;
    }
    return widget;
  }
}
