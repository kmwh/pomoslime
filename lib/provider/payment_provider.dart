import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:pomoslime/model/user_data_model.dart';

class PaymentProvider with ChangeNotifier {
  final UserDataModel _userData;
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  final String _productId = "coffee_for_developers";
  bool _isLoading = false;
  ProductDetails? _product;

  PaymentProvider(this._userData) {
    _initialize();
  }

  bool get isPremium => _userData.premium;

  bool get isLoading => _isLoading;

  void _initialize() {
    // 결제 상태 변화를 감지하는 이벤트 구독
    final purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchases) {
      _handlePurchaseUpdates(purchases);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // 결제 관련 에러 처리
      debugPrint("Purchase error: $error");
      _subscription.cancel();
    });

    // _product에 상품 불러오기
    getAvailableProducts();
  }

  Future<void> getAvailableProducts() async {
    _isLoading = true;
    notifyListeners();

    final bool available = await _inAppPurchase.isAvailable();
    if (!available) {
      debugPrint("In-App Purchase system unavailable");
    }

    final ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails(<String>{_productId});
    if (response.notFoundIDs.isNotEmpty) {
      debugPrint("Some products were not found");
    } else {
      _product = response.productDetails.first;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> purchaseProduct() async {
    if (_product != null) {
      _isLoading = true;
      notifyListeners();

      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: _product!);
      await _inAppPurchase.buyNonConsumable(
          purchaseParam: purchaseParam); // 비소모성 아이템 구매
      // _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);  // 소모성 아이템 구매

      _isLoading = false;
      notifyListeners();
    }
  }

  void _handlePurchaseUpdates(List<PurchaseDetails> purchases) {
    for (var purchase in purchases) {
      if (purchase.status == PurchaseStatus.pending) {
        // 결제 처리 중 상태
        debugPrint("Purchase is pending...");
      } else if (purchase.status == PurchaseStatus.purchased) {
        // 결제 성공 시 처리
        _userData.premium = true;
        debugPrint("Purchase successful");
        notifyListeners();
      } else if (purchase.status == PurchaseStatus.error) {
        // 결제 오류 발생 시
        debugPrint("Error purchasing: ${purchase.error}");
      }
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
