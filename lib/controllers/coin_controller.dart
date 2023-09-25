import 'package:get/get.dart';
import 'package:myapp/models/coin_model.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/services/coin_service.dart';
import 'dart:developer' as developer;

class CoinController extends GetxController {
  CoinService coinService = Get.put(CoinService());
  
  RxBool isLoading = true.obs;
  RxList<Coin> coinsList = <Coin>[].obs;
  RxList<Coin> filtro = <Coin>[].obs;
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
      if (result != null) {
        coinsList.value = result;
        filtro.value = result;
        
      } else {
        inCooldown = true;
      }
    } catch (e) {
      developer.log(e.toString());
      return Future.error(e);
    }

    isLoading(false);
  }

  void runfilter(String enteredKeyword) {
    RxList<Coin> results = <Coin>[].obs;
    if (enteredKeyword.isEmpty) {
      results = coinsList;
    } else {
      results = coinsList
          .where((coin) =>
              coin.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList()
          .obs;
    }
    filtro.value = results;
  }
  Future refresh() async {
      
        developer.log('refreshing');
        fetchCoins();
      
    }


}
