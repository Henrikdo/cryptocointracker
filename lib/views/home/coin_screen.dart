
//import 'dart:developer' as developer;
import 'package:flutter/material.dart';

import 'package:myapp/controllers/coin_controller.dart';
import 'package:get/get.dart';
import 'package:myapp/utils/utils.dart';
import 'package:myapp/utils/utils.dart' as utils;
import 'package:flutter_spinkit/flutter_spinkit.dart';

final CoinController controller = Get.put(CoinController());

class CoinScreen extends StatefulWidget {
  CoinScreen({required this.index});

  final int index;

  @override
  State<CoinScreen> createState() => _CoinScreenState(index);
}

class _CoinScreenState extends State<CoinScreen> {
  int index = 0;
  int components = 1;
  _CoinScreenState(index);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double priceChange24H =
        controller.coinsList[widget.index].marketCapChangePercentage24H;
    Color percentageColor = priceChange24H < 0 ? Colors.red : Colors.green;
    double price = controller.coinsList[widget.index].currentPrice;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: utils.mainBlue,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text('Go Back',
            style: textStyle(18, Colors.white, FontWeight.w300)),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.3 + 3.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [utils.lightBlue, utils.mainBlue]),
                    boxShadow: [
                      BoxShadow(
                          color: utils.lightBlue,
                          offset: Offset(6, 6),
                          blurRadius: 5)
                    ]),
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Image.network(controller.coinsList[widget.index].image),
                        FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              controller.coinsList[widget.index].name,
                              style:
                                  textStyle(45, Colors.white, FontWeight.w500),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: IntrinsicHeight(
                  child: Container(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 100,
                              child: Text('Price ',
                                  style: textStyle(
                                      20, Colors.grey, FontWeight.w300)),
                            ),
                            Container(
                              width: 100,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text('US\$ ${price}',
                                    style: textStyle(
                                        20, Colors.black, FontWeight.w300)),
                              ),
                            ),
                          ],
                        ),
                        const VerticalDivider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 100,
                              child: Text('Changed ',
                                  style: textStyle(
                                      20, Colors.grey, FontWeight.w300)),
                            ),
                            Container(
                              width: 100,
                              child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                child: Text(
                                    priceChange24H > 0
                                        ? '+${priceChange24H} %'
                                        : '${priceChange24H} %',
                                    style: textStyle(
                                        20, percentageColor, FontWeight.w300)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: SpinKitSpinningLines(color: utils.lightBlue))
                    : Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: OutlinedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(utils.mainBlue),
                          ),
                          child: Text(
                            'Update',
                            style: textStyle(18, Colors.white, FontWeight.w300),
                          ),
                          onPressed: () {
                            controller.refresh();
                          },
                        )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
