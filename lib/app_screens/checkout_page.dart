import 'package:exp/app_screens/card.dart';
import 'package:exp/database/local/db_helper.dart';
import 'package:exp/model_classes/oder_model_class.dart';
import 'package:exp/model_classes/user_modelclass.dart';
import 'package:exp/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exp/model_classes/items_list.dart';
import 'package:exp/provider/cart_provider.dart';
import 'package:exp/provider/counter%20provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

class Checkout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Checkout();
  }
}

class _Checkout extends State<Checkout> {
  TextEditingController giveaddress = TextEditingController();
  var selectedPayment;
  final loc.Location location = loc.Location();

  @override
  void initState() {
    super.initState();
    fetchlocation();
  }

  @override
  Widget build(BuildContext context) {
    final list= Provider.of<cart_provider>(context,listen: false).getallitems();
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back Arrow
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
                    // Name in Middle
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
                    // Trash Icon
                    InkWell(
                      onTap: () {
                        Provider.of<cart_provider>(context, listen: false).clear();
                        Provider.of<counter_provider>(context, listen: false).clearcounter();
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
                            border: Border.all(color: Color(0xFFF8F8F8)),
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

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Check Out",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    fontSize: 26,
                  ),
                ),
              ),

              Container(
                width: 350,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(21),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.local_shipping),
                        Text(
                          "Shipping",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Container(width: 30, height: 2, color: Colors.black),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.payment),
                        Text(
                          "Payment",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Container(width: 30, height: 2, color: Colors.black),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.reviews),
                        Text(
                          "Review",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(width: 80, height: 2, color: Colors.grey),
                  const Text(
                    "Confirm Address",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                      fontSize: 20,
                    ),
                  ),
                  Container(width: 100, height: 2, color: Colors.grey),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    controller: giveaddress,
                    maxLines: 2,
                    decoration: InputDecoration(
                      // labelText: "Address",
                      labelStyle: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      hintText: "Loading...",
                      hintStyle: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 18,
                        color: Colors.grey.shade400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 1.5,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(width: 80, height: 2, color: Colors.grey),
                        const Text(
                          "Payment Method",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                            fontSize: 20,
                          ),
                        ),
                        Container(width: 100, height: 2, color: Colors.grey),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Cash Option
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPayment = "Cash";
                            });
                          },
                          child: Container(
                            width: 140,
                            height: 60,
                            decoration: BoxDecoration(
                              color: selectedPayment == "Cash" ? Color(0xFF6E8C6D) : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: selectedPayment == "Cash" ? Color(0xFF6E8C6D): Colors.grey,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Cash",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 18,
                                  color: selectedPayment == "Cash" ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Card Option
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPayment = "Card";
                            });
                          },
                          onDoubleTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> CardPage()));
                          },
                          child: Container(
                            width: 140,
                            height: 60,
                            decoration: BoxDecoration(
                              color: selectedPayment == "Card" ? Color(0xFF6E8C6D) : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: selectedPayment == "Card" ? Colors.green : Colors.grey,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Card",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 18,
                                  color: selectedPayment == "Card" ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 350,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Summary",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Subtotal Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subtotal",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${Provider.of<counter_provider>(context).getTotalPrice()}",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),

                      // Shipping Fee Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Shipping Fee",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Free",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      Divider(height: 30, thickness: 1),

                      // Total Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "${Provider.of<counter_provider>(context).getTotalPrice()}",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      // Confirm Order Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              final cartList = Provider.of<cart_provider>(context, listen: false).getallitems();
                              final user = Provider.of<UserProvider>(context, listen: false).getUserId();

                              if (user == null) {
                                print("No logged-in user. Cannot place order.");
                                return;
                              }

                              List<OderModel> cartItems = cartList.map((items) {
                                final count = Provider.of<counter_provider>(context, listen: false).getItemCount(items.name);

                                return OderModel(
                                  name: items.name,
                                  price: items.price,
                                  count: count,
                                  userId: user, // ✅ Direct userId
                                );
                              }).toList();

                              for (var order in cartItems) {
                                await DbHelper.getinstance().insertoder(order);
                              }

                              print("All cart items placed as orders successfully!");
                            }


                            ,style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF6E8C6D),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Confirm Order",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void fetchlocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    loc.PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    loc.LocationData locationData = await location.getLocation();

    List<Placemark> placemarks = await placemarkFromCoordinates(
      locationData.latitude!,
      locationData.longitude!,
    );

    Placemark place = placemarks[0];

    setState(() {
      giveaddress.text = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    });
  }
}
