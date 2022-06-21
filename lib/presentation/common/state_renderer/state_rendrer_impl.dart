import 'package:flutter/material.dart';
import 'package:new_project_flutter_udemy/app/constants.dart';
import 'package:new_project_flutter_udemy/presentation/common/state_renderer/state_renderer.dart';

import '../../resources/strings_manager.dart';

abstract class FlowState {
  StateRendrerType getStateRendererType();
  String getMessage();
}

//loading state (Popup, full screen)

class LoadingState extends FlowState {
  StateRendrerType stateRendrerType;
  String? message;

  LoadingState(
      {required this.stateRendrerType, String message = AppStrings.loading});

  @override
  String getMessage() => message ?? AppStrings.loading;

  @override
  StateRendrerType getStateRendererType() => stateRendrerType;
}
//error state(popup, loading screen)

class ErrorState extends FlowState {
  StateRendrerType stateRendrerType;
  String message;

  ErrorState(this.stateRendrerType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendrerType getStateRendererType() => stateRendrerType;
}

//content state
class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => Constants.empty;

  @override
  StateRendrerType getStateRendererType() => StateRendrerType.contentState;
}

//empty state
class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendrerType getStateRendererType() =>
      StateRendrerType.fullScreenEmptyState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendrerType.popupLoadingState) {
            showPopup(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRendrer(
              message: getMessage(),
              stateRendrerType: getStateRendererType(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case ErrorState:
        {
          dismisDialog(context);
          if (getStateRendererType() == StateRendrerType.popupErrorState) {
            showPopup(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRendrer(
              message: getMessage(),
              stateRendrerType: getStateRendererType(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case EmptyState:
        {
          return StateRendrer(
            retryActionFunction: () {},
            stateRendrerType: getStateRendererType(),
            message: getMessage(),
          );
        }
      case ContentState:
        {
          dismisDialog(context);
          return contentScreenWidget;
        }
      default:
        dismisDialog(context);
        return contentScreenWidget;
    }
  }
}

_isCurrentDialogShowing(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;

dismisDialog(BuildContext context) {
  if (_isCurrentDialogShowing(context)) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}

showPopup(
    BuildContext context, StateRendrerType stateRendrerType, String message) {
  WidgetsBinding.instance.addPostFrameCallback(
    (_) => showDialog(
      context: context,
      builder: (BuildContext context) => StateRendrer(
        stateRendrerType: stateRendrerType,
        retryActionFunction: () {},
        message: message,
      ),
    ),
  );
}
