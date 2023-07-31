import 'package:bluelight/Objects/SSObject.dart';
import 'package:bluelight/Utils/AppButtons.dart';
import 'package:bluelight/Utils/AppConstents.dart';
import 'package:bluelight/Utils/Colors.dart';
import 'package:bluelight/Utils/ImputDecoration.dart';
import 'package:bluelight/Utils/Toast.dart';
import 'package:bluelight/Utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNewSSDialog extends StatefulWidget {
  final List<SSObject> ssListItems;

  const AddNewSSDialog({super.key, required this.ssListItems});

  @override
  State<StatefulWidget> createState() => AddNewSSDialogState();
}

class AddNewSSDialogState extends State<AddNewSSDialog>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late List<SSObject> ssListItems = widget.ssListItems;
  SharedPreferences? prefs;

  late AnimationController controller;
  late Animation<double> scaleAnimation;

  bool _loading = false;

  SSObject _ss = SSObject();

  Future<void> _setPref() async {
    SharedPreferences prefsData = await SharedPreferences.getInstance();
    setState(() {
      prefs = prefsData;
    });
  }

  @override
  void initState() {
    super.initState();
    _setPref();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(15.0),
            // height: 180.0,
            decoration: ShapeDecoration(
              color: AppThemeColor.pureWhiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    AppConstantsEnglish.addNewSS,
                    style: TextStyle(
                      color: AppThemeColor.darkBlueColor,
                      fontWeight: FontWeight.w600,
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecorations.decoration1(
                      hintText: 'Write here...',
                      labelText: 'Address',
                    ),
                    onSaved: (value) {
                      setState(() {
                        _ss.address = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Enter Address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecorations.decoration1(
                      hintText: 'Write here...',
                      labelText: 'Port',
                    ),
                    onSaved: (value) {
                      setState(() {
                        _ss.port = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Enter Port';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecorations.decoration1(
                      hintText: 'Write here...',
                      labelText: 'Password',
                    ),
                    onSaved: (value) {
                      setState(() {
                        _ss.password = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Enter Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecorations.decoration1(
                      hintText: 'Write here...',
                      labelText: 'Remarks',
                    ),
                    onSaved: (value) {
                      setState(() {
                        _ss.remarks = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Enter Remarks';
                      }
                      return null;
                    },
                  ),
                  const Expanded(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setState(() {
                          _loading = true;
                        });
                        _ss.id = ssListItems.length.toString();

                        ssListItems.add(_ss);

                        await prefs!
                            .setStringList(
                          'ssList',
                          SSObject()
                              .ssObjectListToStringList(listData: ssListItems),
                        )
                            .then((value) {
                          setState(() {
                            _loading = true;
                          });
                          ShowToast().showNormalToast(msg: 'Added Successful!');
                          Navigator.pop(
                            context,
                          );
                        });
                      }
                    },
                    child: AppButtons().button1(
                      width: 200,
                      height: 45,
                      buttonLoading: _loading,
                      label: 'SAVE',
                      labelSize: Dimensions.fontSizeDefault,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: AppButtons().button2(
                      width: 200,
                      height: 45,
                      buttonLoading: _loading,
                      label: 'CANCEL',
                      labelSize: Dimensions.fontSizeDefault,
                      backgroundColor: AppThemeColor.pureWhiteColor,
                      textColor: AppThemeColor.darkBlueColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
