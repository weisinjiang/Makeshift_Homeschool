import 'dart:math';
import 'package:flutter/material.dart';

class RandomColorGen {
  Random generator;

  // Random seed of 99 so each time, it generates the same random number
  RandomColorGen() {
    this.generator = new Random(99);
  }


  Color generateRandomColor() {
    return Color.fromARGB(
      255, 
      generator.nextInt(255), 
      generator.nextInt(255), 
      generator.nextInt(255),);
  }
}