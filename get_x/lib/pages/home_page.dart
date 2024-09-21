import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_x/controllers/asset_controller.dart';
import 'package:get_x/models/tracked_asset.dart';
import 'package:get_x/pages/detail_pages.dart';
import 'package:get_x/widgets/add_asset_dialougs.dart';
import 'package:get_x/widgets/utils.dart';

// ignore: must_be_immutable
class Homepage extends StatelessWidget {
  AssetController assetController = Get.find();

  Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget _appbar(BuildContext context) {
      return AppBar(
        title: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://png.pngtree.com/thumb_back/fh260/background/20230519/pngtree-landscape-jpg-wallpapers-free-download-image_2573540.jpg'),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.dialog(AddAssetDialougs());
              },
              icon: Icon(Icons.add))
        ],
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appbar(context),
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Column(
        children: [_portfolioValue(context), _trackassed(context)],
      ),
    ));
  }

  Widget _portfolioValue(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.03),
      child: Center(
        child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(children: [
              TextSpan(
                  text: "\$",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              TextSpan(
                  text:
                      "${assetController.getportfolioValue().toStringAsFixed(2)}\n",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400)),
              TextSpan(
                  text: 'portfolio value',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w300))
            ])),
      ),
    );
  }

  Widget _trackassed(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            child: Text(
              'portfolio',
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.65,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: assetController.trackAsset.length,
              itemBuilder: (context, index) {
                TrackedAsset trackedAsset = assetController.trackAsset[index];
                return ListTile(
                  leading: Image.network(getCryptoImage(trackedAsset.name!)),
                  title: Text(trackedAsset.name!),
                  subtitle: Text(
                      "USD: ${assetController.getAssetPrice(trackedAsset.name!).toStringAsFixed(3)}"),
                  trailing: Text(trackedAsset.amount.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black)),
                  onTap: () {
                    Get.to(DetailPages(
                        coin:
                            assetController.getCoinData(trackedAsset.name!)!));
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
