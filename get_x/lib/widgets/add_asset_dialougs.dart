import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_x/controllers/asset_controller.dart';
import 'package:get_x/models/api_response.dart';
import 'package:get_x/services/http_services.dart';

class AddAssetDialougsController extends GetxController {
  RxBool loading = false.obs;
  RxList<String> assets = <String>[].obs;
  RxString selectedAssets = "".obs;
  RxDouble assetVAlue = 0.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getassets();
  }

  Future<void> _getassets() async {
    loading.value = true;
    HttpServices httpServices = Get.find<HttpServices>();
    var responseData =
        await httpServices.get("https://api.cryptorank.io/v1/currencies");

    CurrenciesListAPIResponse currenciesListAPIResponse =
        CurrenciesListAPIResponse.fromJson(responseData);
    currenciesListAPIResponse.data?.forEach((coin) {
      assets.add(coin.name!);
    });
    selectedAssets.value = assets.first;
    loading.value = false;
  }
}

class AddAssetDialougs extends StatelessWidget {
  final controller = Get.put(AddAssetDialougsController());

  AddAssetDialougs({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: Material(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.40,
            width: MediaQuery.of(context).size.width * 0.80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: _BuildUI(context), // Call the function here
          ),
        ),
      ),
    );
  }

  Widget _BuildUI(
    BuildContext context,
  ) {
    if (controller.loading.isTrue) {
      return const Center(
        child: SizedBox(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButton(
                value: controller.selectedAssets.value,
                items: controller.assets.map((asset) {
                  return DropdownMenuItem(value: asset, child: Text(asset));
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedAssets.value = value;
                  }
                }),
            TextField(
              onChanged: (value) {
                controller.assetVAlue.value = double.parse(value);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            MaterialButton(
              onPressed: () {
                AssetController assetController = Get.find();
                assetController.addTrackedAssets(
                    controller.selectedAssets.value,
                    controller.assetVAlue.value);
                Get.back(closeOverlays: true);
              },
              color: Theme.of(context).colorScheme.primary,
              child: Text(
                'add icon',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      );
    }
  }
}
