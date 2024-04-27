import 'package:flutter/material.dart';

class StoreImage{
 late int id;
 late  String storeName="";
 late  Image storeImage=Image.asset("images/stores.png");

  StoreImage(this.storeName, this.storeImage,this.id);
 StoreImage.name(this.storeName, this.id);
 StoreImage.empty();
}