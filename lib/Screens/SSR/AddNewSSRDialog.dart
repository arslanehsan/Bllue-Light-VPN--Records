import 'package:bluelight/Objects/SSRObject.dart';
import 'package:bluelight/Utils/AppButtons.dart';
import 'package:bluelight/Utils/AppConstents.dart';
import 'package:bluelight/Utils/Colors.dart';
import 'package:bluelight/Utils/ImputDecoration.dart';
import 'package:bluelight/Utils/Toast.dart';
import 'package:bluelight/Utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNewSSRDialog extends StatefulWidget {
  final List<SSRObject> ssrListItems;

  const AddNewSSRDialog({super.key, required this.ssrListItems});

  @override
  State<StatefulWidget> createState() => AddNewSSRDialogState();
}

class AddNewSSRDialogState extends State<AddNewSSRDialog>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late List<SSRObject> ssrListItems = widget.ssrListItems;
  SharedPreferences? prefs;

  late AnimationController controller;
  late Animation<double> scaleAnimation;

  bool _loading = false;

  SSRObject _ssr = SSRObject();

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
                    AppConstantsEnglish.addNewSSR,
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
                      labelText: 'Addressr',
                    ),
                    onSaved: (value) {
                      setState(() {
                        _ssr.address = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Enter Addressr';
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
                        _ssr.port = value;
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
                      labelText: 'Passrword',
                    ),
                    onSaved: (value) {
                      setState(() {
                        _ssr.password = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Enter Passrword';
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
                        _ssr.remarks = value;
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
                        _ssr.id = ssrListItems.length.toString();

                        ssrListItems.add(_ssr);

                        await prefs!
                            .setStringList(
                          'ssrList',
                          SSRObject().ssrObjectListToStringList(
                              listData: ssrListItems),
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
