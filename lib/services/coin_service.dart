
import 'dart:convert';
import 'package:myapp/models/coin_model.dart';
import 'package:get/get.dart';
import'package:myapp/models/coin_model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'package:myapp/repository/cripto_api.dart';


class CoinService {
  final CriptoApi _api = CriptoApi();
 
  
  Future<List<Coin>?> fetchCoins(String date) async{

    try{
        var response = await _api.getCoins();
        List<Coin> coins = coinFromJson(response.body); // converter de json para objeto
        return coins;
      } catch (e){
        // TODO: tratamento de erros
        developer.log('error');
        return null;
      }
      // Utils.parseDate(date) <- String -> DateTime
  }
}
  


