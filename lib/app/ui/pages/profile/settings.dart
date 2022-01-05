import 'package:dot_safety/app/controller/profile_controller.dart';
import 'package:dot_safety/app/ui/pages/vehicle/add_contact.dart';
import 'package:dot_safety/app/ui/pages/vehicle/edit_contact.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/temp_data.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _expandedLanguage = false;
  bool _expandedPassword = false;
  bool _expandedContact = false;
  bool contactsFetched = false;

  final ProfileController profileController = Get.put(ProfileController());
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  final _formKey = GlobalKey<FormState>();
  late String old_password;
  late String new_password;
  late String confirm_password;
  late String confirm_password_error = '';

  Future<void> getContacts() async {
    var temp = await profileController.getContacts();
    print(temp);
    setState(() {
      contactsFetched = temp;
    });
  }

  @override
  initState() {
    getContacts();
  }

  @override
  Widget build(BuildContext context) {
    print(profileController.contacts);
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
                Strings.settings,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat Bold',
                    fontSize: 18,
                    color: AppColors.whiteColor),
                textAlign: TextAlign.center,
              ),
            ),
          )),
      body: ResponsiveSafeArea(
        builder: (context, size) {
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: DeviceUtils.getScaledWidth(context, scale: 0.03)),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
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
                                  'Language',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Montserrat Bold',
                                      fontSize: 14),
                                ),
                              );
                            },
                            body: ListTile(
                              title: Text('English',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Montserrat Regular',
                                      fontSize: 14)),
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
                    Container(
                      child: ExpansionPanelList(
                        animationDuration: Duration(milliseconds: 200),
                        elevation: 0,
                        children: [
                          ExpansionPanel(
                            headerBuilder: (context, isExpanded) {
                              return ListTile(
                                title: Text(
                                  'Change Password',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Montserrat Bold',
                                      fontSize: 14),
                                ),
                              );
                            },
                            body: Form(
                              key: _formKey,
                              child: ListTile(
                                  title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Old Password",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Montserrat Regular',
                                        fontSize: 14),
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: "********",
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 32.0),
                                            borderRadius:
                                                BorderRadius.circular(6.0)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 32.0),
                                            borderRadius:
                                                BorderRadius.circular(6.0))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter old password';
                                      }
                                    },
                                    onChanged: (val) {
                                      setState(() {
                                        old_password = val;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.02),
                                  ),
                                  Text(
                                    "New Password",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Montserrat Regular',
                                        fontSize: 14),
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Montserrat Regular',
                                        fontSize: 14),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: "*********",
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 32.0),
                                            borderRadius:
                                                BorderRadius.circular(6.0)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 32.0),
                                            borderRadius:
                                                BorderRadius.circular(6.0))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please New password';
                                      }
                                    },
                                    onChanged: (val) {
                                      setState(() {
                                        new_password = val;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.02),
                                  ),
                                  Text(
                                    (confirm_password_error.length != 0)
                                        ? confirm_password_error.toString()
                                        : "Confrim Password",
                                    style: TextStyle(
                                        color:
                                            (confirm_password_error.length == 0)
                                                ? AppColors.color10
                                                : AppColors.color5,
                                        fontFamily: 'Montserrat Regular',
                                        fontSize: 14),
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Montserrat Regular',
                                        fontSize: 14),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: "*********",
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 32.0),
                                            borderRadius:
                                                BorderRadius.circular(6.0)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 32.0),
                                            borderRadius:
                                                BorderRadius.circular(6.0))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Your Email';
                                      }
                                    },
                                    onChanged: (val) {
                                      setState(() {
                                        confirm_password = val;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.02),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      width: 100,
                                      child: RoundedLoadingButton(
                                          controller: _btnController,
                                          height: 40,
                                          width: 100,
                                          borderRadius: 8,
                                          color: AppColors.appPrimaryColor,
                                          successColor:
                                              AppColors.appPrimaryColor,
                                          child: Center(
                                            child: Text(
                                              "Save",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  fontFamily:
                                                      'Montserrat Regular',
                                                  color: AppColors.whiteColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                confirm_password_error = "";
                                              });
                                              if (new_password ==
                                                  confirm_password) {
                                                if (await profileController
                                                    .changePassword(
                                                        old_password,
                                                        new_password)) {
                                                  toast(profileController
                                                      .message.value);
                                                  _btnController.reset();
                                                } else {
                                                  toast(profileController
                                                      .message.value);
                                                  _btnController.reset();
                                                }
                                              } else {
                                                setState(() {
                                                  confirm_password_error =
                                                      "Confirm Password Mismatch";
                                                });
                                                _btnController.reset();
                                              }
                                            } else
                                              _btnController.reset();
                                          }),
                                    ),
                                  ),

                                  // Align(
                                  //   alignment: Alignment.centerRight,
                                  //   child: RaisedButton(
                                  //     onPressed: () {},
                                  //     color: AppColors.appPrimaryColor,
                                  //     shape: RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.circular(10)),
                                  //     child: Text(
                                  //       "Save",
                                  //       style: TextStyle(
                                  //           fontWeight: FontWeight.w400,
                                  //           fontFamily: 'Montserrat Regular',
                                  //           fontSize: 14,
                                  //           color: AppColors.whiteColor),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              )),
                            ),
                            isExpanded: _expandedPassword,
                            canTapOnHeader: true,
                          ),
                        ],
                        expansionCallback: (panelIndex, isExpanded) {
                          _expandedPassword = !_expandedPassword;
                          setState(() {});
                        },
                      ),
                    ),
                    Container(
                      child: ExpansionPanelList(
                        animationDuration: Duration(milliseconds: 200),
                        elevation: 0,
                        children: [
                          ExpansionPanel(
                            headerBuilder: (context, isExpanded) {
                              return ListTile(
                                title: Text(
                                  'Family Contact',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Montserrat Bold',
                                      fontSize: 14),
                                ),
                              );
                            },

                            // Add Contact
                            body: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Column(
                                children: [
                                  ListView.builder(
                                    itemCount:
                                        profileController.contacts.length,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (context, i) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                            color: AppColors.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditContact(
                                                          contact:
                                                              profileController
                                                                  .contacts[i],
                                                          indexNumber: i,
                                                        )));
                                          },
                                          minLeadingWidth: 0,
                                          horizontalTitleGap: 10.0,
                                          leading: Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                      AppColors.secondaryColor,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100))),
                                            child: Icon(
                                              Icons.contacts,
                                              color: AppColors.secondaryColor,
                                            ),
                                          ),
                                          title: Text(
                                            profileController.contacts[i]
                                                ['name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 13,
                                                fontFamily: 'Montserrat Bold'),
                                          ),
                                          subtitle: Row(
                                            children: [
                                              Text(
                                                profileController.contacts[i]
                                                    ['phone_number'],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 13,
                                                    fontFamily:
                                                        'Montserrat Regular'),
                                              ),
                                              SizedBox(
                                                width:
                                                    DeviceUtils.getScaledWidth(
                                                        context,
                                                        scale: 0.03),
                                              ),
                                            ],
                                          ),
                                          trailing: GestureDetector(
                                            onTap: () {
                                              _showMyDialog(i);
                                            },
                                            child: Container(
                                                child: Icon(
                                              Icons.delete,
                                              color: AppColors.appPrimaryColor,
                                            )),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddContact()),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100))),
                                      child: Icon(
                                        Icons.add_circle_rounded,
                                        color: AppColors.appPrimaryColor,
                                        size: 20,
                                      ),
                                    ),
                                    title: Text(
                                      'Add Contact Info',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          fontFamily: 'Montserrat Regular'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            isExpanded: _expandedContact,
                            canTapOnHeader: true,
                          ),
                        ],
                        expansionCallback: (panelIndex, isExpanded) {
                          _expandedContact = !_expandedContact;
                          setState(() {});
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Privacy and Security',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Montserrat Bold',
                            fontSize: 14),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'About',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Montserrat Bold',
                            fontSize: 14),
                      ),
                    ),
                  ]),
            ),
          );
        },
        key: null,
      ),
    );
  }

  Future<void> _showMyDialog(index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Confirm Delete',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat Bold',
                  fontSize: 16),
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(fontFamily: 'Montserrat Bold', fontSize: 14),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Delete',
                style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Montserrat Bold',
                    fontSize: 14),
              ),
              onPressed: () async {
                if (await profileController.deleteFamilyContact(index)) {
                  toast(profileController.message.value);
                  _btnController.reset();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SettingsView(),
                    ),
                    (route) => false,
                  );
                } else {
                  toast(profileController.message.value);
                  _btnController.reset();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
