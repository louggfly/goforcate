import 'package:get/get.dart';

class Dimension {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double gap2 = screenHeight / 410;
  static double gap5 = screenHeight / 164;
  static double gap10 = screenHeight / 82;
  static double gap15 = screenHeight / 54.6;
  static double gap20 = screenHeight / 41;
  static double gap25 = screenHeight / 35;
  static double gap30 = screenHeight / 27.3;

  static double fontSmall = screenHeight / 75;
  static double fontMedium = screenHeight / 60;
  static double fontBig = screenHeight / 37.2;
  static double icon20 = screenHeight / 41;
  static double icon30 = screenHeight / 27.3;
  static double icon40 = icon20 * 2;

  static double topContainer = screenHeight / 3.2;
  static double recommContainer = screenHeight / 2.56;
  static double recommPicContainer = screenHeight / 4;
  static double recommTextContainer = screenHeight / 6.5;
  static double ListPicContainer = screenHeight / 6.83;
  static double shopPicContainer = screenHeight / 3.2;
}
