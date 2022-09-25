import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsManager extends StatelessWidget {
  AdsManager({Key? key}) : super(key: key);

  static final AdManagerBannerAdListener bannerAdListener =
      AdManagerBannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => debugPrint('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      debugPrint('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => debugPrint('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => debugPrint('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => debugPrint('Ad impression.'),
  );

  final AdManagerBannerAd banner = AdManagerBannerAd(
    adUnitId: getAdUnitId(),
    sizes: [AdSize.banner],
    request: const AdManagerAdRequest(),
    listener: bannerAdListener,
  );

  static String getAdUnitId() {
    var adUnitId = "/6499/example/banner";
    if (Platform.isAndroid) {
      adUnitId = const String.fromEnvironment(
          "GOOGLE_ADS_MANAGER_UNIT_ID_ANDROID",
          defaultValue: "/6499/example/banner");
    } else if (Platform.isIOS) {
      adUnitId = const String.fromEnvironment("GOOGLE_ADS_MANAGER_UNIT_ID_IOS",
          defaultValue: "/6499/example/banner");
    }

    return adUnitId;
  }

  @override
  Widget build(BuildContext context) {
    banner.load();

    return AdWidget(ad: banner);
  }
}
