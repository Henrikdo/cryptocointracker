import 'package:myapp/models/coin_model.dart';
import 'package:myapp/repository/cripto_api.dart';
import 'package:myapp/services/coin_service_interface.dart';

class CoinService implements CoinServiceInterface {
  final CriptoApi _api = CriptoApi();

  @override
  Future<List<Coin>?> fetchCoins() async {
    try {
      var response = await _api.getCoins();
      List<Coin> coins = coinFromJson(response.body);
      if (response.statusCode == 200) {
        return coins;
      }
      throw Error();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Coin?> fetchCoin(String id) async {
    try {
      var response = await _api.getCoin(id);
      List<Coin> coins = coinFromJson(response.body);
      if (response.statusCode == 200) {
        return coins[0];
      }
      throw Error();
    } catch (e) {
      rethrow;
    }
  }
}
