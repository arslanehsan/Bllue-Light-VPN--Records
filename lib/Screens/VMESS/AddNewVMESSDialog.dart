import 'package:bluelight/Utils/AppButtons.dart';
import 'package:bluelight/Utils/AppConstents.dart';
import 'package:bluelight/Utils/Colors.dart';
import 'package:bluelight/Utils/ImputDecoration.dart';
import 'package:bluelight/Utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Objects/VmessObject.dart';
import '../../Utils/Toast.dart';

class AddNewVMESSDialog extends StatefulWidget {
  final List<VMESSObject> vmessListItems;

  const AddNewVMESSDialog({super.key, required this.vmessListItems});

  @override
  State<StatefulWidget> createState() => AddNewVMESSDialogState();
}

class AddNewVMESSDialogState extends State<AddNewVMESSDialog>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late List<VMESSObject> vmessListItems = widget.vmessListItems;
  SharedPreferences? prefs;

  late AnimationController controller;
  late Animation<double> scaleAnimation;

  bool _loading = false;

  VMESSObject _vmess = VMESSObject();

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
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
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
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(15.0),
            // height: 180.0,
            decoration: ShapeDecoration(
              color: AppThemeColor.pureWhiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      AppConstantsEnglish.addNewVMESS,
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
                          _vmess.address = value;
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
                        labelText: 'port',
                      ),
                      onSaved: (value) {
                        setState(() {
                          _vmess.port = value;
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
                        labelText: 'User Id',
                      ),
                      onSaved: (value) {
                        setState(() {
                          _vmess.userId = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Enter User Id';
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
                        labelText: 'Path',
                      ),
                      onSaved: (value) {
                        setState(() {
                          _vmess.path = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Enter Path';
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
                        labelText: 'TLS',
                      ),
                      onSaved: (value) {
                        setState(() {
                          _vmess.tls = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Enter TLS';
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
                        labelText: 'Type',
                      ),
                      onSaved: (value) {
                        setState(() {
                          _vmess.type = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Enter Type';
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
                        labelText: 'Version',
                      ),
                      onSaved: (value) {
                        setState(() {
                          _vmess.version = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Enter Version';
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
                          _vmess.remarks = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Enter Remarks';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          setState(() {
                            _loading = true;
                          });
                          _vmess.id = vmessListItems.length.toString();

                          vmessListItems.add(_vmess);

                          await prefs!
                              .setStringList(
                            'vmessList',
                            VMESSObject().vmessObjectListToStringList(
                                listData: vmessListItems),
                          )
                              .then((value) {
                            setState(() {
                              _loading = true;
                            });
                            ShowToast()
                                .showNormalToast(msg: 'Added Successful!');
                            Navigator.pop(context);
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
      ),
    );
  }
}
