import 'package:flutter/material.dart';

Container videoThumbnail(String title, String thumbnailImage) {
  return Container(
    child: Stack(  
      children: [
        Image.asset(thumbnailImage, height: 100,),
        Text(title)
      ],
    ),
  );
}
