import 'package:flutter/material.dart';

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  bool saveCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "My Card",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: 370,
                  height: 220,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [Colors.black87, Colors.black],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "UBL",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                          Text(
                            "Signature Priority Banking",
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.credit_card, color: Colors.grey[300], size: 30),
                          Row(
                            children: [
                              Text("debit", style: TextStyle(color: Colors.white70, fontSize: 11)),
                              SizedBox(width: 5),
                              Icon(Icons.wifi, color: Colors.white70, size: 16),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        cardNumberController.text.isEmpty
                            ? "4084  1380  9012  3456"
                            : cardNumberController.text,
                        style: TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 2),
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("VALID\nFROM", style: TextStyle(color: Colors.white60, fontSize: 8, height: 1.2)),
                              SizedBox(height: 1),
                              Text("04/23", style: TextStyle(color: Colors.white, fontSize: 11)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("VALID\nTHRU", style: TextStyle(color: Colors.white60, fontSize: 8, height: 1.2)),
                              SizedBox(height: 1),
                              Text(
                                expiryController.text.isEmpty ? "04/28" : expiryController.text,
                                style: TextStyle(color: Colors.white, fontSize: 11),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            nameController.text.isEmpty
                                ? "Chris Evans"
                                : nameController.text.toUpperCase(),
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("VISA", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                              Text("Infinite", style: TextStyle(color: Colors.white70, fontSize: 9)),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Input Fields
              Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: _buildInputDecoration("Cardholder Name"),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: cardNumberController,
                    keyboardType: TextInputType.number,
                    decoration: _buildInputDecoration("Card Number"),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: expiryController,
                          keyboardType: TextInputType.datetime,
                          decoration: _buildInputDecoration("Expiry Date (MM/YY)"),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: cvvController,
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          decoration: _buildInputDecoration("CVV"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Save card switch
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Save your card information",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Switch(
                      value: saveCard,
                      onChanged: (value) {
                        setState(() {
                          saveCard = value;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40),

              Center(
                child: SizedBox(
                  height: 60,
                  width: 220,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6E8C6D),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8,
                      shadowColor: Colors.green.withOpacity(0.4),
                    ),
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade100,
      labelText: label,
      labelStyle: TextStyle(
        fontFamily: "Poppins",
        fontSize: 16,
        color: Colors.grey.shade700,
      ),
      floatingLabelStyle: TextStyle(
        fontFamily: "Poppins",
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.black12, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.black, width: 2.5),
      ),
    );
  }
}
