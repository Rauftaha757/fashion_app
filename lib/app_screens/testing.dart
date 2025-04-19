import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class container extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body:Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [

         Center(
           child: Container(
             width: 340,
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
                 "assets/images/watch1.png",
                 fit: BoxFit.cover,
               ),
             ),
           ),
         ),
         ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF6E8C6D),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    minimumSize: const Size(200, 70),
    ), child:   Text(
           "Add to Cart",
           style: TextStyle(
               fontWeight: FontWeight.bold,
               fontFamily: "Poppins",
               fontSize: 26),
         ))
       ],
     )
   );
  }

}