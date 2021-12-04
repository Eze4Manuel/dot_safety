import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SavedView extends StatefulWidget {
  const SavedView({Key? key}) : super(key: key);

  @override
  _SavedViewState createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView> {
  List<Map> saved = [
    {
      "asset": "assets/images/img8.png",
      "title": "Accident along london road",
      "place": "Ajah Lagos State",
      "date": "Tue, 23 Nov 2021"
    },
    {
      "asset": "assets/images/img5.png",
      "title": "Accident along london road",
      "place": "Ajah Lagos State",
      "date": "Tue, 23 Nov 2021"
    },
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
              itemCount: saved.length,
              itemBuilder: (BuildContext context, int i) {
                return Container(
                  color: AppColors.color2,
                  padding: EdgeInsets.symmetric(
                      horizontal: DeviceUtils.getScaledWidth(context, scale: 0.05)),
                  margin: EdgeInsets.only(
                      bottom: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CardView(context, saved[i]["title"], saved[i]["place"], saved[i]["date"], saved[i]["asset"]),
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


StatelessWidget CardView (context, cardSubTitle, place, date, asset){
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
                height: DeviceUtils.getScaledHeight(context, scale: 0.01),
              ),
              Text(
                cardSubTitle,
                style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Montserrat Regular',
                      fontSize: 16,
                    ),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.01),
              ),
              Text(
                place,
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
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Montserrat Regular'
                    )),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

