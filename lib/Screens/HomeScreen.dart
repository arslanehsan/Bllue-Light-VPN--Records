import 'package:bluelight/Screens/Trojan/TrojanListScreen.dart';
import 'package:bluelight/Utils/AppConstents.dart';
import 'package:bluelight/Utils/Colors.dart';
import 'package:bluelight/Utils/Router.dart';
import 'package:bluelight/Utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../Utils/Images.dart';
import 'SS/SSListScreen.dart';
import 'SSR/SSRListScreen.dart';
import 'VMESS/VMESSListScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final double _screenWidth = MediaQuery.of(context).size.width;
  late final double _screenHeight = MediaQuery.of(context).size.height;

  String selectedCategory = AppConstantsEnglish.categoryOne;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _bodyView(),
      ),
    );
  }

  Widget _bodyView() {
    return Container(
      height: _screenHeight,
      width: _screenWidth,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppThemeColor.backGroundColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          Images.inAppLogo,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    AppConstantsEnglish.appName,
                    style: TextStyle(
                      color: AppThemeColor.darkBlueColor,
                      fontSize: Dimensions.fontSizeExtraLarge,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () =>
                    RouterClass().settingsScreenRoute(context: context),
                child: const Icon(
                  Icons.settings,
                  size: 28,
                  color: AppThemeColor.darkBlueColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          _categoriesView(),
          const SizedBox(
            height: 15,
          ),
          if (selectedCategory == AppConstantsEnglish.categoryOne)
            const Expanded(
              child: TrojanListScreen(),
            ),
          if (selectedCategory == AppConstantsEnglish.categoryTwo)
            const Expanded(
              child: VMESSListScreen(),
            ),
          if (selectedCategory == AppConstantsEnglish.categoryThree)
            const Expanded(
              child: SSListScreen(),
            ),
          if (selectedCategory == AppConstantsEnglish.categoryFour)
            const Expanded(
              child: SSRListScreen(),
            ),
        ],
      ),
    );
  }

  Widget _categoriesView() {
    return SizedBox(
      width: _screenWidth,
      child: Row(
        children: [
          _singleCategoryView(title: AppConstantsEnglish.categoryOne),
          _singleCategoryView(title: AppConstantsEnglish.categoryTwo),
          _singleCategoryView(title: AppConstantsEnglish.categoryThree),
          _singleCategoryView(title: AppConstantsEnglish.categoryFour),
        ],
      ),
    );
  }

  Widget _singleCategoryView({required String title}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCategory = title;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: selectedCategory == title
                ? AppThemeColor.darkBlueColor
                : AppThemeColor.dullBlueColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(
                title == AppConstantsEnglish.categoryOne ? 15 : 0,
              ),
              topLeft: Radius.circular(
                title == AppConstantsEnglish.categoryOne ? 15 : 0,
              ),
              topRight: Radius.circular(
                title == AppConstantsEnglish.categoryFour ? 15 : 0,
              ),
              bottomRight: Radius.circular(
                title == AppConstantsEnglish.categoryFour ? 15 : 0,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: selectedCategory == title
                  ? AppThemeColor.pureWhiteColor
                  : AppThemeColor.darkBlueColor,
            ),
          ),
        ),
      ),
    );
  }
}
