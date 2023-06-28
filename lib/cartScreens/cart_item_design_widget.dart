import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userapp/models/items.dart';

import '../assistantMethods/address_changer.dart';
import '../assistantMethods/cart_changer.dart';



class CartItemDesignWidget extends StatefulWidget
{
  Items? model;
  int? quantityNumber;



  CartItemDesignWidget({
    this.model,
    this.quantityNumber,

  });

  @override
  State<CartItemDesignWidget> createState() => _CartItemDesignWidgetState();
}



class _CartItemDesignWidgetState extends State<CartItemDesignWidget>
{
  @override
  Widget build(BuildContext context)
  {
    return Card(
      color: Colors.white,
      shadowColor: Colors.green,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [




          //image
              Image.network(
                widget.model!.thumbnailUrl.toString(),
                width: 140,
                height: 120,
              ),

              const SizedBox(width: 6,),

              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    //title
                    Text(
                      widget.model!.itemTitle.toString(),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 2,),

                    //Price: € 12
                    Row(
                      children: [

                        const Text(
                          "Tax: ",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),


                        Text(
                          widget.model!.tax.toString(),
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const Text(
                          "₹",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                          ),
                        ),

                      ],
                    ),

                    const SizedBox(height: 4,),

                    //Quantity: 4
                    Row(
                      children: [

                        const Text(
                          "No of taxes: ",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        Text(
                          widget.quantityNumber.toString(),
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}