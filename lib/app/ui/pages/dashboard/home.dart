import 'dart:convert';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dot_safety/app/controller/agora_controller.dart';
import 'package:dot_safety/app/controller/dashboard_controller.dart';
import 'package:dot_safety/app/controller/vehicle_controller.dart';
import 'package:dot_safety/app/ui/pages/dashboard/Dartool.dart';
import 'package:dot_safety/app/ui/pages/dashboard/broadcast_page.dart';
import 'package:dot_safety/app/ui/pages/dashboard/selectLawEnforcement.dart';
import 'package:dot_safety/app/ui/pages/dashboard/speech_recognition.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/shared_prefs.dart';
import 'package:dot_safety/app/utils/temp_data.dart';
import 'package:dot_safety/app/utils/time_lapse.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AgoraController agoraController = Get.put(AgoraController());
  late var rtcToken;
  late String uid;

  String setActiveTab = 'nearby';

  int? selectedIndex;
  String? firstName = '';
  String profileImage = '';
  late String broadcast;
  late Socket socket;

  final _channelName = TextEditingController();
  String check = '';
  String text = '';

  bool liveBeep = false;

  List liveStreams = [];

  List<String> litems = ["Traffic Offence", "Accident", "Kidnap"];
  List<String> imageList = [
    "assets/images/img1.png",
    "assets/images/img2.png",
    "assets/images/img3.png",
    "assets/images/img4.png",
    "assets/images/img5.png",
    "assets/images/img6.png",
    "assets/images/img7.png",
    "assets/images/img8.png",
    "assets/images/img1.png",
    "assets/images/img2.png",
    "assets/images/img3.png",
    "assets/images/img4.png",
    "assets/images/img5.png",
    "assets/images/img6.png",
    "assets/images/img7.png",
    "assets/images/img8.png"
  ];

  final DashboardController dashboardController =
      Get.put(DashboardController());
  final VehicleController vehicleController = Get.put(VehicleController());

  updateState(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void getSharedPrefs() async {
    // getting vehicles
    if (await vehicleController.getUploadedVehicled()) {}

    // get AgencyListing
    if (await dashboardController.getAgencyList()) {}

    // getting Active Livstreams
    if (await agoraController.getActiveLivestreams()) {
      setState(() {
        liveStreams = agoraController.activelivestreams;
      });
    }

    var a = await SharedPrefs.readSingleString('first_name');
    var c = await SharedPrefs.readSingleString('image_url');

    setState(() {
      firstName = a;
      if (c != null && c.length > 0) {
        profileImage = '${Strings.domain}' + c;
      }
    });
  }

  FlutterTts flutterTts = FlutterTts();

  void speak() async {
    await flutterTts.setPitch(1.0);
    await flutterTts.speak('Listening');
  }

  void setUpSocketListener() {
    socket.on(
        'activeLivestream',
        (data) => {
              // FlutterBeep.beep(),
              liveStreams.add(data),
        print(data),
        print(liveStreams),
        setState(() {
                liveBeep = true;
              }),
            });
    socket.on(
        'end-activeLivestream',
            (data) => {
          liveStreams.removeWhere( (elem) => elem['app_id'] == data['app_id']),
          setState(() {
            liveBeep = false;
          }),
        });
  }

  @override
  void initState() {
    super.initState();

    // getting shared prefs
    getSharedPrefs();

    // Initializing socket IO
    socket = io('${Strings.domain}', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();

    // Setting socket listeners
    setUpSocketListener();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                height: DeviceUtils.getScaledHeight(context, scale: 1),
                width: DeviceUtils.getScaledWidth(context, scale: 1),
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.04),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: DeviceUtils.getScaledWidth(context,
                                  scale: 0.05)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      if (dashboardController
                                              .lawEnforcementAgencies.length >
                                          0) {
                                        Scaffold.of(context).openDrawer();
                                      } else {
                                        toast(
                                            dashboardController.message.value);
                                      }
                                    },
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: CircleAvatar(
                                          radius: 20.0,
                                          backgroundColor: AppColors.color11,
                                          child: Image.asset(
                                              'assets/images/logo.png')),
                                    ),
                                  ),
                                  SizedBox(
                                    width: DeviceUtils.getScaledWidth(context,
                                        scale: 0.05),
                                  ),
                                  Text(
                                    'Hi, $firstName!'
                                        .substring(0, firstName!.length + 5),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: 'Montserrat Regular',
                                        color: AppColors.appPrimaryColor),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await [Permission.camera, Permission.microphone, Permission.bluetoothConnect].request();
                                  speak();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SpeechScreen(socket: socket,),
                                    ),
                                  );
                                },
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(
                                    'assets/images/alert.png',
                                    width: DeviceUtils.getScaledWidth(context,
                                        scale: 0.11),
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.11),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.01),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: DeviceUtils.getScaledWidth(context,
                                      scale: 0.02)),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        livestreamBottomModal();
                                      },
                                      child: Text(
                                        'Live',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            fontFamily: 'Montserrat Bold',
                                            color: AppColors.color8),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    (liveBeep  || liveStreams.length > 0)
                                        ? AvatarGlow(
                                            glowColor: Colors.blue,
                                            duration:
                                                Duration(milliseconds: 1000),
                                            repeat: true,
                                            showTwoGlows: false,
                                            repeatPauseDuration:
                                                Duration(milliseconds: 50),
                                            endRadius: 10.0,
                                            child: Container(
                                              width: 5,
                                              height: 5,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              100))),
                                            ))
                                        : Container()
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: DeviceUtils.getScaledWidth(context,
                                  scale: 0.02),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                    height: 40,
                                    width: DeviceUtils.getScaledWidth(context, scale: 0.77),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              setState((){
                                                setActiveTab = 'nearby';
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: AppColors.color3),
                                                borderRadius: BorderRadius.circular(4),
                                                color: setActiveTab == 'nearby' ? AppColors.appPrimaryColor : Colors.transparent// radius of 10
                                              ),
                                              child: Text(
                                                'Nearby',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: setActiveTab == 'nearby' ? AppColors.whiteColor : AppColors.color10,// radius of 10,
                                                  fontFamily: 'Montserrat Regular',
                                                ),
                                              ),
                                            )),
                                        SizedBox(
                                          width: DeviceUtils.getScaledWidth(context, scale: 0.01),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState((){
                                                setActiveTab = 'state';
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: AppColors.color3),
                                                borderRadius: BorderRadius.circular(4),
                                                  color: setActiveTab == 'state' ? AppColors.appPrimaryColor : Colors.transparent// radius of 10
// radius of 10
                                              ),
                                              child: Text(
                                                'State',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: setActiveTab == 'state' ? AppColors.whiteColor : AppColors.color10,// radius of 10,
                                                  fontFamily: 'Montserrat Regular',
                                                ),
                                              ),
                                            )),
                                        SizedBox(
                                          width: DeviceUtils.getScaledWidth(context, scale: 0.01),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState((){
                                                setActiveTab = 'nationwide';
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: AppColors.color3),
                                                borderRadius: BorderRadius.circular(4),
                                                  color: setActiveTab == 'nationwide' ? AppColors.appPrimaryColor : Colors.transparent// radius of 10
                                              ),
                                              child: Text(
                                                'Nationwide',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: setActiveTab == 'nationwide' ? AppColors.whiteColor : AppColors.color10,// radius of 10,
                                                  fontFamily: 'Montserrat Regular',
                                                ),
                                              ),
                                            )),
                                        SizedBox(
                                          width: DeviceUtils.getScaledWidth(context, scale: 0.02),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.03),
                        ),
                      ],
                    ),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemCount: imageList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              Container(
                                  color: AppColors.color3,
                                  margin: const EdgeInsets.all(3),
                                  child: Image.asset(
                                    imageList[index],
                                    fit: BoxFit.cover,
                                    width: DeviceUtils.getScaledWidth(context,
                                        scale: 1),
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 1),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      Icons.image,
                                      color: AppColors.color2,
                                      size: 25,
                                    )),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ));
        },
        key: null,
      ),
    );
  }

  Future<void> onJoin({required bool isBroadcaster, required int index}) async {

    await [Permission.camera, Permission.microphone].request();

    uid = new DateTime.now().millisecondsSinceEpoch.toString();
    uid = uid.substring(uid.length - 4);

    print(uid);

    broadcast = (isBroadcaster) ? 'publisher' : 'subscriber';

      // send request to get user token session
      rtcToken = await agoraController.getSessionToken(
          liveStreams[index]['app_id'], liveStreams[index]['app_certificate'], liveStreams[index]['cname'], int.parse(uid), broadcast);

      if (rtcToken.length > 0 &&
          liveStreams[index]['app_id'].length > 0) {

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BroadcastPage(
              channelName: liveStreams[index]['cname'],
              isBroadcaster: isBroadcaster,
              uid: uid,
              rtcToken: rtcToken,
              socket: socket,
              app_ID: liveStreams[index]['app_id'],
            ),
          ),
        );
      } else {
        toast('Something went wrong, Try again');
      }
  }

  livestreamBottomModal() {
  print(liveStreams);
    showMaterialModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0),
              topRight: Radius.circular(18.0)),
          side: BorderSide(color: AppColors.color2)),
      closeProgressThreshold: 1,
      context: context,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height / 2,
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: ListView.builder(
            itemCount: liveStreams.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext ctxt, int index) {
              return Container(
                color: AppColors.color2,
                child: new ListTile(
                  onTap: (){
                    Navigator.pop(context);
                    onJoin(isBroadcaster: false, index: index);
                  },
                  dense: true,
                  leading: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  '${Strings.domain}${liveStreams[index]["image_path"]}',
                                  errorListener: () =>
                                      print('Error Fetching image')),
                              fit: BoxFit.cover))),
                  title: Text(
                    '${liveStreams[index]['first_name']} ${liveStreams[index]['last_name']}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        fontFamily: 'Montserrat Bold',
                        color: AppColors.color10),
                  ),
                  subtitle: Text(
                    'Started ${TimeAgo.timeAgoSinceDate(liveStreams[index]['started_at']) }',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 11,
                        fontFamily: 'Montserrat Regula',
                        color: AppColors.color10),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

// Pops up Dialog box
showAlertDialog(BuildContext context, litems, selectedIndex, updateState) {
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    contentPadding: EdgeInsets.all(5),
    content: Container(
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, scale: 0.07)),
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(
                  Icons.check_box_outline_blank,
                  color: AppColors.appPrimaryColor,
                ),
                title: Text(
                  litems[0],
                  style: TextStyle(
                    fontFamily: 'Montserrat Regular',
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.check_box_outline_blank,
                  color: AppColors.appPrimaryColor,
                ),
                title: Text(
                  litems[1],
                  style: TextStyle(
                    fontFamily: 'Montserrat Regular',
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.check_box_outline_blank,
                  color: AppColors.appPrimaryColor,
                ),
                title: Text(
                  litems[2],
                  style: TextStyle(
                    fontFamily: 'Montserrat Regular',
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
