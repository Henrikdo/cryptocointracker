

import 'package:flutter/material.dart';
import 'package:myapp/controllers/coin_controller.dart';
import 'package:myapp/utils/utils.dart';
import 'package:get/get.dart';
import 'package:myapp/views/home/coin_screen.dart';
import 'package:myapp/utils/utils.dart' as utils;
import 'package:myapp/models/coin_model.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

//ignore_for_file: prefer_const_constructors

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(CoinController());

  RxList<Coin> _foundcoins = <Coin>[].obs;

  @override
  Widget build(BuildContext context) {
    Future refresh() async {
      if (controller.inCooldown) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error!"),
              content: Text("an error has ocurred!"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        developer.log('refreshing');
        controller.fetchCoins();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: utils.mainBlue,
        title: Center(
            child: Text('Crypto Tracker',
                style: textStyle(25, Colors.white, FontWeight.w400))),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: RefreshIndicator(
          onRefresh: refresh,
          child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Obx(() => controller.isLoading.value
                  ? Center(
                      child: SpinKitSpinningLines(
                      size: 40,
                      color: utils.lightBlue,
                    ))
                  : Column(
                    children: [
                      _searchBar(),
                      _cryptoList(),
                    ],
                  ))),
        ),
      ),
    );
  }
}

Widget _searchBar() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const SizedBox(height: 20),
    TextField(
      onChanged: (value) => controller.runfilter(value),
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Search',
          suffixIcon: Icon(Icons.search)),
    ),
    const SizedBox(height: 20),
  ]);
}

Widget _cryptoList() {
  return Column(
    children: [
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.filtro.length,
        itemBuilder: (context, index) {
          double priceChange24H =
              controller.filtro[index].marketCapChangePercentage24H;
          Color percentageColor =
              priceChange24H < 0 ? Colors.red : Colors.green;

          return Column(
            key: ValueKey(controller.filtro[index].id),
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    var screen = CoinScreen(index: index);
                    Navigator.of(context).push(_createRoute(screen));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        utils.lightBlue,
                                        utils.mainBlue
                                      ]),
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: utils.lightBlue,
                                        offset: Offset(2, 2),
                                        blurRadius: 5)
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.network(
                                    controller.filtro[index].image,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: SpinKitSpinningLines(
                                      color: Colors.white,
                                    ),
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  Text(
                                    controller.filtro[index].name,
                                    style: textStyle(
                                        18, Colors.black, FontWeight.w500),
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    priceChange24H > 0
                                        ? '+${priceChange24H} %'
                                        : '${priceChange24H} %',
                                    style: textStyle(
                                        18, percentageColor, FontWeight.w300),
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                '\$${controller.filtro[index].currentPrice}',
                                style: textStyle(
                                    18, Colors.black, FontWeight.w200),
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                maxLines: 1,
                              ),
                              Text(
                                controller.filtro[index].symbol.toUpperCase(),
                                style:
                                    textStyle(18, Colors.grey, FontWeight.w600),
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                maxLines: 1,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(
                  height: 25,
                  thickness: 1,
                  indent: 8,
                  endIndent: 10,
                  color: Colors.grey),
            ],
          );
        },
      )
    ],
  );
}

Route _createRoute(screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
