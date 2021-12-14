import 'package:dot_safety/app/ui/pages/dashboard/home.dart';
import 'package:dot_safety/app/ui/pages/dashboard/search.dart';
import 'package:dot_safety/app/ui/pages/profile/profile.dart';
import 'package:dot_safety/app/ui/pages/vehicle/vehicle_document.dart';
import 'package:dot_safety/app/ui/pages/notification/notification.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    SearchScreen(),
    VehicleDocument(),
    NotificationList(),
    Profile(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // This is all you need!
          onTap: onTabTapped,
          iconSize: 28,
          backgroundColor: AppColors.whiteColor,
          selectedLabelStyle: TextStyle(color: AppColors.appPrimaryColor),
          selectedItemColor: AppColors.appPrimaryColor,
          unselectedLabelStyle: TextStyle(color: AppColors.color3),
          unselectedItemColor: AppColors.color3,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home,),
              title: new Text('',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Montserrat Regular',
                  fontSize: 0.0,
                ),),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.search,),
              title: new Text('',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Montserrat Regular',
                  fontSize: 0.0,
                ),),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.document_scanner,),
              title: new Text('',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Montserrat Regular',
                  fontSize: 0.0,
                ),),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active,),
                title: Text('',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Montserrat Regular',
                    fontSize: 0.0,
                  ),)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Montserrat Regular',
                    fontSize: 0.0,
                  ),)
            ),
          ],
        ),
      body: _children[_currentIndex], // new
    );
  }
}


