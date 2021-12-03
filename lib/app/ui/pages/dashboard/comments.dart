import 'package:dot_safety/app/ui/pages/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';

class Comments extends StatelessWidget {
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
                Strings.commentList,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.whiteColor,
                  fontFamily: 'Montserrat Bold',
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
                // height: DeviceUtils.getScaledHeight(context, scale: 1),
                width: DeviceUtils.getScaledWidth(context, scale: 1),
                color: AppColors.whiteColor,
                child: CommentList()),
          );
        },
        key: null,
      ),
    );
  }
}

class CommentList extends StatefulWidget {
  const CommentList({Key? key}) : super(key: key);

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  int? selectedIndex;

  List<String> litems = [
    "Physical Violence",
    "Hospitality",
    "Intimidation",
    "Extortion",
    "Sexual Harrassment",
    "Punishment",
    "None",
    "Other"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, scale: 0.07)),
      // height: DeviceUtils.getScaledHeight(context, scale: 1),
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.07),
            ),
            Text(
              Strings.indicateComment,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  fontFamily: 'Montserrat Regular',
                  color: AppColors.appPrimaryColor),
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.05),
            ),
            ListView.builder(
                itemCount: litems.length,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    trailing: Icon(
                      (selectedIndex == index)
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: AppColors.appPrimaryColor,
                    ),
                    title: Text(litems[index]),
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  );
                }),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.08),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Dashboard()));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.appPrimaryColor),
                child: Center(
                  child: Text(
                    Strings.send,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontFamily: 'Montserrat Regular',
                        color: AppColors.whiteColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.05),
            ),
          ],
        ),
      ),
    );
  }
}
