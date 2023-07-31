import 'package:flutter/material.dart';

import '../../Utils/Colors.dart';
import '../../Utils/dimensions.dart';
import '../Utils/AppConstents.dart';
import '../Utils/Images.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late double screenWidth;
  late double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: _bodyView(),
      ),
    );
  }

  Widget _bodyView() {
    return Container(
      height: screenHeight,
      width: screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        color: AppThemeColor.pureWhiteColor,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.close_rounded,
                color: AppThemeColor.darkBlueColor,
                size: 34,
              ),
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 15),
                height: screenWidth / 2,
                width: screenWidth / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(Images.inAppLogo),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            _singleValueView(
              title: 'App Name',
              value: AppConstantsEnglish.appName,
            ),
            const SizedBox(
              height: 20,
            ),
            _singleValueView(
              title: 'App Version',
              value: AppConstantsEnglish.appVersion,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: Divider(
                thickness: 1,
                color: AppThemeColor.darkBlueColor,
                endIndent: screenWidth / 5,
                indent: screenWidth / 5,
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // if (kIsWeb) {
                    //   AppConstantsEnglish()
                    //       .launchURL(url: _appSettings!.aboutUsLink!);
                    // } else {
                    //   RouterClass().webScreen(
                    //     context: context,
                    //     title: 'About Us',
                    //     url: _appSettings!.aboutUsLink!,
                    //   );
                    // }
                  },
                  child: _singleTabView(
                    iconData: Icons.help_outline,
                    title: 'About Us',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // if (_appSettings != null) {
                    //   if (kIsWeb) {
                    //     AppConstantsEnglish()
                    //         .launchURL(url: _appSettings!.privacyPolicyLink!);
                    //   } else {
                    //     RouterClass().webScreen(
                    //       context: context,
                    //       title: 'Privacy Policy',
                    //       url: _appSettings!.privacyPolicyLink!,
                    //     );
                    //   }
                    // }
                  },
                  child: _singleTabView(
                    iconData: Icons.policy,
                    title: 'Privacy Policy',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
    );
  }

  Widget _singleValueView({
    required String title,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: Dimensions.fontSizeLarge,
            color: AppThemeColor.pureBlackColor,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: Dimensions.fontSizeLarge,
            color: AppThemeColor.dullFontColor,
          ),
        ),
      ],
    );
  }

  Widget _singleTabView({
    required IconData iconData,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                iconData,
                size: 22,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: AppThemeColor.pureBlackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: Dimensions.fontSizeLarge,
                ),
              )
            ],
          ),
          const Icon(
            Icons.keyboard_arrow_right_rounded,
            color: AppThemeColor.pureBlackColor,
            size: 28,
          )
        ],
      ),
    );
  }
}
