import 'package:flutter/material.dart';
import 'package:myapp/controllers/coin_controller.dart';
import 'package:myapp/utils/utils.dart';
import 'package:get/get.dart';
import 'package:myapp/views/home/coin_screen.dart';
//ignore_for_file: prefer_const_constructors

class HomeScreen extends StatelessWidget {
  
  final CoinController controller = Get.put(CoinController());

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 160, 255, 131),
        title: Center(child: Text('Crypto Tracker',style: textStyle(25,Colors.white,FontWeight.bold))),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 20),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                     height: 8
                                              
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
                    
                    double priceChange24H = controller.coinsList[index].marketCapChangePercentage24H;
                    Color percentageColor = priceChange24H < 0 ?  Colors.red: const Color.fromARGB(255, 0, 255, 8);

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: (){
                              var screen = CoinScreen(index: index);
                              Navigator.of(context).push(_createRoute(screen));
                            },
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
                                            offset: Offset(2, 2),
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
                                      Container(
                                        width:MediaQuery.of(context).size.width*0.3,
                                  
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          
                                          children: [
                                            const SizedBox(
                                              height: 8
                                              
                                              ),
                                            Text(controller.coinsList[index].name,
                                            style: textStyle(18, Colors.black, FontWeight.w500),
                                            overflow: TextOverflow.fade,
                                            softWrap: false,
                                            maxLines: 1,
                                            
                                            ),
                                            Text(priceChange24H> 0 ?'+${priceChange24H} %' :'${priceChange24H} %',
                                            style: textStyle(18, percentageColor, FontWeight.w300),
                                            overflow: TextOverflow.fade,
                                            softWrap: false,
                                            maxLines: 1,
                                            ),
                                            
                                          ],
                                        ),
                                      ),
                                      ],
                                    ),
                                  
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        const SizedBox(
                                              height: 8
                                              ),
                                        Text('\$${controller.coinsList[index].currentPrice}',
                                        style: textStyle(18, Colors.black, FontWeight.w200),
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        maxLines: 1,
                                        ),
                                        Text(controller.coinsList[index].symbol.toUpperCase(),
                                        style: textStyle(18, Colors.grey, FontWeight.w600),
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        maxLines: 1,
                                        )
                                      ],
                                    ),
                                  )
                                  
                                ],  
                              ),
                              
                            ),
                            
                          ),
                          
                        ),
                        const Divider(
                                      height: 25,
                                      thickness: 1,
                                      indent: 8,
                                      endIndent: 10,
                                      color: Colors.grey),
                      ],
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

Route _createRoute(screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}