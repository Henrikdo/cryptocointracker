import 'package:http/http.dart' as http;

class CriptoApi {
  Future<http.Response> getCoins() async {
    try {
      return await http.get(Uri.parse(
        // acessa o .env e pega a url
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en'));
    } catch (err) {
      throw err;
    }
  }

  // update

  // delete

  // post

  // getOne
}
