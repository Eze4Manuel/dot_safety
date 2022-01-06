import 'package:dot_safety/app/components/card_description.dart';
import 'package:dot_safety/app/components/image-card.dart';
import 'package:dot_safety/app/controller/dashboard_controller.dart';
import 'package:dot_safety/app/controller/vehicle_controller.dart';
import 'package:dot_safety/app/ui/pages/notification/alert_screen.dart';
import 'package:dot_safety/app/ui/pages/dashboard/selectLawEnforcement.dart';
import 'package:dot_safety/app/ui/pages/vehicle/document_view.dart';
import 'package:dot_safety/app/ui/pages/vehicle/edit_vehicle.dart';
import 'package:dot_safety/app/ui/pages/vehicle/good_in_transit.dart';
import 'package:dot_safety/app/ui/pages/vehicle/vehicle_document.dart';
import 'package:dot_safety/app/ui/pages/vehicle/vehicle_file_uploads.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class DocumentList extends StatefulWidget {
  const DocumentList({Key? key}) : super(key: key);

  @override
  _DocumentListState createState() => _DocumentListState();
}

class _DocumentListState extends State<DocumentList> {
  int? selectedIndex;
  List<String> litems = ["Traffic Offence", "Accident", "Kidnap"];
  final DashboardController dashboardController =
      Get.put(DashboardController());

  final VehicleController vehicleController = Get.put(VehicleController());


  bool _expandedLanguage = false;
  bool _expandedGoods = false;
  bool _expandedOthers = false;

  updateState(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      drawer: Container(
        width: DeviceUtils.getScaledWidth(context, scale: 1),
        child: Drawer(
            child: SelectLawEnforcement(
                lawEnforcementAgencies:
                    dashboardController.lawEnforcementAgencies)),
      ),
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
                        DeviceUtils.getScaledWidth(context, scale: 0.05)),
                height: DeviceUtils.getScaledHeight(context, scale: 1),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, scale: 0.08),
                      ),
                      Text(
                        'Document Listing',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColors.appPrimaryColor,
                            fontFamily: 'Montserrat Regular'),
                      ),
                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, scale: 0.02),
                      ),
                      SizedBox(
                        height: DeviceUtils.getScaledHeight(context,
                            scale: 0.02),
                      ),
                      CarouselWidget(context),
                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, scale: 0.05),
                      ),

                      // Vehicles
                      SingleChildScrollView(
                        child: ExpansionPanelList(
                          animationDuration: Duration(milliseconds: 200),
                          elevation: 0,
                          children: [
                            ExpansionPanel(
                              headerBuilder: (context, isExpanded) {
                                return ListTile(
                                  dense: true,
                                  isThreeLine: false,
                                  title: Text(
                                    'Vehicle',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Montserrat Bold',
                                        fontSize: 14),
                                  ),
                                );
                              },
                              body: Column(
                                children: [
                                  Container(
                                    height: 230,
                                    child: ListView.builder(
                                      physics: const AlwaysScrollableScrollPhysics(), // new
                                      itemCount: vehicleController.vehicles.length,
                                      scrollDirection: Axis.vertical,

                                      itemBuilder: (context, i) {
                                        return Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius: BorderRadius.circular(6)
                                          ),
                                          child: ListTile(
                                            onTap: (){
                                              vehicleController.currentVehicle = vehicleController.vehicles[i];
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context) => DocumentView()));
                                            },
                                            minLeadingWidth: 0,
                                            horizontalTitleGap: 10.0,
                                            leading: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: AppColors.secondaryColor,
                                                  ),
                                                  borderRadius: BorderRadius.all(Radius.circular(100))),
                                              child: Icon(
                                                Icons.car_rental_sharp,
                                                color: AppColors.secondaryColor,
                                              ),

                                            ),
                                            title: Text(
                                              vehicleController.vehicles[i]['vehicle_name'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13,
                                                  fontFamily: 'Montserrat Bold'),
                                            ),
                                            subtitle: Row(
                                              children: [
                                                Text(
                                                  vehicleController.vehicles[i]['vehicle_plate_number'],
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 13,
                                                      fontFamily: 'Montserrat Regular'),
                                                ),
                                                SizedBox(
                                                  width: DeviceUtils.getScaledWidth(context,
                                                      scale: 0.03),
                                                ),
                                                Text(
                                                    vehicleController.vehicles[i]['vehicle_color'],
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 13,
                                                      fontFamily: 'Montserrat Regular'),
                                                ),
                                              ],
                                            ),
                                            trailing:  GestureDetector(
                                              onTap: (){
                                                vehicleController.currentVehicle = vehicleController.vehicles[i];
                                                Navigator.push(context,
                                                    MaterialPageRoute(builder: (context) => EditVehicle()));
                                              },
                                              child: Container(
                                                  child: Icon(Icons.edit, color: AppColors.appPrimaryColor,)
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  // Add Vehicle
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(6)
                                    ),
                                    child: ListTile(
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => VehicleDocument()),
                                        );
                                      },
                                      minLeadingWidth: 0,
                                      horizontalTitleGap: 20.0,
                                      leading: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColors.appPrimaryColor,
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(100))),
                                        child: Icon(
                                          Icons.add_circle_rounded,
                                          color: AppColors.appPrimaryColor,
                                          size: 20,
                                        ),

                                      ),
                                      title: Text(
                                        'Add Vehicle',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            fontFamily: 'Montserrat Regular'),
                                      ),

                                    ),
                                  ),
                                ],
                              ),
                              isExpanded: _expandedLanguage,
                              canTapOnHeader: true,
                            ),
                          ],
                          expansionCallback: (panelIndex, isExpanded) {
                            _expandedLanguage = !_expandedLanguage;
                            setState(() {});
                          },
                        ),
                      ),




                      SizedBox(
                        height:
                        DeviceUtils.getScaledHeight(context, scale: 0.01),
                      ),



                      // Goods in Transit
                      ExpansionPanelList(
                        animationDuration: Duration(milliseconds: 200),
                        elevation: 0,
                        children: [
                          ExpansionPanel(
                            headerBuilder: (context, isExpanded) {
                              return ListTile(
                                dense: true,
                                isThreeLine: false,
                                title: Text(
                                  'Goods In Transit',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Montserrat Bold',
                                      fontSize: 14),
                                ),
                              );
                            },
                            body: Column(
                              children: [
                                // Add Goods
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: ListTile(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => GoodsInTransit()),
                                      );
                                    },
                                    minLeadingWidth: 0,
                                    horizontalTitleGap: 20.0,
                                    leading: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.appPrimaryColor,
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(100))),
                                      child: Icon(
                                        Icons.add_circle_rounded,
                                        color: AppColors.appPrimaryColor,
                                        size: 20,
                                      ),

                                    ),
                                    title: Text(
                                      'Add Goods',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          fontFamily: 'Montserrat Regular'),
                                    ),

                                  ),
                                ),
                              ],
                            ),
                            isExpanded: _expandedGoods,
                            canTapOnHeader: true,
                          ),
                        ],
                        expansionCallback: (panelIndex, isExpanded) {
                          _expandedGoods = !_expandedGoods;
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, scale: 0.01),
                      ),

                      // Others
                      ExpansionPanelList(
                        animationDuration: Duration(milliseconds: 200),
                        elevation: 0,
                        children: [
                          ExpansionPanel(
                            headerBuilder: (context, isExpanded) {
                              return ListTile(
                                dense: true,
                                isThreeLine: false,
                                title: Text(
                                  'Others',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Montserrat Bold',
                                      fontSize: 14),
                                ),
                              );
                            },
                            body: Column(
                              children: [
                                // Add Others
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: ListTile(
                                    onTap: (){
                                      // // Navigator.push(
                                      // //   context,
                                      // //   MaterialPageRoute(builder: (context) => VehicleDocument()),
                                      // );
                                    },
                                    minLeadingWidth: 0,
                                    horizontalTitleGap: 20.0,
                                    leading: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.appPrimaryColor,
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(100))),
                                      child: Icon(
                                        Icons.add_circle_rounded,
                                        color: AppColors.appPrimaryColor,
                                        size: 20,
                                      ),
                                    ),
                                    title: Text(
                                      'Add Document',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          fontFamily: 'Montserrat Regular'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            isExpanded: _expandedOthers,
                            canTapOnHeader: true,
                          ),
                        ],
                        expansionCallback: (panelIndex, isExpanded) {
                          _expandedOthers = !_expandedOthers;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ));
        },
        key: null,
      ),
    );
  }
}


