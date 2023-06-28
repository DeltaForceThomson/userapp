import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../global/global.dart';
import '../models/items.dart';
import '../widgets/appbar_cart_badge.dart';




class ItemsDetailsScreen extends StatefulWidget
{
  Items? model;

  ItemsDetailsScreen({this.model,});

  @override
  State<ItemsDetailsScreen> createState() => _ItemsDetailsScreenState();
}



class _ItemsDetailsScreenState extends State<ItemsDetailsScreen>
{
  int counterLimit = 1;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithCartBadge(
        employeeUID: widget.model!.employeeUID.toString(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()
        {
          int itemCounter = counterLimit;

          List<String> itemsIDsList = cartMethods.separateItemIDsFromUserCartList();

          //1. check if item exist already in cart
          if(itemsIDsList.contains(widget.model!.itemID))
          {
            Fluttertoast.showToast(msg: "Item is already in Remainders.");
          }
          else
          {
            //2. add item in cart
            cartMethods.addItemToCart(
              widget.model!.itemID.toString(),
              itemCounter,
              context,
            );
          }
        },
        label: const Text(
            "Add to Remainders"
        ),
        icon: const Icon(
          Icons.alarm_add_rounded,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Image.network(
              widget.model!.thumbnailUrl.toString(),
            ),

            //implement the item counter
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: CartStepperInt(
                  count: counterLimit,
                  size: 0,
                  didChangeCount: (value)
                  {
                    if(value < 1)
                    {
                      Fluttertoast.showToast(msg: "The quantity cannot be less than 1");
                      return;
                    }

                    setState(() {
                      counterLimit = value;
                    });
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(
                widget.model!.itemTitle.toString() + ":",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
              child: Text(
                widget.model!.longDescription.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,

                  fontSize: 15,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.model!.tax.toString() + " ",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.green,
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 320.0),
              child: Divider(
                height: 1,
                thickness: 2,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 30,),

          ],
        ),
      ),
    );
  }
}
