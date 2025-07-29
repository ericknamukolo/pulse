import 'package:flutter/material.dart';
import 'package:pulse/features/auth/repo/auth_repo.dart';
import 'package:pulse/features/settings/screens/model/btn.dart';
import 'package:pulse/utils/colors.dart';
import 'package:pulse/widgets/custom_appbar.dart';
import 'package:pulse/widgets/title_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/utils.dart';
import '../widgets/settings_btn.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:in_app_update/in_app_update.dart';

class SettingsScreen extends StatefulWidget {
  final bool fromWebsitesScreen;
  const SettingsScreen({super.key, this.fromWebsitesScreen = false});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  PackageInfo? packageInfo;
  AppUpdateInfo? _updateInfo;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      // checkForUpdate();
      packageInfo = await PackageInfo.fromPlatform();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Btn> btns = [
      //account

      //app

      Btn(
        title: 'Rate Us',
        des: 'Give us your feedback',
        type: 'app',
        icon: Icons.star_rounded,
        click: () {
          Links.goToLink(
              'https://play.google.com/store/apps/details?id=com.sleepingpanda.pulse');
        },
      ),
      Btn(
        title: 'Privacy Policy',
        des: 'How we collect, use and protect your data',
        type: 'app',
        icon: Icons.shield_rounded,
        click: () {
          Links.goToLink('https://adcash-zm.vercel.app/privacy-policy',
              mode: LaunchMode.inAppBrowserView);
        },
      ),
      Btn(
        title: 'Source Code',
        des: 'Pulse app source code',
        type: 'app',
        icon: Icons.code_rounded,
        click: () {
          Links.goToLink('https://github.com/ericknamukolo/pulse');
        },
      ),
      Btn(
        title: 'Developer',
        des: 'information about the dev',
        type: 'app',
        icon: Icons.laptop_rounded,
        click: () {
          Links.goToLink('https://ericknamukolo.com');
        },
      ),
      // contact
      Btn(
        title: 'Help & Support',
        des: 'Contact Me',
        type: 'contact',
        icon: Icons.contact_support_rounded,
        click: () {
          Links.goToLink(
              'https://api.whatsapp.com/send/?phone=260962885743&text=Hello');
        },
      ),

      //setting
      Btn(
        title: 'App version',
        des: '${packageInfo?.version} (#${packageInfo?.buildNumber})',
        type: 'setting',
        icon: Icons.info_rounded,
        click: () {},
      ),

      Btn(
        title: 'Logout',
        des: 'Logout of your account',
        type: 'setting',
        icon: Icons.logout_rounded,
        click: () => AuthRepo().signOut(context),
      ),
    ];
    return Scaffold(
      appBar:
          widget.fromWebsitesScreen ? CustomAppBar(title: 'Settings') : null,
      body: Padding(
        padding: EdgeInsets.all(widget.fromWebsitesScreen ? 15.0 : 0.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            _buildSettings(
              title: 'App',
              btns: btns.where((e) => e.type == 'app').toList(),
            ),
            _buildSettings(
              title: 'Contact',
              btns: btns.where((e) => e.type == 'contact').toList(),
            ),
            _buildSettings(
                btns: btns.where((e) => e.type == 'setting').toList()),
          ],
        )),
      ),
    );
  }

  Column _buildSettings({required List<Btn> btns, String? title}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        title == null
            ? Divider(color: kGreyColor.withOpacity(.3))
            : TitleCard(title: title),
        Column(children: btns.map((e) => SettingsBtn(btn: e)).toList()),
      ],
    );
  }
}
