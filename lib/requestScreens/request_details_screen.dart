import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:userapp/models/address.dart';
import 'package:userapp/requestScreens/address_design_widget.dart';
import 'package:userapp/requestScreens/status_banner_widget.dart';

import '../global/global.dart';


class OrderDetailsScreen extends StatefulWidget
{
  String? orderID;

  OrderDetailsScreen({this.orderID,});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}



class _OrderDetailsScreenState extends State<OrderDetailsScreen>
{
  String orderStatus = "";

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("users")
              .doc(sharedPreferences!.getString("uid"))
              .collection("orders")
              .doc(widget.orderID)
              .get(),
          builder: (c, AsyncSnapshot dataSnapshot)
          {
            Map? orderDataMap;
            if(dataSnapshot.hasData)
            {
              orderDataMap = dataSnapshot.data.data() as Map<String, dynamic>;
              orderStatus = orderDataMap["status"].toString();

              return Column(
                children: [

                  StatusBanner(
                    status: orderDataMap["isSuccess"],
                    orderStatus: orderStatus,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "₹" + orderDataMap["totalAmount"].toString(),
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Request ID = " + orderDataMap["orderId"].toString(),
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Request at = " + DateFormat("dd MMMM, yyyy - hh:mm aa")
                            .format(DateTime.fromMillisecondsSinceEpoch(int.parse(orderDataMap["orderTime"]))),
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const Divider(
                    thickness: 1,
                    color: Colors.green,
                  ),

                  orderStatus == "ended"
                      ? Image.asset("images/delivered.jpg")
                      : Image.asset("images/state.png"),

                  const Divider(
                    thickness: 1,
                    color: Colors.green,
                  ),

                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("users")
                        .doc(sharedPreferences!.getString("uid"))
                        .collection("userAddress")
                        .doc(orderDataMap["addressID"])
                        .get(),
                    builder: (c, AsyncSnapshot snapshot)
                    {
                      if(snapshot.hasData)
                      {
                        return AddressDesign(
                          model: Address.fromJson(
                              snapshot.data.data() as Map<String, dynamic>
                          ),
                          orderStatus: orderStatus,
                          orderId: widget.orderID,
                          employeeId: orderDataMap!["employeeUID"],
                          orderByUser: orderDataMap["orderBy"],
                        );
                      }
                      else
                      {
                        return const Center(
                          child: Text(
                            "No data exists.",
                          ),
                        );
                      }
                    },
                  ),

                ],
              );
            }
            else
            {
              return const Center(
                child: Text(
                  "No data exists.",
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
