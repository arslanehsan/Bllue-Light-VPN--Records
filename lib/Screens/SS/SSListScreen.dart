import 'package:bluelight/Objects/SSObject.dart';
import 'package:bluelight/Screens/SS/AddNewSSDialog.dart';
import 'package:bluelight/Screens/SS/SSDetailsDialog.dart';
import 'package:bluelight/Utils/AppConstents.dart';
import 'package:bluelight/Utils/Colors.dart';
import 'package:bluelight/Utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SSListScreen extends StatefulWidget {
  const SSListScreen({super.key});

  @override
  State<SSListScreen> createState() => _SSListScreenState();
}

class _SSListScreenState extends State<SSListScreen> {
  late final double _screenWidth = MediaQuery.of(context).size.width;
  late final double _screenHeight = MediaQuery.of(context).size.height;

  List<SSObject> ssListItems = [];

  SharedPreferences? prefs;

  Future<void> _getSSList() async {
    SharedPreferences prefsData = await SharedPreferences.getInstance();
    setState(() {
      prefs = prefsData;
    });

    List<String>? ssListData = prefs!.getStringList('ssList');
    if (ssListData != null) {
      ssListItems.clear();
      for (var element in ssListData) {
        setState(() {
          ssListItems.add(
            SSObject.fromString(stringData: element),
          );
        });
      }
    }
  }

  @override
  void initState() {
    _getSSList();
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
            builder: (_) => AddNewSSDialog(
              ssListItems: ssListItems,
            ),
          ).then((value) {
            _getSSList();
            // if (value != null) {
            //   setState(() {
            //     ssListItems.add(value);
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
      child: ssListItems.isEmpty
          ? const Center(
              child: Text(AppConstantsEnglish.empty),
            )
          : ListView.builder(
              itemCount: ssListItems.length,
              itemBuilder: (context, listIndex) {
                return _singleListItem(
                  singleSS: ssListItems[listIndex],
                );
              },
            ),
    );
  }

  Widget _singleListItem({required SSObject singleSS}) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => SSDetailsDialog(
            singleSSItem: singleSS,
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
                    value: singleSS.address!,
                  ),
                  _singleValueView(
                    label: 'Port: ',
                    value: singleSS.port!,
                  ),
                  _singleValueView(
                    label: 'Remarks: ',
                    value: singleSS.remarks!,
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
