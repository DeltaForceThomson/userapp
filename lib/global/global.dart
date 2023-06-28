import 'package:shared_preferences/shared_preferences.dart';

import '../assistantMethods/cart_methods.dart';



SharedPreferences? sharedPreferences;
final itemsImagesList =
[
  "slider/1.jpg",
  "slider/2.jpg",
  "slider/3.jpg",
  "slider/4.jpg",
  "slider/5.jpg",

];

CartMethods cartMethods =CartMethods();
String titleStarsRating ="";

double countStarsRating = 0.0;