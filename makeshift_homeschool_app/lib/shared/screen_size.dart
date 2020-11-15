import 'package:flutter/material.dart';

/**
 * Gets the screen size of the 
 */
double screenHeight(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  if (size.height > 500) {
    return size.height * 0.30;
  }
  return size.height * 0.7;
}
