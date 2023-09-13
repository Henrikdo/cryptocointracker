
import 'dart:convert';
import 'package:myapp/models/coin_model.dart';
import 'package:get/get.dart';
import'package:myapp/models/coin_model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;


class CoinService extends GetxService{
  
 
  
  fetchCoins(RxList<Coin> coinsList) async{
  

    try{
        var response = await http.get(
        Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en'));
        List<Coin> coins = coinFromJson(response.body);
        coinsList.value = coins;
      }catch (e){
        developer.log('error');
      }
  }
}
  


