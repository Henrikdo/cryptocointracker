import 'package:get/get.dart';
import 'package:myapp/models/coin_model.dart';
import 'package:myapp/services/coin_service.dart';
import 'dart:developer' as developer;

class CoinController2 extends GetxController {
  CoinService coinService = CoinService();
  RxBool isLoading = true.obs;
  RxList<Coin> coinsList = <Coin>[].obs;
  RxList<Coin> filtro = <Coin>[].obs;

  // Coin coin;

  // void setCoin(Coin coin)

  bool inCooldown = false;

  @override
  onInit() {
    super.onInit();
    fetchCoins();
  }

  fetchCoins() async {
    isLoading(true);
    try {
      // controller faz a chamada
      // o service acessa o banco de dados
      // o repository busca o dado
      var result = await coinService.fetchCoins(); 
      if(result != null){
        coinsList.value = result;
        filtro.value = result;
      } else {
        developer.log('error');
        inCooldown = true;
      }
    } catch (e) {
      developer.log(e.toString());
    }

    isLoading(false);
  }

  void runfilter(String enteredKeyword) {
    List<Coin> results = [];
    if (enteredKeyword.isEmpty) {
      results = coinsList;
    } else {
      results = coinsList
          .where((coin) =>
              coin.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    filtro.value = results;
  }
}
