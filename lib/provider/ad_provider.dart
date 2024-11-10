import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pomoslime/model/user_data_model.dart';
import 'package:pomoslime/utils/ad_helper.dart';

class AdProvider with ChangeNotifier {
  final UserDataModel _userData;

  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  AdProvider(this._userData) {
    _loadBannerAd();
    _loadInterstitialAd();
    _loadRewardedAd();
  }

  bool get isPremium => _userData.premium.isAfter(DateTime.now());

  // 배너 광고 로드
  void _loadBannerAd() {
    BannerAd(
      adUnitId: AdHelper.testBannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          _bannerAd = ad as BannerAd;
          notifyListeners();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          _loadBannerAd(); // 광고 로드 실패 시 다시 로드
        },
        onAdClosed: (Ad ad) {
          _loadBannerAd(); // 광고 닫힌 후 다시 로드
        },
      ),
    ).load();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.testInterstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              _loadInterstitialAd();
            },
          );

          _interstitialAd = ad;
        },
        onAdFailedToLoad: (err) {
          _interstitialAd?.dispose();
          _loadInterstitialAd();
        },
      ),
    );
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (err) {},
      ),
    );
  }

  // 배너 광고 위젯 반환
  Widget getBannerAdWidget() {
    if (!isPremium && _bannerAd != null) {
      return SizedBox(
        height: _bannerAd!.size.height.toDouble(),
        width: _bannerAd!.size.width.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  void showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd?.show();
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();

    super.dispose();
  }
}
