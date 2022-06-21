import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_project_flutter_udemy/app/app_prefs.dart';
import 'package:new_project_flutter_udemy/data/data_source/local_data_source.dart';
import 'package:new_project_flutter_udemy/presentation/resources/assets_manager.dart';
import 'package:new_project_flutter_udemy/presentation/resources/language_manager.dart';
import 'package:new_project_flutter_udemy/presentation/resources/routes_manager.dart';
import '../../../../app/di.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import 'dart:math' as math;

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPrefrences _appPrefrences = instance<AppPrefrences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(AppPadding.p8),
        children: [
          ListTile(
            title: Text(
              AppStrings.changeLanguage.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            leading: SvgPicture.asset(ImageAssets.changeLangIc),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationX(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.rightArrowSettings),
            ),
            onTap: () {
              _changeLanguage();
            },
          ),
          ListTile(
            title: Text(
              AppStrings.contactUs.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            leading: SvgPicture.asset(ImageAssets.contactUs),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.rightArrowSettings),
            ),
            onTap: () {
              _contactUs();
            },
          ),
          ListTile(
            title: Text(
              AppStrings.inviteYourFriends.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            leading: SvgPicture.asset(ImageAssets.inviteFriends),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.rightArrowSettings),
            ),
            onTap: () {
              _inviteFriends();
            },
          ),
          ListTile(
            title: Text(
              AppStrings.logOut.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            leading: SvgPicture.asset(ImageAssets.logOut),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.rightArrowSettings),
            ),
            onTap: () {
              _logOut();
            },
          ),
        ],
      ),
    );
  }

  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }

  _changeLanguage() {
    //implement it later
    _appPrefrences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  _contactUs() {}
  _inviteFriends() {}

  _logOut() {
    _appPrefrences.logout();
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
