import 'package:flutter/material.dart';

class StoreImage{
 late int id;
 late  String storeName="";
 late  Image storeImage=Image.asset("images/stores.png");
 late double latitude=0.0;
 late double longitude=0.0;

  StoreImage(this.storeName, this.storeImage,this.id,this.latitude,this.longitude);
 StoreImage.name(this.storeName, this.id);
 StoreImage.empty();
}