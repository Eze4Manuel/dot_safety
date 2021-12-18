import 'package:dot_safety/app/controller/dashboard_controller.dart';
import 'package:dot_safety/app/ui/pages/dashboard/dashboard.dart';
import 'package:dot_safety/app/utils/temp_data.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Comments extends StatefulWidget {
  String? user_id;

  Comments({this.user_id});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  var selectedIndex;

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

  final DashboardController dashboardController =
      Get.put(DashboardController());

  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    print(widget.user_id);
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
                child: Container(
                  color: AppColors.whiteColor,
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          DeviceUtils.getScaledWidth(context, scale: 0.07)),
                  // height: DeviceUtils.getScaledHeight(context, scale: 1),
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.04),
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
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.05),
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
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.08),
                        ),
                        RoundedLoadingButton(
                            controller: _btnController,
                            height: 50,
                            borderRadius: 8,
                            color: AppColors.appPrimaryColor,
                            successColor: AppColors.appPrimaryColor,
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
                            onPressed: () async {
                              if (await dashboardController.updateComment(widget.user_id, litems[selectedIndex])) {
                                toast(dashboardController.message.value);
                                _btnController.reset();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Dashboard()));
                              } else {
                                toast(dashboardController.message.value);
                                _btnController.reset();
                              }
                            }),

                        SizedBox(
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.05),
                        ),
                      ],
                    ),
                  ),
                )),
          );
        },
        key: null,
      ),
    );
  }
}
