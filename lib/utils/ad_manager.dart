import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  // 싱글톤 인스턴스
  static final AdManager _instance = AdManager._internal();
  factory AdManager() {
    return _instance;
  }
  AdManager._internal();

  // 4개의 배너 광고와 리워드 광고 변수
  final List<BannerAd?> _bannerAds = List.filled(4, null);
  final List<bool> _isBannerAdReady = List.filled(4, false);
  RewardedAd? _rewardedAd;
  bool _isRewardedAdReady = false;

  // 배너 광고 로드 (index로 구분)
  void loadBannerAd(int index, String adUnitId) {
    if (index < 0 || index >= _bannerAds.length) return;

    _bannerAds[index] = BannerAd(
      adUnitId: adUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          _isBannerAdReady[index] = true;
          print('배너 광고 ${index + 1} 로드 완료');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('배너 광고 ${index + 1} 로드 실패: ${error.message}');
          ad.dispose();
          _isBannerAdReady[index] = false;
          loadBannerAd(index, adUnitId); // 광고 로드 실패 시 다시 로드
        },
        onAdOpened: (Ad ad) {
          print('배너 광고 ${index + 1} 클릭 후 외부 페이지로 이동');
        },
        onAdClosed: (Ad ad) {
          print('배너 광고 ${index + 1} 닫힘');
          loadBannerAd(index, adUnitId); // 광고 닫힌 후 다시 로드
        },
      ),
    );
    _bannerAds[index]!.load();
  }

  // 배너 광고 위젯 반환 (index로 구분)
  Widget getBannerAdWidget(int index) {
    if (index < 0 || index >= _bannerAds.length) return const SizedBox.shrink();

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
  void loadRewardedAd(String adUnitId) {
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          _isRewardedAdReady = true;
          print('리워드 광고 로드 완료');
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('리워드 광고 로드 실패: ${error.message}');
          _isRewardedAdReady = false;
          loadRewardedAd(adUnitId); // 리워드 광고 로드 실패 시 다시 로드
        },
      ),
    );
  }

  // 리워드 광고 표시
  void showRewardedAd() {
    if (_isRewardedAdReady && _rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('사용자가 리워드를 획득: ${reward.amount} ${reward.type}');
        },
      );
      loadRewardedAd('ca-app-pub-3940256099942544/5224354917'); // 다음 광고를 로드
    } else {
      print('리워드 광고가 준비되지 않음');
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
