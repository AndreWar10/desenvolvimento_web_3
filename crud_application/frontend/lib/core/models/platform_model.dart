import 'package:responsive_builder/responsive_builder.dart';

class PlatformModel {
  final bool isWeb;
  final bool isMobile;
  final bool isTablet;

  PlatformModel({required this.isWeb, required this.isMobile, required this.isTablet});

  factory PlatformModel.fromSizingInformation(SizingInformation sizingInformation) {
    return PlatformModel(
      isWeb: sizingInformation.deviceScreenType == DeviceScreenType.desktop,
      isMobile: sizingInformation.deviceScreenType == DeviceScreenType.mobile,
      isTablet: sizingInformation.deviceScreenType == DeviceScreenType.tablet,
    );
  }
}