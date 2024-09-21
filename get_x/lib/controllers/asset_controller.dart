import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/models/api_response.dart';
import 'package:get_x/models/coin_data.dart';
import 'package:get_x/models/tracked_asset.dart';
import 'package:get_x/services/http_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssetController extends GetxController {
  RxBool loading = false.obs;
  RxList<CoinData> coindata = <CoinData>[].obs;
  RxList<TrackedAsset> trackAsset = <TrackedAsset>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getAsstes();
    _load_tractedassetfronString();
  }

  Future<void> _getAsstes() async {
    loading.value = true;
    HttpServices httpServices = Get.find();

    var responsedata = await httpServices.get('currencies');
    CurrenciesListAPIResponse currenciesListAPIResponse =
        CurrenciesListAPIResponse.fromJson(responsedata);
    coindata.value = currenciesListAPIResponse.data ?? [];

    loading.value = false;
  }

  void addTrackedAssets(String name, double amount) async {
    trackAsset.add(TrackedAsset(name: name, amount: amount));

    List<String> data = trackAsset.map((asset) => jsonEncode(asset)).toList();

    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList("tracked_asset", data);
  }

  void _load_tractedassetfronString() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? data = pref.getStringList("tracked_asset");
    if (data != null) {
      trackAsset.value =
          data.map((e) => TrackedAsset.fromJson(jsonDecode(e))).toList();
    }
  }

  double getportfolioValue() {
    if (coindata.isEmpty) {
      return 0;
    }
    if (trackAsset.isEmpty) {
      return 0;
    }
    double value = 0;
    for (TrackedAsset asset in trackAsset) {
      value += getAssetPrice(asset.name!) * asset.amount!;
    }
    return value;
  }

  double getAssetPrice(String name) {
    CoinData? data = getCoinData(name);
    return data?.values?.uSD?.price?.toDouble() ?? 0;
  }

  CoinData? getCoinData(String name) {
    return coindata.firstWhereOrNull((e) => e.name == name);
  }
}
