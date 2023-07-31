import 'package:bluelight/Objects/TrojanObject.dart';
import 'package:bluelight/Screens/Trojan/AddNewTrojanDialog.dart';
import 'package:bluelight/Screens/Trojan/TrojanDetailsDialog.dart';
import 'package:bluelight/Utils/AppConstents.dart';
import 'package:bluelight/Utils/Colors.dart';
import 'package:bluelight/Utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrojanListScreen extends StatefulWidget {
  const TrojanListScreen({super.key});

  @override
  State<TrojanListScreen> createState() => _TrojanListScreenState();
}

class _TrojanListScreenState extends State<TrojanListScreen> {
  late final double _screenWidth = MediaQuery.of(context).size.width;
  late final double _screenHeight = MediaQuery.of(context).size.height;

  List<TrojanObject> trojanListItems = [];

  SharedPreferences? prefs;

  Future<void> _getTrojanList() async {
    SharedPreferences prefsData = await SharedPreferences.getInstance();
    setState(() {
      prefs = prefsData;
    });

    List<String>? trojanListData = prefs!.getStringList('trojanList');
    if (trojanListData != null) {
      trojanListItems.clear();
      for (var element in trojanListData) {
        setState(() {
          trojanListItems.add(
            TrojanObject.fromString(stringData: element),
          );
        });
      }
    }
  }

  @override
  void initState() {
    _getTrojanList();
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
            builder: (_) => AddNewTrojanDialog(
              trojanListItems: trojanListItems,
            ),
          ).then((value) {
            _getTrojanList();
            // if (value != null) {
            //   setState(() {
            //     trojanListItems.add(value);
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
      child: trojanListItems.isEmpty
          ? const Center(
              child: Text(AppConstantsEnglish.empty),
            )
          : ListView.builder(
              itemCount: trojanListItems.length,
              itemBuilder: (context, listIndex) {
                return _singleListItem(
                  singleTrojan: trojanListItems[listIndex],
                );
              },
            ),
    );
  }

  Widget _singleListItem({required TrojanObject singleTrojan}) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => TrojanDetailsDialog(
            singleTrojanItem: singleTrojan,
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
                    value: singleTrojan.address!,
                  ),
                  _singleValueView(
                    label: 'Port: ',
                    value: singleTrojan.port!,
                  ),
                  _singleValueView(
                    label: 'Remarks: ',
                    value: singleTrojan.remarks!,
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
