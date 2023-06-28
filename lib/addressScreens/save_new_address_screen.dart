import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:userapp/addressScreens/text_field_address_widget.dart';
import 'package:userapp/global/global.dart';


class SaveNewAddressScreen extends StatefulWidget
{
  String? employeeUID;
  double? totalAmount;

  SaveNewAddressScreen({this.employeeUID, this.totalAmount,});

  @override
  State<SaveNewAddressScreen> createState() => _SaveNewAddressScreenState();
}

class _SaveNewAddressScreenState extends State<SaveNewAddressScreen>
{
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController wardNumber = TextEditingController();
  TextEditingController HouseNumber = TextEditingController();
  TextEditingController rationcardNumber = TextEditingController();
  String completeAddress = "";
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors:
                [
                  Colors.green,
                  Colors.green,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
          ),
        ),
        title: const Text(
          "Ente Gramam",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()
        {
          if(formKey.currentState!.validate())
          {
            completeAddress = wardNumber.text.trim() + ", " + HouseNumber.text.trim()+rationcardNumber.text.trim()+".";

            FirebaseFirestore.instance
                .collection("users")
                .doc(sharedPreferences!.getString("uid"))
                .collection("userAddress")
                .doc(DateTime.now().millisecondsSinceEpoch.toString())
                .set(
                {
                  "name": name.text.trim(),
                  "phoneNumber": phoneNumber.text.trim(),
                  "wardNumber": wardNumber.text.trim(),
                  "HouseNumber": HouseNumber.text.trim(),
                  "rationcardNumber": rationcardNumber.text.trim(),
                  "completeAddress": completeAddress,
                }).then((value)
            {
              Fluttertoast.showToast(msg: "New Credential has been saved.");
              formKey.currentState!.reset();
            });
          }
        },
        label: const Text(
            "Save Now"
        ),
        icon: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                "Save New Credential:",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Form(
              key: formKey,
              child: Column(
                children: [

                  TextFieldAddressWidget(
                    hint: "Name",
                    controller: name,
                  ),

                  TextFieldAddressWidget(
                    hint: "Phone Number",
                    controller: phoneNumber,
                  ),

                  TextFieldAddressWidget(
                    hint: "Ward Number",
                    controller: wardNumber,
                  ),

                  TextFieldAddressWidget(
                    hint: "Flat / House Number",
                    controller: HouseNumber,
                  ),

                  TextFieldAddressWidget(
                    hint: "Ration Card Number",
                    controller: rationcardNumber,
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
