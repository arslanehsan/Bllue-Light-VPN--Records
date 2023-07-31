import 'package:bluelight/Utils/AppButtons.dart';
import 'package:bluelight/Utils/AppConstents.dart';
import 'package:bluelight/Utils/Colors.dart';
import 'package:bluelight/Utils/ImputDecoration.dart';
import 'package:bluelight/Utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../Objects/VmessObject.dart';

class VMESSDetailsDialog extends StatefulWidget {
  final VMESSObject singleVMESSItem;

  const VMESSDetailsDialog({super.key, required this.singleVMESSItem});

  @override
  State<StatefulWidget> createState() => VMESSDetailsDialogState();
}

class VMESSDetailsDialogState extends State<VMESSDetailsDialog>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _addressEdtController = TextEditingController();
  final TextEditingController _portEdtController = TextEditingController();
  final TextEditingController _userIdEdtController = TextEditingController();
  final TextEditingController _pathEdtController = TextEditingController();
  final TextEditingController _tlsEdtController = TextEditingController();
  final TextEditingController _typeEdtController = TextEditingController();
  final TextEditingController _versionEdtController = TextEditingController();
  final TextEditingController _remarksEdtController = TextEditingController();

  late AnimationController controller;
  late Animation<double> scaleAnimation;

  late final VMESSObject _vmess = widget.singleVMESSItem;

  @override
  void initState() {
    super.initState();

    _addressEdtController.text = _vmess.address!;
    _portEdtController.text = _vmess.port!;
    _userIdEdtController.text = _vmess.userId!;
    _pathEdtController.text = _vmess.path!;
    _tlsEdtController.text = _vmess.tls!;
    _typeEdtController.text = _vmess.type!;
    _versionEdtController.text = _vmess.version!;
    _remarksEdtController.text = _vmess.remarks!;

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
                      AppConstantsEnglish.categoryTwo,
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
                      controller: _addressEdtController,
                      decoration: InputDecorations.decoration1(
                        hintText: 'Write here...',
                        labelText: 'Address',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _portEdtController,
                      decoration: InputDecorations.decoration1(
                        hintText: 'Write here...',
                        labelText: 'Port',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _userIdEdtController,
                      decoration: InputDecorations.decoration1(
                        hintText: 'Write here...',
                        labelText: 'User Id',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _pathEdtController,
                      decoration: InputDecorations.decoration1(
                        hintText: 'Write here...',
                        labelText: 'Path',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _tlsEdtController,
                      decoration: InputDecorations.decoration1(
                        hintText: 'Write here...',
                        labelText: 'TLS',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _typeEdtController,
                      decoration: InputDecorations.decoration1(
                        hintText: 'Write here...',
                        labelText: 'Type',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _versionEdtController,
                      decoration: InputDecorations.decoration1(
                        hintText: 'Write here...',
                        labelText: 'Version',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _remarksEdtController,
                      decoration: InputDecorations.decoration1(
                        hintText: 'Write here...',
                        labelText: 'Remarks',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {},
                      child: AppButtons().button1(
                        width: 200,
                        height: 45,
                        buttonLoading: false,
                        label: 'SHARE',
                        labelSize: Dimensions.fontSizeDefault,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: AppButtons().button2(
                        width: 200,
                        height: 45,
                        buttonLoading: false,
                        label: 'CLOSE',
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
