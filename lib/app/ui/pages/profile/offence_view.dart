import 'package:dot_safety/app/ui/pages/profile/offence_selected_detail.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/device_utils.dart';


class OffenceView extends StatefulWidget {
  const OffenceView({Key? key}) : super(key: key);

  @override
  _OffenceViewState createState() => _OffenceViewState();
}

class _OffenceViewState extends State<OffenceView> {

  List<Map> offences = [
    {
      "title": "Traffic Offence",
      "subtitle": "Ajah Lagos state",
      "date": "Tue, 23 Nov 2021"
    },
    {
      "title": "Traffic Offence",
      "subtitle": "Ajah Lagos state",
      "date": "23 November 2021"
    },
    {
      "title": "Wrong Driving",
      "subtitle": "Ajah Lagos state",
      "date": "23 November 2021"
    },
    {
      "title": "Traffic Offence",
      "subtitle": "Ajah Lagos state",
      "date": "Tue, 23 Nov 2021"
    },
    {
      "title": "Traffic Offence",
      "subtitle": "Ajah Lagos state",
      "date": "Tue, 23 Nov 2021"
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
              itemCount: offences.length,
              itemBuilder: (BuildContext context, int i) {
                return Offence(
                    context,
                    offences[i]["icon"],
                    offences[i]["title"],
                    offences[i]["subtitle"],
                    offences[i]["date"]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

StatelessWidget Offence(context, icon, title, subtitle, date) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OffenceSelectedDetail()));
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      margin: EdgeInsets.only(
        bottom: DeviceUtils.getScaledHeight(context, scale: 0.02),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // radius of 10
        color: AppColors.whiteColor, // green as background color
      ),
      child: ListTile(
        trailing: Container(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), // radius of 10
            color: AppColors.appPrimaryColor, // green as background color
          ),
          child: Text(
            '2',
            style: TextStyle(
              color: AppColors.whiteColor,
              fontFamily: 'Montserrat Regular',

            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              fontFamily: 'Montserrat Regular',
              color: AppColors.appPrimaryColor
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
              fontFamily: 'Montserrat Regular'
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
            )),
      ],
    ),
  ),)
  ,
  );
}
