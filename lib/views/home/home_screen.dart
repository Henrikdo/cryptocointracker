import 'package:flutter/material.dart';
import 'package:myapp/controllers/coin_controller.dart';
import 'package:myapp/utils/utils.dart';
import 'package:get/get.dart';
import 'package:myapp/views/components/components.dart';
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
      appBar: _appBar(),
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Obx(() => controller.isLoading.value
              ? ObxCircularProgression()
              : Column(
                  children: [_searchBar(), _cryptoList()],
                ))),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: utils.mainBlue,
      title: Center(
          child: Text('Crypto Tracker',
              style: textStyle(25, Colors.white, FontWeight.w400))),
    );
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
    var lista = controller.filtro.value;
    return Expanded(
        child: RefreshIndicator(
          onRefresh: controller.fetchCoins(),
          child: ListView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: controller.filtro.length,
              itemBuilder: (context, index) {
                return CriptoCard(
                    titulo: lista[index].name,
                    cotacao: lista[index].priceChange24H,
                    simbolo: lista[index].symbol,
                    valor: lista[index].currentPrice,
                    context: context,
                    onTap: ()=>{
                      Navigator.of(context).push(
                      _createRoute(
                        CoinScreen(index: index),
                        ),
                      )
                    },
                    image: lista[index].image);
              }),
        ));
  }
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
