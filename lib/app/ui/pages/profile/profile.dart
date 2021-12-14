import 'package:dot_safety/app/ui/pages/profile/offence_view.dart';
import 'package:dot_safety/app/ui/pages/profile/profile_account.dart';
import 'package:dot_safety/app/ui/pages/profile/saved.dart';
import 'package:dot_safety/app/ui/pages/profile/ticket_view.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(DeviceUtils.getScaledHeight(context,scale: 0.16)),
            child: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: AppColors.secondaryColor,
              flexibleSpace: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.06),
                    ),
                    Text(
                      Strings.accounts,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Montserrat Bold',
                        color: AppColors.whiteColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),
                  ],
                ),
              ),
              bottom: const TabBar(
                indicatorWeight: 1,
                isScrollable: true,
                unselectedLabelColor: AppColors.whiteColor,
                unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.appPrimaryColor
                ),
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide.none,
                  ),
                ),
                labelColor: AppColors.appPrimaryColor,
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat Bold'
                ),
                tabs: [
                  Tab(
                      child: Text("Profile",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            fontFamily: 'Montserrat Regular',
                          )
                      )
                  ),
                  Tab(
                      child: Text("Offence",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            fontFamily: 'Montserrat Regular',

                          ))
                  ),
                  Tab(
                      child: Text("Tickets",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            fontFamily: 'Montserrat Regular',
                          ))
                  ),
                  Tab(
                      child: Text("Saved",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              fontFamily: 'Montserrat Regular'
                          ))
                  ),
                ],
              ),
            )
          ),
        body: Container(
          child: TabBarView(
            children: [
              Accounts(),
              OffenceView(),
              TicketView(),
              SavedView(),
            ],
          ),
        ),
      ),
    );
  }
}






