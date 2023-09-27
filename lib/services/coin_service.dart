

import 'package:myapp/models/coin_model.dart';
import 'package:myapp/repository/cripto_api.dart';


class CoinService {
  final CriptoApi _api = CriptoApi();
 
  
  Future<List<Coin>?> fetchCoins() async{

    try{
        var response = await _api.getCoins();
        List<Coin> coins = coinFromJson(response.body);
        if(response.statusCode == 200){
          return coins;
        } 
        throw 'Erro';
      } catch (e){
        // TODO: tratamento de erros
        
        
        return Future.error(e);
      }
      // Utils.parseDate(date) <- String -> DateTime
  }
}
  


