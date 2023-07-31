import 'package:bluelight/Objects/TrojanObject.dart';
import 'package:bluelight/Utils/AppButtons.dart';
import 'package:bluelight/Utils/AppConstents.dart';
import 'package:bluelight/Utils/Colors.dart';
import 'package:bluelight/Utils/ImputDecoration.dart';
import 'package:bluelight/Utils/dimensions.dart';
import 'package:flutter/material.dart';

class TrojanDetailsDialog extends StatefulWidget {
  final TrojanObject singleTrojanItem;

  const TrojanDetailsDialog({super.key, required this.singleTrojanItem});

  @override
  State<StatefulWidget> createState() => TrojanDetailsDialogState();
}

class TrojanDetailsDialogState extends State<TrojanDetailsDialog>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _addressEdtController = TextEditingController();
  final TextEditingController _portEdtController = TextEditingController();
  final TextEditingController _passwordEdtController = TextEditingController();
  final TextEditingController _remarksEdtController = TextEditingController();

  late AnimationController controller;
  late Animation<double> scaleAnimation;

  late final TrojanObject _trojan = widget.singleTrojanItem;

  @override
  void initState() {
    super.initState();

    _addressEdtController.text = _trojan.address!;
    _portEdtController.text = _trojan.port!;
    _passwordEdtController.text = _trojan.password!;
    _remarksEdtController.text = _trojan.remarks!;

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
              child: Column(
                children: [
                  const Text(
                    AppConstantsEnglish.categoryOne,
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
                    controller: _passwordEdtController,
                    decoration: InputDecorations.decoration1(
                      hintText: 'Write here...',
                      labelText: 'Password',
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
                  const Expanded(
                    child: SizedBox(
                      height: 10,
                    ),
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
    );
  }
}
