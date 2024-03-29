import 'package:flutter/material.dart';
import 'package:new_project_flutter_udemy/data/network/failure.dart';
import 'package:new_project_flutter_udemy/presentation/resources/color_manager.dart';
import 'package:new_project_flutter_udemy/presentation/resources/font_manager.dart';
import 'package:new_project_flutter_udemy/presentation/resources/styles_manager.dart';

import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

enum StateRendrerType {
  //POPUP status(dialog)
  popupLoadingState,
  popupErrorState,

  //full screen states (full screen)
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,
  //general
  contentState
}

class StateRendrer extends StatelessWidget {
  StateRendrerType stateRendrerType;
  String message;
  String title;
  Function retryActionFunction;
  StateRendrer({
    required this.stateRendrerType,
    this.message = AppStrings.loading,
    this.title = "",
    required this.retryActionFunction,
  });

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendrerType) {
      case StateRendrerType.popupLoadingState:
        return _getPopUpDialog(
            context, [_getAnimatedImage(ImageAssets.loading)]);
      case StateRendrerType.popupErrorState:
        return _getPopUpDialog(context, [
          _getAnimatedImage(ImageAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.retryAgain, context)
        ]);
      case StateRendrerType.fullScreenLoadingState:
        return _getItemsColumn(
            [_getAnimatedImage(ImageAssets.loading), _getMessage(message)]);
      case StateRendrerType.fullScreenErrorState:
        return _getItemsColumn([
          _getAnimatedImage(ImageAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.retryAgain, context)
        ]);
      case StateRendrerType.fullScreenEmptyState:
        return _getItemsColumn(
            [_getAnimatedImage(ImageAssets.empty), _getMessage(message)]);
      case StateRendrerType.contentState:
        return Container();
      default:
        return Container();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: const [BoxShadow(color: Colors.black26)]),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children);
  }

  Widget _getItemsColumn(List<Widget> children) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children);
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Image(
        image: AssetImage(animationName),
      ),
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(message,
            style: getRegularStyle(
                color: ColorManager.black, fontSize: FontSize.s18)),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  if (stateRendrerType ==
                      StateRendrerType.fullScreenErrorState) {
                    //call retry function
                    retryActionFunction.call();
                  } else {
                    //popup erro state
                    Navigator.of(context).pop();
                  }
                },
                child: Text(buttonTitle))),
      ),
    );
  }
}
