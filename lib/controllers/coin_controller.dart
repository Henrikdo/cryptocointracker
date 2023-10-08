import 'package:get/get.dart';
import 'package:myapp/models/coin_model.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/services/coin_service.dart';
import 'dart:developer' as developer;

class CoinController extends GetxController {
  CoinService coinService = Get.put(CoinService());
  RxBool isLoading = true.obs;
  RxList<Coin> coinsList = <Coin>[].obs;
  bool inCooldown = false;

  @override
  onInit() {
    super.onInit();
    fetchCoins();
  }

  fetchCoins() async {
    try {
      isLoading(true);
      try {
        var response = await http.get(Uri.parse(
            'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en'));
        List<Coin> coins = coinFromJson(response.body);
        coinsList.value = coins;
        inCooldown = false;
      } catch (e) {
        inCooldown = true;
        developer.log('error: api call limit reached, try again later');
      }
    } finally {
      isLoading(false);
    }
  }
}
