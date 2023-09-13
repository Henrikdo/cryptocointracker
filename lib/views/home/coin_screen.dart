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
    
    
     double price = controller.coinsList[widget.index].currentPrice;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Home',style: textStyle(18,Colors.white,FontWeight.bold)),
      ),
      backgroundColor:  Colors.white,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width*0.8,
                height: MediaQuery.of(context).size.height*0.4,
                
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
                child: Column(
                  
                  children: [
                    Image.network(
                    controller.coinsList[widget.index].image),
                    Text(controller.coinsList[widget.index].name,style: textStyle(45,Colors.white, FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              
              child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              
                              Text('Price: \$ ${price}',
                              style: textStyle(35, Colors.grey, FontWeight.w700)
                              )
                            ]
                            
                          ),
                         
                          Obx(
                             () => controller.isLoading.value ? const Center(child:CircularProgressIndicator()): 
                             OutlinedButton(
                              onPressed: () {
                                if(controller.inCooldown){
                                  showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                            title: Text("Warning!"),
                                            content: Text("Email or Password is wrong!"),
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
                                    price = controller.coinsList[widget.index].currentPrice;
                                  });
                                }
                              },
                               child: Text('Update',style: textStyle(35, Colors.grey, FontWeight.w700),)
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

int updateValues(int price, ){
  int i = 0 ;
  return i;
}

