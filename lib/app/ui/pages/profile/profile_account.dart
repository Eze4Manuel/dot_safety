import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dot_safety/app/controller/profile_controller.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/temp_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dot_safety/app/controller/login_controller.dart';
import 'package:dot_safety/app/ui/pages/login.dart';
import 'package:dot_safety/app/ui/pages/profile/settings.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ImageSourceType { gallery, camera }

class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  String? first_name;
  String? last_name;
  String? profileImage = '';

  var _image;
  var imagePicker;
  var type;

  final LoginController loginController = Get.put(LoginController());
  final ProfileController profileController = Get.put(ProfileController());

  // getting stored shared prefs
  void getShared() async {
    var a = await SharedPrefs.readSingleString('first_name');
    var b = await SharedPrefs.readSingleString('last_name');
    var c = await SharedPrefs.readSingleString('image_url') ?? profileImage;
    setState(() {
      first_name = a;
      last_name = b;
      if (c != null && c.length > 0)
        profileImage = '${Strings.domain}${c}';
    });
  }

  // getting image stored
  getImage(type) async {
    var source = type == ImageSourceType.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    XFile image = await imagePicker.pickImage(
        source: source,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);

    if (await profileController.asyncFileUpload(
        "Profile Image", File(image.path))) {
      setState(() {
        _image = File(image.path);
      });
      Navigator.pop(context);
    } else {
      toast(profileController.message.value);
    }
  }

  @override
  void initState() {
    super.initState();
    getShared();
    imagePicker = new ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom,
          ),
          child: Container(
            width: DeviceUtils.getScaledWidth(context, scale: 1),
            color: AppColors.whiteColor,
            height: DeviceUtils.getScaledHeight(context, scale: 0.71),
            child: Container(
              color: AppColors.color2,
              child: Stack(
                children: [
              Column(
              children: [
              Expanded(
              flex: 1,
                child: ImageFiltered(
                  imageFilter:
                  ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: _image != null
                      ? Container(
                    child: Image.file(
                      _image,
                      width: DeviceUtils.getScaledWidth(
                          context,
                          scale: 1),
                      height: DeviceUtils.getScaledHeight(
                          context,
                          scale: 1),
                      fit: BoxFit.cover,
                    ),
                  )
                      : Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                              CachedNetworkImageProvider(
                                  profileImage!,
                              errorListener: () => print('Error Fetching image')
                              ),
                              fit: BoxFit.cover))),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    decoration:
                    BoxDecoration(color: AppColors.color2)),
              )
              ],
            ),
            Column(
                children: [
            Container(
            height: DeviceUtils.getScaledHeight(context,
                scale: 0.2),
          ),
          Expanded(
            child: Container(
              width: DeviceUtils.getScaledWidth(context,
                  scale: 0.8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ), // radius of 10
                  color: AppColors
                      .whiteColor // green as background color
              ),
              child: Stack(
                  overflow: Overflow.visible,
                  children: [
              Positioned(
              top: DeviceUtils.getScaledHeight(context,
                  scale: -0.05),
              left: DeviceUtils.getScaledWidth(context,
                  scale: 0.31),
              child: Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.color11,
                  child: _image != null
                      ? Image.file(
                    _image,
                    width: 80.0,
                    height: 80.0,
                    fit: BoxFit.fill,
                  )
                      : CachedNetworkImage(
                    imageUrl: profileImage!,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),),
                    placeholder: (context, url) => CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColors.color11,
                      child: Container(),
                    ),
                    errorWidget: (context, url, error) => Container(),
                  ),

                  // Image.network(
                  //         profileImage!,
                  //         width: 80.0,
                  //         height: 80.0,
                  //         fit: BoxFit.fill,
                  //       ),
                )
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                        context,
                        scale: 0.092),
                  ),
                  Text(
                    "${first_name} ${last_name}",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Montserrat Bold',
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                        context,
                        scale: 0.01),
                  ),
                  // Text(
                  //   "Lagos state, Nigeria",
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w400,
                  //     fontFamily: 'Montserrat Regular',
                  //     fontSize: 14,
                  //   ),
                  // ),
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                        context,
                        scale: 0.01),
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        onPressed: () {},
                        color: AppColors.whiteColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(100)),
                        child: Text(
                          "Inbox",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily:
                            'Montserrat Regular',
                            fontSize: 14,
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        color: AppColors.appPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(100)),
                        child: Text(
                          "Points",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily:
                              'Montserrat Regular',
                              fontSize: 14,
                              color: AppColors.whiteColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                        context,
                        scale: 0.02),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor:
                          Colors.transparent,
                          context: context,
                          isScrollControlled: true,
                          isDismissible: true,
                          builder: (BuildContext context) {
                            return BottomImageSelect(
                                context, getImage);
                          });
                      // _handleURLButtonPress(context, ImageSourceType.gallery);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: DeviceUtils.getScaledWidth(
                              context,
                              scale: 0.05),
                        ),
                        Icon(
                          Icons.cloud_upload_rounded,
                          color: AppColors.appPrimaryColor,
                        ),
                        SizedBox(
                          width: DeviceUtils.getScaledWidth(
                              context,
                              scale: 0.04),
                        ),
                        Text(
                          'Upload an Image',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily:
                            'Montserrat Regular',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                        context,
                        scale: 0.02),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: DeviceUtils.getScaledWidth(
                            context,
                            scale: 0.05),
                      ),
                      Icon(
                        Icons.payment,
                        color: AppColors.appPrimaryColor,
                      ),
                      SizedBox(
                        width: DeviceUtils.getScaledWidth(
                            context,
                            scale: 0.04),
                      ),
                      Text(
                        'Payment',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Montserrat Regular',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                        context,
                        scale: 0.02),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SettingsView()));
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: DeviceUtils.getScaledWidth(
                              context,
                              scale: 0.05),
                        ),
                        Icon(
                          Icons.settings,
                          color: AppColors.appPrimaryColor,
                        ),
                        SizedBox(
                          width: DeviceUtils.getScaledWidth(
                              context,
                              scale: 0.04),
                        ),
                        Expanded(
                          child: Text(
                            'Setting',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily:
                              'Montserrat Regular',
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                        context,
                        scale: 0.02),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (await loginController.logout())
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Login()));
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: DeviceUtils.getScaledWidth(
                              context,
                              scale: 0.05),
                        ),
                        Icon(
                          Icons.logout,
                          color: AppColors.appPrimaryColor,
                        ),
                        SizedBox(
                          width: DeviceUtils.getScaledWidth(
                              context,
                              scale: 0.04),
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily:
                              'Montserrat Regular',
                              fontSize: 14,
                              color: AppColors.color5),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                        context,
                        scale: 0.01),
                  ),
                ],
              ),
              ],
            ),
          ),
        )
      ],
    )],
    ))),
    ),
    ],
    );
  }

  Wrap BottomImageSelect(context, getImage) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Container(
          width: DeviceUtils.getScaledWidth(context, scale: 1),
          decoration: new BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(15.0),
                  topRight: const Radius.circular(15.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              Text(
                'Select Image Source',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Montserrat Bold',
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.04),
              ),
              GestureDetector(
                onTap: () {
                  getImage(ImageSourceType.camera);
                },
                child: Container(
                  width: DeviceUtils.getScaledWidth(context, scale: 1),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      'Camera',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Montserrat Bold',
                          fontSize: 14,
                          color: AppColors.color8),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              GestureDetector(
                onTap: () {
                  getImage(ImageSourceType.gallery);
                },
                child: Container(
                  width: DeviceUtils.getScaledWidth(context, scale: 1),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      'Gallery',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Montserrat Bold',
                          fontSize: 14,
                          color: AppColors.color8),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.04),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ImageFromGalleryEx extends StatefulWidget {
  final type;

  ImageFromGalleryEx(this.type);

  @override
  ImageFromGalleryExState createState() => ImageFromGalleryExState(this.type);
}

class ImageFromGalleryExState extends State<ImageFromGalleryEx> {
  var _image;
  var imagePicker;
  var type;

  ImageFromGalleryExState(this.type);

  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(type == ImageSourceType.camera
              ? "Image from Camera"
              : "Image from Gallery")),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 52,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                var source = type == ImageSourceType.camera
                    ? ImageSource.camera
                    : ImageSource.gallery;
                XFile image = await imagePicker.pickImage(
                    source: source,
                    imageQuality: 50,
                    preferredCameraDevice: CameraDevice.front);
                setState(() {
                  _image = File(image.path);
                });
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(color: Colors.red[200]),
                child: _image != null
                    ? Image.file(
                  _image,
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.fitHeight,
                )
                    : Container(
                  decoration: BoxDecoration(color: Colors.red[200]),
                  width: 200,
                  height: 200,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
