import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:flutter/material.dart';

class TicketView extends StatefulWidget {
  const TicketView({Key? key}) : super(key: key);

  @override
  _TicketViewState createState() => _TicketViewState();
}

class _TicketViewState extends State<TicketView> {
  List<Map> tickets = [
    {
      "asset": "assets/images/img6.png",
      "offence": "Traffic Offence",
      "description":
          "Nisi qui enim laborum esse proident commodo isi qui enim laborum esse proident commodo nisi tempor magna eiusmod amet quis ex.",
      "fine": "NGN 2,000",
      "points": "0.5"
    },
    {
      "asset": "assets/images/img7.png",
      "offence": "Stop & Search",
      "description":
          "Nisi qui enim laborum esse proident commodo isi qui enim laborum esse proident commodo nisi tempor magna eiusmod amet quis ex.",
      "fine": "NGN 2,000",
      "points": "0.5"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, scale: 0.02)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.03),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: tickets.length,
              itemBuilder: (BuildContext context, int i) {
                return Container(
                  color: AppColors.color2,
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          DeviceUtils.getScaledWidth(context, scale: 0.05)),
                  margin: EdgeInsets.only(bottom: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CardView(
                          context,
                          tickets[i]["offence"],
                          tickets[i]["description"],
                          tickets[i]["fine"],
                          tickets[i]["points"],
                          tickets[i]["asset"],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

StatelessWidget CardView(
    context, cardTitle, cardSubTitle, fine, points, asset) {
  return Container(
    width: DeviceUtils.getScaledWidth(context, scale: 1),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: AppColors.color2,
          spreadRadius: 3,
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          width: DeviceUtils.getScaledWidth(context, scale: 1),
          decoration: new BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardTitle,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: AppColors.appPrimaryColor,
                    fontFamily: 'Montserrat Bold'),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
            ],
          ),
        ),
        Container(
            child: Image.asset(
          asset,
          width: DeviceUtils.getScaledWidth(context, scale: 1),
          height: DeviceUtils.getScaledHeight(context, scale: 0.34),
          fit: BoxFit.cover,
        )),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          width: DeviceUtils.getScaledWidth(context, scale: 1),
          decoration: new BoxDecoration(
            color: AppColors.whiteColor,
            border: Border(
              top: BorderSide(
                color: AppColors.color10,
                width: 0.1,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              Text(
                Strings.descriptionOffOffence,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.appPrimaryColor,
                    fontFamily: 'Montserrat Bold'
                ),
              ),
              Text(
                cardSubTitle,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontFamily: 'Montserrat Bold',
                ),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.expectedFine,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.appPrimaryColor,
                        fontFamily: 'Montserrat Bold'
                    ),
                  ),
                  Text(
                    fine,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      fontFamily: 'Montserrat Bold'
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.yourPoints,
                    style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: AppColors.appPrimaryColor,
                            fontFamily: 'Montserrat Bold'
                         ),
                  ),
                  Text(
                    points,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      fontFamily: 'Montserrat Bold'
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
