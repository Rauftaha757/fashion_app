import 'dart:ui';
import 'package:exp/model_classes/items_list.dart';
import 'package:exp/provider/cart_provider.dart';
import 'package:exp/provider/counter%20provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'checkout_page.dart';

class cart extends StatefulWidget {
  @override
  State<cart> createState() => _CartState();
}

class _CartState extends State<cart> {
  @override
  Widget build(BuildContext context) {
    final List<item_model_class> items =
    Provider.of<cart_provider>(context).getallitems();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back arrow
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Material(
                      elevation: 2,
                      shape: const CircleBorder(),
                      color: Colors.white,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.arrowLeft,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Name in the middle
                  Column(
                    children: const [
                      Text(
                        "T A Y L O R",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          fontSize: 26,
                        ),
                      ),
                      Text(
                        "S H A W N",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  // Trash icon
                  Material(
                    elevation: 2,
                    shape: const CircleBorder(),
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        Provider.of<cart_provider>(context, listen: false)
                            .clear();
                        Provider.of<counter_provider>(context, listen: false)
                            .clearcounter();
                      },
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          border: Border.all(color: const Color(0xFFF8F8F8)),
                        ),
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.trash,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // MY CART Title
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "MY CART",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  fontSize: 26,
                ),
              ),
            ),

            // Cart List
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                        color: Colors.grey.shade300,
                      ),
                      child: Row(
                        children: [
                          // Item Image
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(21),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(21),
                                child: Image.asset(
                                  item.image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),

                          // Name and Price
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins",
                                      fontSize: 18,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "${Provider.of<counter_provider>(context).getItemCount(item.name)} x ${item.price}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins",
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Counter
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(21),
                              child: BackdropFilter(
                                filter:
                                ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                                child: Container(
                                  width: 50,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(21),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Provider.of<counter_provider>(
                                              context,
                                              listen: false)
                                              .increment(item.name);
                                        },
                                        child: const Icon(Icons.add),
                                      ),
                                      Text(
                                        "${Provider.of<counter_provider>(context).getItemCount(item.name)}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Poppins",
                                          fontSize: 20,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Provider.of<counter_provider>(
                                              context,
                                              listen: false)
                                              .decrement(item.name);
                                        },
                                        child: const Icon(Icons.remove),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),


            Container(
             width: 400,
              height: 150,
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey.shade300
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                         Text("Total",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    color: Colors.green,
                    fontSize: 25,
                  ),),
                        SizedBox(
                          width: 140,
                        ),
                        Text("\$${Provider.of<counter_provider>(context).getTotalPrice()}",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontFamily: "Poppins",
                          fontSize: 25,
                        ))
                      ],
                    )
                  ),
                  SizedBox(
                    width: 350,
                    height: 60,
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Checkout()));
                    }  ,style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6E8C6D),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        ), child: Text("Pay And confirm address",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.75),
                      fontFamily: "Poppins",
                      fontSize: 22,
                    ))),
                  )
                ],
              ),



       
            ),
          ],
        ),
      ),
    );
  }
}
