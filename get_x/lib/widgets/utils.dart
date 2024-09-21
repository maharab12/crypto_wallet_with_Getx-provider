import 'package:get/get.dart';
import 'package:get_x/controllers/asset_controller.dart';
import 'package:get_x/services/http_services.dart';

Future<void> registerServives() async {
  Get.put(HttpServices());
}

Future<void> registerController() async {
  Get.put(AssetController());
}

String getCryptoImage(String name) {
  return "https://raw.githubusercontent.com/ErikThiart/cryptocurrency-icons/master/128/${name.toLowerCase()}.png";
}
