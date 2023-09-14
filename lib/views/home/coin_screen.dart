import 'dart:math';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:myapp/models/coin_model.dart';
import 'package:myapp/controllers/coin_controller.dart';
import 'package:get/get.dart';
import 'package:myapp/utils/utils.dart';
import 'package:async/async.dart';

final CoinController controller = Get.put(CoinController());

class CoinScreen extends StatefulWidget {
  
  int index = 0;
  CoinScreen({required this.index});
  

  @override
  State<CoinScreen> createState() => _CoinScreenState(index);
}

class _CoinScreenState extends State<CoinScreen> {
  
  int index = 0;
  
  _CoinScreenState(index);
  
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    
    double priceChange24H = controller.coinsList[widget.index].marketCapChangePercentage24H;
    Color percentageColor = priceChange24H < 0 ?  Colors.red: const Color.fromARGB(255, 0, 255, 8);
    double price = controller.coinsList[widget.index].currentPrice;

    

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(246, 115, 255, 0),
        title: Text('Go Back',style: textStyle(18,Colors.black,FontWeight.bold)),
      ),
      backgroundColor:  Colors.white,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width*0.6,
                height: MediaQuery.of(context).size.height*0.4 + 3.2,
                
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                   Color.fromARGB(255, 4, 255, 12),Color.fromARGB(255, 187, 255, 0)
                  ]),
                  boxShadow: const [BoxShadow(
                      color:  Color.fromARGB(255, 179, 255, 0),
                      offset: Offset(6, 6),
                      blurRadius: 5
                  )]
            
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    
                    children: [
                      Image.network(
                      controller.coinsList[widget.index].image),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(controller.coinsList[widget.index].name,style: textStyle(45,Colors.white, FontWeight.w900),
                        )
                      ),
                    ],
                  ),
                ),
                
              ),
            ),
            Container(
              
              child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Price: ',
                              style: textStyle(20, Colors.grey, FontWeight.w700)
                              ),
                              Text('US\$ ${price}',
                              style: textStyle(20, Colors.black, FontWeight.w700)
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Changed: ',
                              style: textStyle(20, Colors.grey, FontWeight.w700)
                              ),
                              Text(priceChange24H> 0 ?'+${priceChange24H} %' :'${priceChange24H} %',
                              style: textStyle(20, percentageColor, FontWeight.w700)
                              ),
                            ],
                          ),
                   
                          Center(
                            child: Obx(
                               () => controller.isLoading.value ? const Center(child:CircularProgressIndicator()): 
                               Padding(
                                 padding: const EdgeInsets.only(top: 18.0),
                                 child: OutlinedButton(
                                  
                                  onPressed: () {
                                    if(controller.inCooldown){
                                      showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                                title: Text("Error!"),
                                                content: Text("an error with the api has ocurred!"),
                                                  actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("OK"),
                                                    ),
                                                  ],
                                                );
                                                },
                                            );
                                    }else{
                                      setState((){
                                        controller.fetchCoins();
                                        priceChange24H = controller.coinsList[widget.index].marketCapChangePercentage24H;
                                        price = controller.coinsList[widget.index].currentPrice;
                                      });
                                    }
                                  },
                                   style: OutlinedButton.styleFrom( backgroundColor: Color.fromARGB(255, 21, 255, 0),),
                                   child: Text('Reload',style: textStyle(28, Colors.white, FontWeight.w700),)
                                                           ),
                               ),
                            ),
                          )
                        ],
                      ),
                      
                    ),
            )
          ],
        ),
      ),

      
    );
    
  }
}



