import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userapp/placeCredential/place_request_screen.dart';

import '../assistantMethods/address_changer.dart';
import '../models/address.dart';


class AddressDesignWidget extends StatefulWidget
{
  Address? addressModel;
  int? index;
  int? value;
  String? addressID;
  double? totalAmount;
  String? employeeUID;

  AddressDesignWidget({
    this.addressModel,
    this.index,
    this.value,
    this.addressID,
    this.totalAmount,
    this.employeeUID,
  });

  @override
  State<AddressDesignWidget> createState() => _AddressDesignWidgetState();
}

class _AddressDesignWidgetState extends State<AddressDesignWidget>
{
  @override
  Widget build(BuildContext context)
  {
    return Card(
      color: Colors.white24,
      child: Column(
        children: [

          //address info
          Row(
            children: [

              Radio(
                groupValue: widget.index,
                value: widget.value!,
                activeColor: Colors.green,
                onChanged: (val)
                {
                  //provider
                  Provider.of<AddressChanger>(context, listen: false).showSelectedAddress(val);
                },
              ),

              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Table(
                      children: [

                        TableRow(
                          children:
                          [
                            const Text(
                              "Name: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.addressModel!.name.toString(),
                            ),
                          ],
                        ),

                        const TableRow(
                          children:
                          [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),

                        TableRow(
                          children:
                          [
                            const Text(
                              "Phone Number: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.addressModel!.phoneNumber.toString(),
                            ),
                          ],
                        ),

                        const TableRow(
                          children:
                          [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),

                        TableRow(
                          children:
                          [
                            const Text(
                              "Full Credential: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.addressModel!.completeAddress.toString(),
                            ),
                          ],
                        ),

                        const TableRow(
                          children:
                          [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),

          //button
          widget.value == Provider.of<AddressChanger>(context).count
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: const Text("Proceed"),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              onPressed: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (c)=> PlaceOrderScreen(
                  addressID: widget.addressID,
                  totalAmount: widget.totalAmount,
                  employeeUID: widget.employeeUID,
                )));
                //send user to Place Order Screen finally
              },
            ),
          )
              : Container(),

        ],
      ),
    );
  }
}
