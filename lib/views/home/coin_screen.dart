//import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:myapp/controllers/coin_controller.dart';
import 'package:get/get.dart';
import 'package:myapp/models/coin_model.dart';
import 'package:myapp/utils/utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myapp/views/components/coin_info_column.dart';

final CoinController controller = Get.put(CoinController());

class CoinScreen extends StatelessWidget {
  const CoinScreen({
    required this.coin,
    super.key,
  });

  final Coin coin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: mainBlue,
          leading: const BackButton(
            color: Colors.white,
          ),
          title: Text('Go Back',
              style: textStyle(18, Colors.white, FontWeight.w300)),
        ),
        body: Center(
          child: Obx(() => controller.status.value == Status.loading
              ? Center(child: SpinKitSpinningLines(color: lightBlue))
              : Column(children: [
                  _imageBox(context),
                  _infoColumns(),
                  _updateButton()
                ])),
        ));
  }

  Widget _updateButton() {
    return Center(
      child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: OutlinedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(mainBlue),
            ),
            child: Text(
              'Update',
              style: textStyle(18, Colors.white, FontWeight.w300),
            ),
            onPressed: () {
              controller.refresh();
            },
          )),
    );
  }

  Widget _infoColumns() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Container(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CoinInfoColumn(
              label: Text('Price ',
                  style: textStyle(20, Colors.grey, FontWeight.w300)),
              info: Text('US\$ ${coin.currentPrice}',
                  style: textStyle(20, Colors.black, FontWeight.w300)),
            ),
            const VerticalDivider(
              thickness: 1,
              color: Colors.grey,
            ),
            CoinInfoColumn(
              label: Text('Changed ',
                  style: textStyle(20, Colors.grey, FontWeight.w300)),
              info: Text('${coin.priceChange24H.toStringAsFixed(6)} %',
                  style: textStyle(
                      20,
                      coin.priceChange24H > 0 ? Colors.green : Colors.red,
                      FontWeight.w300)),
            )
          ],
        ),
      ),
    );
  }

  Widget _imageBox(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.3 + 3.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [lightBlue, mainBlue]),
            boxShadow: [
              BoxShadow(color: lightBlue, offset: Offset(6, 6), blurRadius: 5)
            ]),
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Image.network(coin.image),
                FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      coin.name,
                      style: textStyle(45, Colors.white, FontWeight.w500),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
