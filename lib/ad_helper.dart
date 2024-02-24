import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3381772824141995/5237077242';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3381772824141995/9647079639';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3381772824141995/6087124483';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3381772824141995/7515261387';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
