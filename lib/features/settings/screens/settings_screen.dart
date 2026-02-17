import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pulse/features/auth/repo/auth_repo.dart';
import 'package:pulse/features/settings/screens/model/btn.dart';
import 'package:pulse/features/settings/widgets/delete_account_dialog.dart';
import 'package:pulse/features/theme/cubit/theme_cubit.dart';
import 'package:pulse/utils/colors.dart';
import 'package:pulse/utils/local_storage.dart';
import 'package:pulse/widgets/custom_appbar.dart';
import 'package:pulse/widgets/title_card.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
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

  Future<void> buyCoffee() async {
    try {
      final offerings = await Purchases.getOfferings();

      await Purchases.purchasePackage(offerings
          .getOffering(Platform.isIOS ? 'coffee_ios' : 'coffee')!
          .availablePackages
          .first);

      Toast.showToast(message: 'Thank you! 🥳🎉', context: context);
    } on PlatformException catch (e) {
      logger.i(e);
      final errorCode = PurchasesErrorHelper.getErrorCode(e);

      switch (errorCode) {
        case PurchasesErrorCode.purchaseCancelledError:
          Toast.showToast(
            message: 'Purchase cancelled.',
            context: context,
          );
          return;

        case PurchasesErrorCode.purchaseNotAllowedError:
          Toast.showToast(
            message:
                'Purchases are not allowed on this device. Please check your settings.',
            context: context,
          );
          return;

        case PurchasesErrorCode.storeProblemError:
          Toast.showToast(
            message:
                'The store is temporarily unavailable. Please try again shortly.',
            context: context,
          );
          return;

        case PurchasesErrorCode.networkError:
          Toast.showToast(
            message:
                'No internet connection. Please check your connection and try again.',
            context: context,
          );
          return;

        case PurchasesErrorCode.paymentPendingError:
          Toast.showToast(
            message:
                'Your payment is pending approval. You will get access once it is approved.',
            context: context,
          );
          return;

        case PurchasesErrorCode.productAlreadyPurchasedError:
          await Purchases.restorePurchases();

          Toast.showToast(
            message: 'You already own this item. Restoring your access…',
            context: context,
          );
          return;

        default:
          Toast.showToast(
            message: 'Something went wrong. Please try again.',
            context: context,
          );
          return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Btn> btns = [
      //theme
      Btn(
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return SwitchTheme(
              data: SwitchThemeData(
                trackOutlineColor: MaterialStateProperty.resolveWith((states) {
                  if (!states.contains(MaterialState.selected)) {
                    return kGreyColor;
                  }
                  return Colors.transparent;
                }),
              ),
              child: Switch.adaptive(
                value: state.darkMode,
                onChanged: (_) {
                  context.read<ThemeCubit>().setThemeMode();
                },
                activeColor: kPrimaryColor,
              ),
            );
          },
        ),
        title: 'Dark Theme',
        des: 'Enable/Disable dark theme',
        type: 'theme',
        icon: Iconsax.moon_bold,
        click: () {},
      ),
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
          Links.goToLink(
              'https://doc-hosting.flycricket.io/pulse-privacy-policy/76342146-9ec1-4f25-8c7a-62109aefc65e/privacy',
              mode: LaunchMode.inAppBrowserView);
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

      Btn(
        title: 'Coffee (Optional)',
        des: 'Buy me a coffee 🍵',
        type: 'app',
        icon: Bootstrap.cup_hot_fill,
        click: () {
          buyCoffee();
        },
      ),
      // github
      Btn(
        title: 'Source Code',
        des: 'Pulse app source code',
        type: 'github',
        icon: Icons.code_rounded,
        click: () {
          Links.goToLink('https://github.com/ericknamukolo/pulse');
        },
      ),
      Btn(
        title: 'Issues or Feature suggestions',
        des: 'Create an issue on github',
        type: 'github',
        icon: Bootstrap.github,
        click: () {
          Links.goToLink('https://github.com/ericknamukolo/pulse/issues');
        },
      ), // contact
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
        des: _updateInfo?.updateAvailability ==
                UpdateAvailability.updateAvailable
            ? 'Click to update the app 🚀'
            : '${packageInfo?.version} (#${packageInfo?.buildNumber})',
        type: 'setting',
        icon: Icons.info_rounded,
        click: () async {
          if (Platform.isIOS) return;
          if (_updateInfo?.updateAvailability ==
              UpdateAvailability.updateAvailable) {
            await InAppUpdate.performImmediateUpdate();
          } else {
            Toast.showToast(
                message: 'You are using the latest version!', context: context);
          }
        },
      ),
      Btn(
        title: 'Logout',
        des: 'Logout of your account',
        type: 'setting',
        icon: Icons.logout_rounded,
        click: () => AuthRepo().signOut(context),
      ),
      Btn(
        title: 'DELETE ACCOUNT',
        des: 'Delete your umami account',
        type: 'setting',
        icon: Icons.delete_rounded,
        click: () {
          showDeleteAccountSheet(context);
        },
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
              title: 'Theme',
              btns: btns.where((e) => e.type == 'theme').toList(),
            ),
            _buildSettings(
              title: 'App',
              btns: btns.where((e) => e.type == 'app').toList(),
            ),
            _buildSettings(
              title: 'Github',
              btns: btns.where((e) => e.type == 'github').toList(),
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
