import 'package:dot_safety/app/components/card_description.dart';
import 'package:dot_safety/app/ui/pages/dashboard/offence_detail.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Offence extends StatelessWidget {
  String offenceTitle;

  Offence({required this.offenceTitle});

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
                padding: const EdgeInsets.only(top: 18.0),
                child: Icon(Icons.arrow_back),
              ),
            ),
            backgroundColor: AppColors.secondaryColor,
            flexibleSpace: Align(
              alignment: Alignment.center,
              child: Text(
                offenceTitle,
                style:
                    TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          )
      ),
      body: ResponsiveSafeArea(
        builder: (context, size) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              // height: DeviceUtils.getScaledHeight(context, scale: 1),
                width: DeviceUtils.getScaledWidth(context, scale: 1),
                color: AppColors.whiteColor,
                child: OffenseList()),
          );
        },
        key: null,
      ),
    );
  }
}


class OffenseList extends StatefulWidget {
  const OffenseList({Key? key}) : super(key: key);

  @override
  _OffenseListState createState() => _OffenseListState();
}

class _OffenseListState extends State<OffenseList> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.color2,
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, scale: 0.05)),
      height: DeviceUtils.getScaledHeight(context, scale: 1),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.03),
            ),
            TextField(
                style: TextStyle(
                  fontSize: 14.0,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.color12,
                  ),
                  hintText: "Search For Offences",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 32.0, color: AppColors.appPrimaryColor),
                      borderRadius: BorderRadius.circular(6.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.transparent, width: 32.0),
                      borderRadius: BorderRadius.circular(6.0)),
                )),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => OffenceDetail()));
                      },
                      child: CardDescription(context, "Lexus", "venxs3345df venxs3345df venxs3345df  venxs3345df venxs3345df",
                          'assets/images/img6.png', true),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.02),
            ),
          ],
        ),
      ),
    );
  }
}



