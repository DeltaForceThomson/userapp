import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final double coverHeight =280;
  final double profileHeight = 144;
  @override
  Widget build(BuildContext context) {
    final top = coverHeight-profileHeight/2;
    return Scaffold(
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
          "About The Developer",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        padding:EdgeInsets.zero,
        children:<Widget>[
          buidTop(),
        buildContent(),
      ],
      ),
    );
  }

  Widget buildCoverImage() => Container(
    color: Colors.grey,
    child: Image.network(
        "https://images.unsplash.com/photo-1542831371-29b0f74f9713?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80",
      width: double.infinity,
      height: coverHeight,
      fit: BoxFit.cover,
    ),
  );

  Widget buildProfileImage()=> CircleAvatar(
    radius: profileHeight/2,
    backgroundColor: Colors.grey.shade800,
    backgroundImage: NetworkImage(
      'https://cdn-icons-png.flaticon.com/512/3445/3445053.png'
    ),
  );

  Widget buidTop() {
    final bottom = profileHeight/2;
    final top = coverHeight-profileHeight/2;
    return
      Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: bottom),
            child: buildCoverImage(),
          ),
          buildCoverImage(),
          Positioned(
            top: top,
            child:buildProfileImage(),
          ),
        ],
      );
  }

  Widget buildContent() =>Column(
    children: [
      const SizedBox(height: 8),
      const Text(
        'Thomson Stanes',
        style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.black87),
      ),
      const SizedBox(height: 8),
      const Text(
        'Flutter Software Engineer',
        style: TextStyle(fontSize: 20,color: Colors.black54),
      ),
      const SizedBox(height: 10),
      const Divider(),
      const SizedBox(height: 10),
      buidAbout(),
      const SizedBox(height: 25),
    ],
  );

  Widget buidAbout() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Flutter Developer with an ongoing project Ente Gramam for Uzhavoor Panchayat',
            style: TextStyle(fontSize: 18,height: 1.4),
          ),
        ],
      ),
    );
  }

  }
  

