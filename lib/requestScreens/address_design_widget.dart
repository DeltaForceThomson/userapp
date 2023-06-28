import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:userapp/models/address.dart';
import 'package:userapp/ratingScreen/rate_employee_screen.dart';

import '../splashScreen/my_splash_screen.dart';


class AddressDesign extends StatelessWidget
{
  Address? model;
  String? orderStatus;
  String? orderId;
  String? employeeId;
  String? orderByUser;

  AddressDesign({
    this.model,
    this.orderStatus,
    this.orderId,
    this.employeeId,
    this.orderByUser,
  });

  @override
  Widget build(BuildContext context)
  {
    return Column(
      children: [

        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Credentials Given:',
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold
            ),
          ),
        ),

        const SizedBox(
          height: 6.0,
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [

              //name
              TableRow(
                children:
                [
                  const Text(
                    "Name",
                    style: TextStyle(color: Colors.black87),
                  ),
                  Text(
                    model!.name.toString(),
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),

              const TableRow(
                children:
                [
                  SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              ),

              //phone
              TableRow(
                children:
                [
                  const Text(
                    "Phone Number",
                    style: TextStyle(color: Colors.black87),
                  ),
                  Text(
                    model!.phoneNumber.toString(),
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            model!.completeAddress.toString(),
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: Colors.black87,
            ),
          ),
        ),

        GestureDetector(
          onTap: ()
          {
            if(orderStatus == "normal")
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MySplashScreen()));
            }
            else if(orderStatus == "shifted")
            {
              //implement Parcel Delivered & Received feature
              FirebaseFirestore.instance
                  .collection("orders")
                  .doc(orderId).update(
                  {
                    "status":"ended",
                  }).whenComplete(() {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(orderByUser)
                        .collection("orders")
                        .doc(orderId).update({
                      "status":"ended",
                    });
                    //send notification
                Fluttertoast.showToast(msg: "Confirmed Sucessfully");
                Navigator.push(context,MaterialPageRoute(builder: (context)=> MySplashScreen()));
              })
              ;
            }
            else if(orderStatus == "ended")
            {
              //implement Rate this Seller feature
              Navigator.push(context,MaterialPageRoute(builder: (context)=> RateEmployeeScreen(
                employeeId: employeeId,
              )));
            }
            else
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MySplashScreen()));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green,
                      Colors.green,
                    ],
                    begin:  FractionalOffset(0.0, 0.0),
                    end:  FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  )
              ),
              width: MediaQuery.of(context).size.width - 70,
              height: orderStatus == "ended" ? 40 : MediaQuery.of(context).size.height * .07,
              child: Center(
                child: Text(
                  orderStatus == "ended"
                      ? "Do you want to Rate this Service?"
                      : orderStatus == "shifted"
                      ? "Item Received, \nClick to Confirm"
                      : orderStatus == "normal"
                      ? "Go Back"
                      : "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
