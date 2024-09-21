import 'package:flutter/material.dart';
import 'package:get_x/models/coin_data.dart';
import 'package:get_x/widgets/utils.dart';

class DetailPages extends StatelessWidget {
  final CoinData coin;
  const DetailPages({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(coin.name!),
      ),
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02),
      child: Column(
        children: [_assetPrice(context), _assetInfo(context)],
      ),
    ));
  }

  Widget _assetPrice(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.10,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Image.network(getCryptoImage(coin.name!)),
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "\$ ${coin.values?.uSD?.price?.toStringAsFixed(3)}\n",
                style: TextStyle(fontSize: 25)),
            TextSpan(
                text:
                    " ${coin.values?.uSD?.percentChange24h?.toStringAsFixed(3)}%",
                style: TextStyle(
                    fontSize: 15,
                    color: coin.values!.uSD!.percentChange24h! > 0
                        ? Colors.green
                        : Colors.red)),
          ]))
        ],
      ),
    );
  }

  Widget _assetInfo(BuildContext context) {
    return Expanded(
        child: GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.9),
      children: [
        _infocar('Total Supply', coin.totalSupply.toString()),
        _infocar('Maximuin Supply', coin.maxSupply.toString()),
        _infocar('Circulating Supply', coin.circulatingSupply.toString())
      ],
    ));
  }

  Widget _infocar(title, stubtitle) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 141, 137, 137),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            stubtitle,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
