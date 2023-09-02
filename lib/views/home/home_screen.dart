import 'package:flutter/material.dart';
import 'package:myapp/controllers/coin_controller.dart';
import 'package:myapp/utils/utils.dart';
import 'package:get/get.dart';
//ignore_for_file: prefer_const_constructors

class HomeScreen extends StatelessWidget {
  
  final CoinController controller = Get.put(CoinController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff494F55),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 20,top:50),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Crypto Market",
                style:textStyle(25, Colors.white, FontWeight.bold),
              ),
              Obx(
                ()=>  controller.isLoading.value
                 ? const Center(
                  child:CircularProgressIndicator()
                  ) 
                  : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.coinsList.length,
                  itemBuilder: (context,index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 20.0, top:30),
                      child: Container(
                    
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: const[
                                      Color.fromARGB(255, 4, 255, 12),Color.fromARGB(255, 187, 255, 0)
                                    ]),
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [BoxShadow(
                                      color:  Color.fromARGB(255, 179, 255, 0),
                                      offset: Offset(6, 6),
                                      blurRadius: 5
                                    )]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.network(
                                      controller.coinsList[index].image,
                                    ),
                                    
                                  ),
                                ),
                                const SizedBox(
                                  width: 20
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 8
                                      ),
                                    Text(controller.coinsList[index].name,
                                    style: textStyle(18, Colors.white, FontWeight.w600),
                                    ),
                                    Text('${controller.coinsList[index].priceChangePercentage24H} %',
                                    style: textStyle(18, Colors.grey, FontWeight.w600),
                                    )
                                  ],
                                ),
                                ],
                              ),
                            
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(
                                      height: 8
                                      ),
                                Text('\$${controller.coinsList[index].currentPrice}',
                                style: textStyle(18, Colors.white, FontWeight.w600),
                                ),
                                Text('${controller.coinsList[index].symbol}',
                                style: textStyle(18, Colors.grey, FontWeight.w600),
                                )
                              ],
                            )
                          ],  
                        ),
                      ),
                    );
                  },
                  ),
              )
              ]
            ),
        ),
      ),
    );
  }
}