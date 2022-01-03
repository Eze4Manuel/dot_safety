import 'package:dot_safety/app/components/image-card.dart';
import 'package:dot_safety/app/controller/vehicle_controller.dart';
import 'package:dot_safety/app/ui/pages/vehicle/vehicle_document.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:get/get.dart';

class VehicleFileUploadUpdate extends StatefulWidget {

  @override
  State<VehicleFileUploadUpdate> createState() => _VehicleFileUploadUpdateState();
}

class _VehicleFileUploadUpdateState extends State<VehicleFileUploadUpdate> {
  final VehicleController vehicleController = Get.put(VehicleController());
  var val = false;

  void getDocuments () async {
    var temp = await vehicleController.getUploadedDocument(vehicleController.currentVehicle['_id']);
    setState(() {
      val = temp;
    });
  }

  @override
  void initState(){
    getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    print(val);
    print(vehicleController.edittedDocuments);

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
                "Update Document",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Montserrat Bold',
                  color: AppColors.whiteColor,
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
                width: DeviceUtils.getScaledWidth(context, scale: 1),
                color: AppColors.whiteColor,
                child: SingleChildScrollView(
                  child: Container(
                      color: AppColors.color2,
                      padding: EdgeInsets.symmetric(
                          horizontal: DeviceUtils.getScaledWidth(context, scale: 0.03)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context, scale: 0.01),
                          ),

                          Container(
                            height: DeviceUtils.getScaledHeight(context, scale: 0.7),
                            child: ListView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
                                primary: false,
                                shrinkWrap: true,
                                itemCount: vehicleController.edittedDocuments.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return UploadBlock(context,
                                      vehicleController.edittedDocuments[index]);
                                }),
                          ),

                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context, scale: 0.04),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => VehicleDocument()));
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.appPrimaryColor),
                                    child: Center(
                                      child: Text(
                                        Strings.done,
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
                                  height: DeviceUtils.getScaledHeight(context, scale: 0.01),
                                ),
                              ],
                            ),
                          )

                        ],
                      )),
                )),
          );
        },
        key: null,
      ),
    );
  }
}




StatelessWidget UploadBlock(context, document) {
  return Container(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, scale: 0.01),
        ),
        Text(
          document['_id'],
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              fontFamily: 'Montserrat Regular',
              color: AppColors.appPrimaryColor),
        ),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, scale: 0.02),
        ),
        Container(
            height: DeviceUtils.getScaledHeight(context, scale: 0.23),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: document['images'].length,
                itemBuilder: (context, index) {
                return
                  ImageCard(context, document['images'][index]['expire'],
                "", document['images'][index]['image_path'], true);
                },

            )),

        SizedBox(
          height: DeviceUtils.getScaledHeight(context, scale: 0.01),
        ),
      ],
    ),
  );
}
