
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

class cart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
  return _cart();
  }
}
class _cart extends State{
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back arrow
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                }
                ,
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
// taha is great
              // Name in the middle
              Column(
                children:  [
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "MY CART ",
              style: TextStyle(

                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  fontSize: 26),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            width: 250,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21),
              color: Colors.grey.shade300,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(21)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(21),
                          child: Image.asset("assets/images/watch1.png",fit: BoxFit.fill,)),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 25,bottom: 25),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("SEIKO Black Watch...",  style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                            fontSize: 18),maxLines: 2,
                            overflow: TextOverflow.ellipsis,),
                        Text("1 x 4990.00",  style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                            fontSize: 18),)
                      ],

                    ),
                  ),


          Padding(
              padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(21),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                width: 50,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2), // Optional tint
                  borderRadius: BorderRadius.circular(21),
                  border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.add),
                    Text("1",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                        fontSize: 20
                    ),),
                    Icon(Icons.remove),

                  ],
                ),
              ),
            ),
          ),
        )

      ],
              )
            ),
          ),
        ),
      ],
    ),
  );
  }

}