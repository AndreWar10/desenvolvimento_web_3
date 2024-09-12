import 'package:example_10_09/core/models/platform_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PlatformController extends ChangeNotifier {
  PlatformController();

  PlatformModel _platform = PlatformModel(isWeb: false, isMobile: false, isTablet: false);

  PlatformModel get platform => _platform;

  void updatePlatform(SizingInformation sizingInformation) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
      final newPlatformModel = PlatformModel.fromSizingInformation(sizingInformation);
      if (_platform != newPlatformModel) {
        _platform = newPlatformModel;
        notifyListeners();
      }
    });
  }




}