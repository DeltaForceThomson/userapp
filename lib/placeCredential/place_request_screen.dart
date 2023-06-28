import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import '../mainScreens/home_screen.dart';



class PlaceOrderScreen extends StatefulWidget
{
  String? addressID;
  double? totalAmount;
  String? employeeUID;

  PlaceOrderScreen({this.addressID, this.totalAmount, this.employeeUID,});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}



class _PlaceOrderScreenState extends State<PlaceOrderScreen>
{
  String orderId = DateTime.now().millisecondsSinceEpoch.toString();

  orderDetails()
  {
    saveOrderDetailsForUser(
        {
          "addressID": widget.addressID,
          "totalAmount": widget.totalAmount,
          "orderBy": sharedPreferences!.getString("uid"),
          "productIDs": sharedPreferences!.getStringList("userCart"),
          "paymentDetails": "Cash On Delivery",
          "orderTime": orderId,
          "orderId": orderId,
          "isSuccess": true,
          "employeeUID": widget.employeeUID,
          "status": "normal",
        }).whenComplete(()
    {
      saveOrderDetailsForSeller(
          {
            "addressID": widget.addressID,
            "totalAmount": widget.totalAmount,
            "orderBy": sharedPreferences!.getString("uid"),
            "productIDs": sharedPreferences!.getStringList("userCart"),
            "paymentDetails": "Cash On Delivery",
            "orderTime": orderId,
            "orderId": orderId,
            "isSuccess": true,
            "employeeUID": widget.employeeUID,
            "status": "normal",
          }).whenComplete(()
      {
        cartMethods.clearCart(context);

        //send push notification

        Fluttertoast.showToast(msg: "Congratulations, Request has been placed successfully.");

        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));

        orderId="";
      });
    });
  }

  saveOrderDetailsForUser(Map<String, dynamic> orderDetailsMap) async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .doc(orderId)
        .set(orderDetailsMap);
  }

  saveOrderDetailsForSeller(Map<String, dynamic> orderDetailsMap) async
  {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .set(orderDetailsMap);
  }





  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset("images/delivery.png"),

          const SizedBox(height: 12,),

          ElevatedButton(
            onPressed: ()
            {
              orderDetails();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
            child: const Text(
                "Place Request  Now"
            ),
          ),

        ],
      ),
    );
  }
}
