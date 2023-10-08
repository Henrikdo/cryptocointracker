import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:myapp/controllers/coin_controller%20copy.dart';
import 'package:myapp/utils/utils.dart' as utils;
import 'package:myapp/views/components/components.dart';
import 'package:myapp/views/home/home.dart';

class RefactoredHomeScreen extends StatelessWidget {
  RefactoredHomeScreen({super.key});

  final controller = Get.put(CoinController2());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() => Column(
            children: [
              _searchBar(),
              _criptoList(),
            ],
          )),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        onChanged: (value) => controller.runfilter(value),
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Search',
            suffixIcon: Icon(Icons.search)),
      ),
    );
  }

  Widget _criptoList() {
    var lista = controller.filtro.value;
    return controller.isLoading.value
        ? Center(
            child: SpinKitSpinningLines(
            size: 40,
            color: utils.lightBlue,
          ))
        : SizedBox(
            height: 620,
            child: ListView.builder(
              itemCount: controller.filtro.length,
              itemBuilder: (context, index) {
                return CriptoCard(
                  cotacao: lista[index].priceChange24H,
                  simbolo: lista[index].symbol,
                  titulo: lista[index].name,
                  valor: lista[index].currentPrice,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CoinScreen(index: index),
                    ),
                  ),
                  // controller.setCripto(lista[index])
                );
              },
            ),
          );
  }

  // TODO: Refazer o componente na tela
}
