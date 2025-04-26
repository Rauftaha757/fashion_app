import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:exp/app_screens/cart.dart';
import 'package:exp/model_classes/items_list.dart';
import 'package:exp/provider/cart_provider.dart';
import 'package:exp/provider/counter%20provider.dart';

class details extends StatefulWidget {
  final item_model_class index;
  const details({Key? key, required this.index}) : super(key: key);

  @override
  State<details> createState() => _DetailsState();
}

class _DetailsState extends State<details> {
  @override
  Widget build(BuildContext context) {
    final item = widget.index;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back arrow
                  InkWell(
                    onTap: () => Navigator.pop(context),
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
                          child: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.black, size: 24),
                        ),
                      ),
                    ),
                  ),

                  // Title
                  Column(
                    children: const [
                      Text("T A Y L O R", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins", fontSize: 26)),
                      Text("S H A W N", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins", fontSize: 22)),
                    ],
                  ),

                  // Shopping bag with counter badge
                  Stack(
                    children: [
                      Material(
                        elevation: 2,
                        shape: const CircleBorder(),
                        color: Colors.white,
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            border: Border.all(color: const Color(0xFFF8F8F8)),
                          ),
                          child: const Center(
                            child: FaIcon(FontAwesomeIcons.bagShopping, color: Colors.black, size: 24),
                          ),
                        ),
                      ),
                      // Counter badge
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Consumer<cart_provider>(
                          builder: (context, cart, _) {
                            return cart.getallitems().isNotEmpty
                                ? Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                "${cart.getallitems().length}",
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            )
                                : const SizedBox();
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            // Animated image with Hero
            Hero(
              tag: item.image,
              child: Container(
                width: 380,
                height: 400,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.grey.shade300,
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 15, offset: Offset(0, 10))],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(item.image, fit: BoxFit.cover),
                ),
              ),
            ),

            // Item name
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins", fontSize: 22),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // Item price
            Padding(
              padding: const EdgeInsets.only(left: 23, bottom: 20),
              child: Row(
                children: [
                  Text(
                    "\$${item.price}",
                    style: const TextStyle(fontWeight: FontWeight.w600, fontFamily: "Poppins", fontSize: 35),
                  ),
                ],
              ),
            ),
SizedBox(
  height: 25,
),
            // Quantity selector
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(21),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0x55D1D1D1),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Provider.of<counter_provider>(context, listen: false).decrement(item.name);
                          },
                          child: const Icon(Icons.remove, color: Colors.black),
                        ),
                        Text(
                          "${Provider.of<counter_provider>(context).getItemCount(item.name)}",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        InkWell(
                          onTap: () {
                            Provider.of<counter_provider>(context, listen: false).increment(item.name);
                          },
                          child: const Icon(Icons.add, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Add to Cart button with snackbar
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  // Set the item price in counter_provider
                  Provider.of<counter_provider>(context, listen: false)
                      .setItemPrice(item.name, item.price);

                  // Add item to cart
                  Provider.of<cart_provider>(context, listen: false)
                      .addtocart(item, context);

                  // Navigate to cart
                  Navigator.push(context, MaterialPageRoute(builder: (_) => cart()));
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6E8C6D),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                ),
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins", fontSize: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
