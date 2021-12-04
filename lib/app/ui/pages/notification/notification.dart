import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  List<Map> notifications = [
    {
      "icon": Icons.error,
      "title": "Emergency Alert",
      "subtitle":
          "Lorem Ipsum no commodo nisi elit cupidatat quis nisi do sunt.",
      "date": "Nov 23, 2021 at 9:30pm"
    },
    {
      "icon": Icons.notification_important_outlined,
      "title": "",
      "subtitle": "Road worthiness expires in 2 days",
      "date": "Nov 23, 2021 at 9:30pm"
    },
    {
      "icon": Icons.error,
      "title": "Emergency Alert",
      "subtitle":
          "Lorem Ipsum no commodo nisi elit cupidatat quis nisi do sunt.",
      "date": "Nov 23, 2021 at 9:30pm"
    },
    {
      "icon": Icons.error,
      "title": "Emergency Alert",
      "subtitle":
          "Lorem Ipsum no commodo nisi elit cupidatat quis nisi do sunt.",
      "date": "Nov 23, 2021 at 9:30pm"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Icon(Icons.arrow_back),
              ),
            ),
            backgroundColor: AppColors.secondaryColor,
            flexibleSpace: Align(
              alignment: Alignment.center,
              child: Text(
                Strings.notification,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.whiteColor,
                  fontFamily: 'Montserrat Regular',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )),
      body: ResponsiveSafeArea(
        builder: (context, size) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
                color: AppColors.color2,
                padding: EdgeInsets.symmetric(
                    horizontal:
                        DeviceUtils.getScaledWidth(context, scale: 0.07)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, scale: 0.02),
                      ),
                      Text(
                        'Today',
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Montserrat Regular',
                          fontSize: 14,
                        )),
                      ),
                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, scale: 0.02),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: notifications.length,
                        itemBuilder: (BuildContext context, int i) {
                          return NotificationBlock(
                              context,
                              notifications[i]["icon"],
                              notifications[i]["title"],
                              notifications[i]["subtitle"],
                              notifications[i]["date"]);
                        },
                      ),
                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, scale: 0.02),
                      ),
                      Text(
                        'Weekend',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          fontFamily: 'Montserrat Regular',
                        ),
                      ),
                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, scale: 0.02),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: notifications.length,
                        itemBuilder: (BuildContext context, int i) {
                          return NotificationBlock(
                              context,
                              notifications[i]["icon"],
                              notifications[i]["title"],
                              notifications[i]["subtitle"],
                              notifications[i]["date"]);
                        },
                      )
                    ],
                  ),
                )),
          );
        },
        key: null,
      ),
    );
  }
}

StatelessWidget NotificationBlock(context, icon, title, subtitle, date) {
  return Container(
    margin: EdgeInsets.only(
      bottom: DeviceUtils.getScaledHeight(context, scale: 0.02),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10), // radius of 10
      color: AppColors.whiteColor, // green as background color
    ),
    child: ListTile(
      leading: Icon(
        icon,
        size: 40,
        color: icon == Icons.error ? AppColors.color5 : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: 'Montserrat Regular'
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              fontFamily: 'Montserrat Regular',
            ),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.01),
          ),
          Text(
            date,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              fontFamily: 'Montserrat Regular',
            ),
          ),
        ],
      ),
    ),
  );
}
