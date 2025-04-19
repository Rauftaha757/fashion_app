
import 'dart:ui';
import 'package:exp/model_classes/category_list.dart';
import 'package:exp/model_classes/items_list.dart';
import 'package:exp/provider/counter%20provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:exp/provider/stock_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class details extends StatefulWidget{
  final  item_model_class index ;
  details({
   required this.index

});

  @override
  State<StatefulWidget> createState() {

    return _details();
  }

}

class _details extends State<details>{



  @override

  Widget build(BuildContext context) {

    final item = widget.index;

    return Scaffold(
      body:   SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back arrow
                  Material(
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
// taha is great
                  // Name in the middle
                  Column(
                    children: const [
                      Text(
                        "T A Y L O R ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                            fontSize: 26),
                      ),
                      Text(
                        " S H A W N ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                            fontSize: 22),
                      ),
                    ],
                  ),

                  // Shopping bag icon
                  Material(
                    elevation: 2,
                    shape: const CircleBorder(),
                    color: Colors.white,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(color: Color(0xFFF8F8F8)),
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.bagShopping,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Center(
                  child: Container(
                    width: 380,
                    height: 400,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.grey.shade300,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                          offset: Offset(0, 10),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        item.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${item.name}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                              fontSize: 22),
                          maxLines:2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),

                    ],
                  ),
                ),

                // Text(
                //   "\$2000",
                //   style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontFamily: "Poppins",
                //       fontSize: 22),
                // ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20,left:23),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "\$${item.price}",
                        style:
                        TextStyle(

                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                            fontSize: 35
                        ),
                      ),
                    ],
                  ),
                ),
                  Padding(
                  padding: const EdgeInsets.only(bottom:30.0),
                   child: ClipRRect(
                                     borderRadius: BorderRadius.circular(21),
                                    child: BackdropFilter(
                                     filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                   child: Container(
                                     width: 200,
                   height: 50,
                     decoration: BoxDecoration(
                                   color: Color(0x55D1D1D1), // greyish transparent glass feel
                       // borderRadius: BorderRadius.circular(21),
                                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                   ),
                                   child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children:  [
                                 InkWell(onTap: (){
                                   Provider.of<counter_provider>(context,listen: false).decrement();
                                 },
                                     child: Icon(Icons.remove, color: Colors.black)),
                       Text(

                       "${ Provider.of<counter_provider>(context,listen: true).getcount()}",
                       style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                       color: Colors.black87,
                       ),
                                 ),
                       InkWell(onTap: (){
                         Provider.of<counter_provider>(context,listen: false).increament();
                       },child: Icon(Icons.add, color: Colors.black87)),
                       ],
                       ),
                       ),
                       ),
                       ),
    ),

                SizedBox(
                  width: 300,
                  height: 60,
                  child: ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6E8C6D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    minimumSize: const Size(200, 70),
                  ), child:   Text(
                    "Add to Cart",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                        fontSize: 22),
                  )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}