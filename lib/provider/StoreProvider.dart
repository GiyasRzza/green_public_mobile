import 'package:flutter/material.dart';

import '../apis/StoreApis.dart';
import '../dto/Store.dart';
import '../dto/StoreImage.dart';

class StoreProvider extends ChangeNotifier{
  Future<List<Store>> storeFutureList = Future<List<Store>>.value([]);
  Future<List<StoreImage>> storeImageFutureList = Future<List<StoreImage>>.value([]);
  Future<List<StoreImage>> get getStoreImageListFuture => storeImageFutureList;
  Store currentStore=Store.empty();

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
    print(storeFutureList.then((value) => value.forEach((element) {
      element.storeName;
    },),));
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

  Future<Store> findStoreById(int id) async {
    notifyListeners();
    List<Store> stores= await storeFutureList;
    int index = stores.indexWhere((element) =>element.id == id);
    currentStore=stores[index];
   return currentStore;

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