StatelessWidget CarouselWidget(context) {
  return Container(
      height: DeviceUtils.getScaledHeight(context, scale: 0.23),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: DeviceUtils.getScaledWidth(context, scale: 0.72),
            height: DeviceUtils.getScaledHeight(context, scale: 0.21),
            margin: EdgeInsets.only(
                right: DeviceUtils.getScaledWidth(context, scale: 0.03)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.transparent,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/img5.png',
                width: DeviceUtils.getScaledWidth(context, scale: 1),
                height: DeviceUtils.getScaledHeight(context, scale: 1),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: DeviceUtils.getScaledWidth(context, scale: 0.72),
            height: DeviceUtils.getScaledHeight(context, scale: 0.21),
            margin: EdgeInsets.only(
                right: DeviceUtils.getScaledWidth(context, scale: 0.03)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.transparent,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/img3.png',
                width: DeviceUtils.getScaledWidth(context, scale: 1),
                height: DeviceUtils.getScaledHeight(context, scale: 1),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: DeviceUtils.getScaledWidth(context, scale: 0.72),
            height: DeviceUtils.getScaledHeight(context, scale: 0.21),
            margin: EdgeInsets.only(
                right: DeviceUtils.getScaledWidth(context, scale: 0.03)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.transparent,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/img2.png',
                width: DeviceUtils.getScaledWidth(context, scale: 1),
                height: DeviceUtils.getScaledHeight(context, scale: 1),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: DeviceUtils.getScaledWidth(context, scale: 0.72),
            height: DeviceUtils.getScaledHeight(context, scale: 0.21),
            margin: EdgeInsets.only(
                right: DeviceUtils.getScaledWidth(context, scale: 0.03)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.transparent,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/img5.png',
                width: DeviceUtils.getScaledWidth(context, scale: 1),
                height: DeviceUtils.getScaledHeight(context, scale: 1),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ));
}
