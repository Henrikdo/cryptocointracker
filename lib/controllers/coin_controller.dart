import 'package:get/get.dart';
import 'package:myapp/models/coin_model.dart';
import 'package:myapp/services/coin_service.dart';
import 'dart:developer' as developer;
import 'package:myapp/utils/utils.dart';

class CoinController extends GetxController {
  CoinService coinService = Get.put(CoinService());

  RxBool isLoading = true.obs;
  RxList<Coin> coinsList = <Coin>[].obs;
  RxList<Coin> filtro = <Coin>[].obs;
  
  final status = Status.loading.obs;

  @override
  onInit() {
    super.onInit();
    fetchCoins();
  }


  fetchCoins() async {
    status.value = Status.loading;
    try {
      // controller faz a chamada
      // o service acessa o banco de dados
      // o repository busca o dado
      var result = await coinService.getCoins();
      if (result != null) {
        coinsList.value = result;
        filtro.value = result;
        status.value = Status.sucess;
      } else {
        status.value = Status.error;
      }
    } catch (e) {
      developer.log(e.toString());
      status.value = Status.error;
    }

    //status.value = Status.sucess;
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
    developer.log('refreshing : $status');
    fetchCoins();
  }

  Future<void> showDialog(context, alert) async {
    showDialog(context, alert);
  }
}
