// ignore_for_file: prefer_const_constructors

//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/pages/details.dart';
import 'package:fooddeliveryapp/service/database.dart';
import 'package:fooddeliveryapp/widgets/widget_support.dart';
import 'package:fooddeliveryapp/pages/order.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, pizza = false, salad = false, burger = false;

  Stream? fooditemStream;


  ontheload()async{
    fooditemStream=await DatabaseMethods().getFoodItem("Pizza");
    setState(() {

    });
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }
  Widget allItemsVertically(){
    backgroundColor: Colors.red.shade900;
    return StreamBuilder(stream: fooditemStream, builder: (context, AsyncSnapshot snapshot){
      return  snapshot.hasData? ListView.builder(

          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index){


            DocumentSnapshot ds=snapshot.data.docs[index];
            return  GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>Details(detail: ds["Detail"],name: ds["Name"], price: ds["Price"], image: ds["Image"],)));
              },
              child: Container(
                margin: EdgeInsets.only(right: 20.0, bottom: 20.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            ds["Image"],
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  ds["Name"],
                                  style: AppWidget.semiBoldTextFeildStyle(),
                                )),
                            SizedBox(
                              height: 5.0,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Fresh and Healthy",
                                  style: AppWidget.LightTextFeildStyle(),
                                )),
                            SizedBox(
                              height: 5.0,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "\₹"+ds["Price"],
                                  style: AppWidget.semiBoldTextFeildStyle(),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }):CircularProgressIndicator();
    });
  }
  Widget allItems(){
    backgroundColor: Colors.red.shade900;
    return StreamBuilder(stream: fooditemStream, builder: (context, AsyncSnapshot snapshot){
    return  snapshot.hasData? ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: snapshot.data.docs.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){


    DocumentSnapshot ds=snapshot.data.docs[index];
    return  GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Details(detail: ds["Detail"],name: ds["Name"], price: ds["Price"], image: ds["Image"],)));
      },
      child: Container(
        margin: EdgeInsets.all(4),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: EdgeInsets.all(14),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(

                      ds["Image"],
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(ds["Name"],
                      style:
                      AppWidget.semiBoldTextFeildStyle()),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("Fresh and Healthy",
                      style: AppWidget.LightTextFeildStyle()),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("\₹"+ds["Price"], style: AppWidget.semiBoldTextFeildStyle()),
                ]),
          ),
        ),
      ),
    );
}):CircularProgressIndicator();
    });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red.shade200,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hello Himanshu Lohote,",
                      style: AppWidget.boldTextFeildStyle()),
                  Container(
                    margin: EdgeInsets.only(right: 20.0),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("Delicious Food", style: AppWidget.HeadlineTextFeildStyle()),
              Text("Discover and Get Great Food",
                  style: AppWidget.LightTextFeildStyle()),
              SizedBox(
                height: 20.0,
              ),
              Container(
                  margin: EdgeInsets.only(right: 20.0), child: showItem()),
              SizedBox(
                height: 30.0,
              ),
              Container(
                  height:270,
                  child: allItems()),
              SizedBox(
                height: 30.0,
              ),
              // Container(
              //   margin: EdgeInsets.only(right: 20.0),
              //   child: Material(
              //     elevation: 5.0,
              //     borderRadius: BorderRadius.circular(20),
              //     child: Container(
              //       padding: EdgeInsets.all(5),
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Image.asset(
              //             "images/salad4.png",
              //             height: 120,
              //             width: 120,
              //             fit: BoxFit.cover,
              //           ),
              //           SizedBox(
              //             width: 20.0,
              //           ),
              //           Column(
              //             children: [
              //               SizedBox(
              //                   width: MediaQuery.of(context).size.width / 2,
              //                   child: Text(
              //                     "Mediterranean Chickpea Salad",
              //                     style: AppWidget.semiBoldTextFeildStyle(),
              //                   )),
              //               SizedBox(
              //                 height: 5.0,
              //               ),
              //               SizedBox(
              //                   width: MediaQuery.of(context).size.width / 2,
              //                   child: Text(
              //                     "Honey goot cheese",
              //                     style: AppWidget.LightTextFeildStyle(),
              //                   )),
              //               SizedBox(
              //                 height: 5.0,
              //               ),
              //               SizedBox(
              //                   width: MediaQuery.of(context).size.width / 2,
              //                   child: Text(
              //                     "\$28",
              //                     style: AppWidget.semiBoldTextFeildStyle(),
              //                   ))
              //             ],
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),

              allItemsVertically(),
              // Container(
              //   margin: EdgeInsets.only(right: 20.0),
              //   child: Material(
              //     elevation: 5.0,
              //     borderRadius: BorderRadius.circular(20),
              //     child: Container(
              //       padding: EdgeInsets.all(5),
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Image.asset(
              //             "images/salad2.png",
              //             height: 120,
              //             width: 120,
              //             fit: BoxFit.cover,
              //           ),
              //           SizedBox(
              //             width: 20.0,
              //           ),
              //           Column(
              //             children: [
              //               SizedBox(
              //                   width: MediaQuery.of(context).size.width / 2,
              //                   child: Text(
              //                     "Veggie Taco Hash",
              //                     style: AppWidget.semiBoldTextFeildStyle(),
              //                   )),
              //               SizedBox(
              //                 height: 5.0,
              //               ),
              //               SizedBox(
              //                   width: MediaQuery.of(context).size.width / 2,
              //                   child: Text(
              //                     "Honey goot cheese",
              //                     style: AppWidget.LightTextFeildStyle(),
              //                   )),
              //               SizedBox(
              //                 height: 5.0,
              //               ),
              //               SizedBox(
              //                   width: MediaQuery.of(context).size.width / 2,
              //                   child: Text(
              //                     "\$28",
              //                     style: AppWidget.semiBoldTextFeildStyle(),
              //                   ))
              //             ],
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async{
            icecream = true;
            pizza = false;
            salad = false;
            burger = false;
            fooditemStream=await DatabaseMethods().getFoodItem("Ice-cream");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: icecream ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/ice-cream.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: icecream ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            icecream = false;
            pizza = true;
            salad = false;
            burger = false;
            fooditemStream=await DatabaseMethods().getFoodItem("Pizza");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: pizza ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/pizza.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: pizza ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            icecream = false;
            pizza = false;
            salad = true;
            burger = false;
            fooditemStream=await DatabaseMethods().getFoodItem("Salad");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: salad ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/salad.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: salad ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            icecream = false;
            pizza = false;
            salad = false;
            burger = true;
            fooditemStream=await DatabaseMethods().getFoodItem("Burger");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: burger ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/burger.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: burger ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}























































// import 'package:flutter/material.dart';
// import 'package:fooddeliveryapp/widgets/widget_support.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   bool icecream = false, pizza = false, salad = false, burger = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Hello Himanshu Lohote,",
//                       style: AppWidget.boldTextFeildStyle()),
//                   Container(
//                     padding: const EdgeInsets.all(3),
//                     decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(8)),
//                     child: const Icon(
//                       Icons.shopping_cart_outlined,
//                       color: Colors.white,
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               Text("Delicious Food", style: AppWidget.HeadlineTextFeildStyle()),
//               Text("Discover and Get Great Food",
//                   style: AppWidget.LightTextFeildStyle()),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       icecream = true;
//                       pizza = false;
//                       salad = false;
//                       burger = false;
//                       setState(() {});
//                     },
//                     child: Material(
//                       elevation: 5.0,
//                       borderRadius: BorderRadius.circular(10),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: icecream ? Colors.black : Colors.white,
//                             borderRadius: BorderRadius.circular(10)),
//                         // decoration: BoxDecoration(
//                         //     color: icecream ? Colors.black : Colors.white,
//                         //     borderRadius: BorderRadius.circular(10)),
//                         padding: const EdgeInsets.all(8),
//                         child: Image.asset(
//                           "images/ice-cream.png",
//                           height: 40,
//                           width: 40,
//                           fit: BoxFit.cover,
//                           color: icecream ? Colors.white : Colors.black,
//                           // color: icecream ? Colors.white : Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       icecream = false;
//                       pizza = true;
//                       salad = false;
//                       burger = false;
//                       setState(() {});
//                     },
//                     child: Material(
//                       elevation: 5.0,
//                       borderRadius: BorderRadius.circular(10),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: pizza ? Colors.black : Colors.white,
//                             borderRadius: BorderRadius.circular(10)),
//                         // decoration: BoxDecoration(
//                         //     color: icecream ? Colors.black : Colors.white,
//                         //     borderRadius: BorderRadius.circular(10)),
//                         padding: const EdgeInsets.all(8),
//                         child: Image.asset(
//                           "images/pizza.png",
//                           height: 40,
//                           width: 40,
//                           fit: BoxFit.cover,
//                           color: pizza ? Colors.white : Colors.black,
//                           // color: icecream ? Colors.white : Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       icecream = false;
//                       pizza = false;
//                       salad = true;
//                       burger = false;
//                       setState(() {});
//                     },
//                     child: Material(
//                       elevation: 5.0,
//                       borderRadius: BorderRadius.circular(10),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: salad ? Colors.black : Colors.white,
//                             borderRadius: BorderRadius.circular(10)),
//                         // decoration: BoxDecoration(
//                         //     color: icecream ? Colors.black : Colors.white,
//                         //     borderRadius: BorderRadius.circular(10)),
//                         padding: const EdgeInsets.all(8),
//                         child: Image.asset(
//                           "images/salad.png",
//                           height: 40,
//                           width: 40,
//                           fit: BoxFit.cover,
//                           color: salad ? Colors.white : Colors.black,
//                           // color: icecream ? Colors.white : Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       icecream = false;
//                       pizza = false;
//                       salad = false;
//                       burger = true;
//                       setState(() {});
//                     },
//                     child: Material(
//                       elevation: 5.0,
//                       borderRadius: BorderRadius.circular(10),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: burger ? Colors.black : Colors.white,
//                             borderRadius: BorderRadius.circular(10)),
//                         // decoration: BoxDecoration(
//                         //     color: icecream ? Colors.black : Colors.white,
//                         //     borderRadius: BorderRadius.circular(10)),
//                         padding: const EdgeInsets.all(8),
//                         child: Image.asset(
//                           "images/burger.png",
//                           height: 40,
//                           width: 40,
//                           fit: BoxFit.cover,
//                           color: burger ? Colors.white : Colors.black,
//                           // color: icecream ? Colors.white : Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Material(
//                   //   elevation: 5.0,
//                   //   borderRadius: BorderRadius.circular(10),
//                   //   child: Container(
//                   //     padding: const EdgeInsets.all(8),
//                   //     child: Image.asset(
//                   //       "images/pizza.png",
//                   //       height: 40,
//                   //       width: 40,
//                   //       fit: BoxFit.cover,
//                   //     ),
//                   //   ),
//                   // ),
//                   // Material(
//                   //   elevation: 5.0,
//                   //   borderRadius: BorderRadius.circular(10),
//                   //   child: Container(
//                   //     padding: const EdgeInsets.all(8),
//                   //     child: Image.asset(
//                   //       "images/salad.png",
//                   //       height: 40,
//                   //       width: 40,
//                   //       fit: BoxFit.cover,
//                   //     ),
//                   //   ),
//                   // ),
//                   // Material(
//                   //   elevation: 5.0,
//                   //   borderRadius: BorderRadius.circular(10),
//                   //   child: Container(
//                   //     padding: const EdgeInsets.all(8),
//                   //     child: Image.asset(
//                   //       "images/burger.png",
//                   //       height: 40,
//                   //       width: 40,
//                   //       fit: BoxFit.cover,
//                   //     ),
//                   //   ),
//                   // ),
//                 ],
//               )
//             ],
//           )),
//     );
//   }
// }
