import 'package:flutter/material.dart';

import '../apis/StoreApis.dart';
import '../dto/Store.dart';
import '../dto/StoreImage.dart';

class StoreProvider extends ChangeNotifier{
  Future<List<Store>> storeFutureList = Future<List<Store>>.value([]);
  Future<List<StoreImage>> storeImageFutureList = Future<List<StoreImage>>.value([]);


  StoreProvider(){
    getFromApiStores();
  }

  Future<List<Store>> getFromApiStores() async {
    notifyListeners();
    List<Store> trees = await StoreApis.getStores();
    storeFutureList.then((value) => value.clear());
    storeFutureList.then((value) => value.addAll(trees));
    storeImageFutureList.then((value) => value.clear());
    convertImageApis();
    return storeFutureList;
  }
  Future<List<StoreImage>> convertImageApis() async {
    notifyListeners();
    List<Store> stores=await storeFutureList;
    for (var element in stores) {
      storeImageFutureList.then((value) => value.add(StoreImage(element.storeName,getCloudImage(element.imageUrl),
          element.id)));
    }
    return storeImageFutureList;
  }

  Image getCloudImage(String url) {
    print("store image url: $url");
    try {
      return Image.network(url);
    } catch (e) {
      print("Image error: $e");
      return Image.asset("images/store.png",);
    }
  }
}