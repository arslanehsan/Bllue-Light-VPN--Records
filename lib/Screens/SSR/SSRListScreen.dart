import 'package:bluelight/Objects/SSRObject.dart';
import 'package:bluelight/Screens/SSR/AddNewSSRDialog.dart';
import 'package:bluelight/Screens/SSR/SSRDetailsDialog.dart';
import 'package:bluelight/Utils/AppConstents.dart';
import 'package:bluelight/Utils/Colors.dart';
import 'package:bluelight/Utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SSRListScreen extends StatefulWidget {
  const SSRListScreen({super.key});

  @override
  State<SSRListScreen> createState() => _SSRListScreenState();
}

class _SSRListScreenState extends State<SSRListScreen> {
  late final double _screenWidth = MediaQuery.of(context).size.width;
  late final double _screenHeight = MediaQuery.of(context).size.height;

  List<SSRObject> ssrListItems = [];

  SharedPreferences? prefs;

  Future<void> _getSSRList() async {
    SharedPreferences prefsData = await SharedPreferences.getInstance();
    setState(() {
      prefs = prefsData;
    });

    List<String>? ssrListData = prefs!.getStringList('ssrList');
    if (ssrListData != null) {
      ssrListItems.clear();
      for (var element in ssrListData) {
        setState(() {
          ssrListItems.add(
            SSRObject.fromString(stringData: element),
          );
        });
      }
    }
  }

  @override
  void initState() {
    _getSSRList();
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
            builder: (_) => AddNewSSRDialog(
              ssrListItems: ssrListItems,
            ),
          ).then((value) {
            _getSSRList();
            // if (value != null) {
            //   setState(() {
            //     ssrListItems.add(value);
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
      child: ssrListItems.isEmpty
          ? const Center(
              child: Text(AppConstantsEnglish.empty),
            )
          : ListView.builder(
              itemCount: ssrListItems.length,
              itemBuilder: (context, listIndex) {
                return _singleListItem(
                  singleSSR: ssrListItems[listIndex],
                );
              },
            ),
    );
  }

  Widget _singleListItem({required SSRObject singleSSR}) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => SSRDetailsDialog(
            singleSSRItem: singleSSR,
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
                    value: singleSSR.address!,
                  ),
                  _singleValueView(
                    label: 'Port: ',
                    value: singleSSR.port!,
                  ),
                  _singleValueView(
                    label: 'Remarks: ',
                    value: singleSSR.remarks!,
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
