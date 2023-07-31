import 'package:bluelight/Screens/VMESS/AddNewVMESSDialog.dart';
import 'package:bluelight/Screens/VMESS/VMESSetailsDialog.dart';
import 'package:bluelight/Utils/AppConstents.dart';
import 'package:bluelight/Utils/Colors.dart';
import 'package:bluelight/Utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Objects/VmessObject.dart';

class VMESSListScreen extends StatefulWidget {
  const VMESSListScreen({super.key});

  @override
  State<VMESSListScreen> createState() => _VMESSListScreenState();
}

class _VMESSListScreenState extends State<VMESSListScreen> {
  late final double _screenWidth = MediaQuery.of(context).size.width;
  late final double _screenHeight = MediaQuery.of(context).size.height;

  List<VMESSObject> vmessListItems = [];

  SharedPreferences? prefs;

  Future<void> _getVMESSList() async {
    SharedPreferences prefsData = await SharedPreferences.getInstance();
    setState(() {
      prefs = prefsData;
    });

    List<String>? vmessListData = prefs!.getStringList('vmessList');
    if (vmessListData != null) {
      vmessListItems.clear();
      for (var element in vmessListData) {
        setState(() {
          vmessListItems.add(
            VMESSObject.fromString(stringData: element),
          );
        });
      }
    }
  }

  @override
  void initState() {
    _getVMESSList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: _bodyView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (_) => AddNewVMESSDialog(
              vmessListItems: vmessListItems,
            ),
          ).then((value) {
            _getVMESSList();
            // if (value != null) {
            //   setState(() {
            //     vmessListItems.add(value);
            //   });
            // }
          });
        },
        backgroundColor: AppThemeColor.darkBlueColor,
        child: const Icon(
          Icons.add,
          size: 33,
          color: AppThemeColor.pureWhiteColor,
        ),
      ),
    );
  }

  Widget _bodyView() {
    return Container(
      height: _screenHeight,
      width: _screenWidth,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppThemeColor.pureWhiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: vmessListItems.isEmpty
          ? const Center(
              child: Text(AppConstantsEnglish.empty),
            )
          : ListView.builder(
              itemCount: vmessListItems.length,
              itemBuilder: (context, listIndex) {
                return _singleListItem(
                  singleVMESS: vmessListItems[listIndex],
                );
              },
            ),
    );
  }

  Widget _singleListItem({required VMESSObject singleVMESS}) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => VMESSDetailsDialog(
            singleVMESSItem: singleVMESS,
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppThemeColor.darkBlueColor,
              width: 0.4,
            ),
          ),
        ),
        padding: const EdgeInsets.all(7),
        margin: const EdgeInsets.only(bottom: 7),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _singleValueView(
                    label: 'Host: ',
                    value: singleVMESS.address!,
                  ),
                  _singleValueView(
                    label: 'Port: ',
                    value: singleVMESS.port!,
                  ),
                  _singleValueView(
                    label: 'Remarks: ',
                    value: singleVMESS.remarks!,
                  ),
                ],
              ),
            ),
            const Row(
              children: [
                Text(
                  'View Details',
                  style: TextStyle(
                    color: AppThemeColor.dullFontColor,
                    fontSize: Dimensions.fontSizeExtraSmall,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _singleValueView({required String label, required String value}) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppThemeColor.dullFontColor,
            fontSize: Dimensions.fontSizeDefault,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppThemeColor.pureBlackColor,
            fontSize: Dimensions.fontSizeDefault,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
