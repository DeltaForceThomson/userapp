import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:userapp/NotyetReceivedItems/not_yet_received.dart';
import 'package:userapp/Services/home_page.dart';
import 'package:userapp/history/history.dart';

import '../assistantMethods/cart_item_counter.dart';
import '../cartScreens/cart_screen.dart';
import '../global/global.dart';
import '../mainScreens/home_screen.dart';
import '../requestScreens/requests_screen.dart';
import '../searchScreen/search_screen.dart';
import '../splashScreen/my_splash_screen.dart';


class MyDrawer extends StatefulWidget
{
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}



class _MyDrawerState extends State<MyDrawer>
{
  @override
  Widget build(BuildContext context)
  {
    return Drawer(
      backgroundColor: Colors.teal,
      child: ListView(
        children: [

          //header
          Container(
            padding: const EdgeInsets.only(top: 26, bottom: 12),
            child: Column(
              children: [
                //user profile image
                SizedBox(
                  height: 130,
                  width: 130,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      sharedPreferences!.getString("photoUrl")!,
                    ),
                  ),
                ),

                const SizedBox(height: 12,),

                //user name
                Text(
                  sharedPreferences!.getString("name")!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12,),

              ],
            ),
          ),

          //body
          Container(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              children: [

                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),

                //home
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.white,),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> HomeScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),





                ListTile(
                  leading: const Icon(Icons.search, color: Colors.white,),
                  title: const Text(
                    "Search",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context,MaterialPageRoute(builder: (c)=> SearchScreen()));

                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),






                //my orders
                ListTile(
                  leading: const Icon(Icons.reorder, color: Colors.white,),
                  title: const Text(
                    "My Requests",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> OrdersScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),

                //not yet received orders
                ListTile(
                  leading: const Icon(Icons.picture_in_picture_alt_rounded, color: Colors.white,),
                  title: const Text(
                    "Not Yet Received Requests",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context,MaterialPageRoute(builder: (c)=> NotYetReceivedScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),

                //history
                ListTile(
                  leading: const Icon(Icons.access_time, color: Colors.white,),
                  title: const Text(
                    "History",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context,MaterialPageRoute(builder: (c)=>  HistoryScreen()));
                  },
                ),


                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),

                //my orders
                ListTile(
                  leading: const Icon(Icons.alarm_add_rounded, color: Colors.white,),
                  title: const Text(
                    "My Remainders",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: ()
                  {
                    int itemsInCart = Provider.of<CartItemCounter>(context, listen: false).count;
                    if(itemsInCart == 0)
                    {

                      Fluttertoast.showToast(msg: "Remainders is empty. \nPlease first add some items to Remainders.");
                    }
                    else
                    {
                      Navigator.push(context,MaterialPageRoute(builder: (c)=> CartScreen()));
                    }
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.access_time, color: Colors.white,),
                  title: const Text(
                    "Scehdule Remainders",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: ()
                   {
                    Navigator.push(context,MaterialPageRoute(builder: (c)=>  const MyHomePage(title: 'Notifications',)));
                  },
                ),




                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),










                //search








                //logout
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.white,),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: ()
                  {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
