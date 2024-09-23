import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pomoslime/model/user_data_model.dart';

class AdProvider with ChangeNotifier {
  final UserDataModel _userData;

  final List<String> _bannerIds = [
    "ca-app-pub-3940256099942544/9214589741",
    "ca-app-pub-3940256099942544/9214589741",
    "ca-app-pub-3940256099942544/9214589741",
  ];
  final String _rewardId = "ca-app-pub-3940256099942544/5224354917";

  final List<BannerAd?> _bannerAds = List.filled(3, null);
  final List<bool> _isBannerAdReady = List.filled(3, false);
  RewardedAd? _rewardedAd;
  bool _isRewardedAdReady = false;

  AdProvider(this._userData) {
    for (int i = 0; i < _bannerIds.length; i++) {
      loadBannerAd(i);
    }
    loadRewardedAd();
  }

  bool get isPremium =>
      DateTime.now().difference(_userData.premium).inHours < 24;

  // 배너 광고 로드
  void loadBannerAd(int index) {
    if (index < 0 || index >= _bannerAds.length) return;

    _bannerAds[index] = BannerAd(
      adUnitId: _bannerIds[index],
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          _isBannerAdReady[index] = true;
          debugPrint('배너 광고 ${index + 1} 로드 완료');
          notifyListeners();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint('배너 광고 ${index + 1} 로드 실패: ${error.message}');
          ad.dispose();
          _isBannerAdReady[index] = false;
          loadBannerAd(index); // 광고 로드 실패 시 다시 로드
        },
        onAdClosed: (Ad ad) {
          debugPrint('배너 광고 ${index + 1} 닫힘');
          loadBannerAd(index); // 광고 닫힌 후 다시 로드
        },
      ),
    );
    _bannerAds[index]!.load();
  }

  // 배너 광고 위젯 반환
  Widget getBannerAdWidget(int index) {
    if (index < 0 || index >= _bannerAds.length || isPremium) {
      return const SizedBox.shrink();
    }

    if (_isBannerAdReady[index] && _bannerAds[index] != null) {
      return SizedBox(
        height: _bannerAds[index]!.size.height.toDouble(),
        width: _bannerAds[index]!.size.width.toDouble(),
        child: AdWidget(ad: _bannerAds[index]!),
      );
    } else {
      return const SizedBox.shrink(); // 광고 로딩 중일 때 빈 공간 반환
    }
  }

  // 리워드 광고 로드
  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: _rewardId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          _isRewardedAdReady = true;
          debugPrint('리워드 광고 로드 완료');
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('리워드 광고 로드 실패: ${error.message}');
          _isRewardedAdReady = false;
          loadRewardedAd(); // 리워드 광고 로드 실패 시 다시 로드
        },
      ),
    );
  }

  // 리워드 광고 표시
  void showRewardedAd(BuildContext context) {
    if (_isRewardedAdReady && _rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          debugPrint('사용자가 리워드를 획득: ${reward.amount} ${reward.type}');
          _userData.premium = DateTime.now();
          notifyListeners();
        },
      );
      loadRewardedAd(); // 다음 광고를 로드
    } else {
      debugPrint('리워드 광고가 준비되지 않음');
    }
  }

  // 배너 광고 및 리워드 광고 해제
  void disposeAds() {
    for (var bannerAd in _bannerAds) {
      bannerAd?.dispose();
    }
    _rewardedAd?.dispose();
  }
}
