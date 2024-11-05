import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as img;
import '../apis/StoreApis.dart';
import '../dto/ProductImage.dart';
import '../dto/Store.dart';
import '../dto/StoreImage.dart';

class StoreProvider extends ChangeNotifier{
  Future<List<Store>> storeFutureList = Future<List<Store>>.value([]);
  Future<List<StoreImage>> storeImageFutureList = Future<List<StoreImage>>.value([]);
  Future<List<StoreImage>> get getStoreImageListFuture => storeImageFutureList;
  bool isSelected=false;
  int selectedCount=0;
  Future<List<ProductImage>> productFutureList = Future<List<ProductImage>>.value([]);
  Store currentStore=Store.empty();

  StoreProvider(){
    getFromApiStores();
  }

    void select(bool value){
        notifyListeners();
        isSelected=value;
    }
  void changeCount(int value){
    notifyListeners();
    selectedCount=value;
  }
  Future<List<Store>> getFromApiStores() async {
    notifyListeners();
    List<Store> trees = await StoreApis.getStores();
    storeFutureList.then((value) => value.clear());
    storeFutureList.then((value) => value.addAll(trees));
    storeImageFutureList.then((value) => value.clear());
    convertImageApis();
    convertProductApis();
    return storeFutureList;
  }
  Future<List<StoreImage>> convertImageApis() async {
    notifyListeners();
    List<Store> stores=await storeFutureList;
    for (var element in stores) {
      storeImageFutureList.then((value) => value.add(StoreImage(element.storeName,getCloudImage(element.profilePhoto.url),
          element.id)));
    }
    return storeImageFutureList;
  }
  Future<List<ProductImage>> convertProductApis() async {
    notifyListeners();
    List<Store> stores = await storeFutureList;
    for (var store in stores) {
      for (var product in store.products) {
        productFutureList.then((value) => value.add(ProductImage(product.productName, product.price,
            product.description, getCloudImage(product.image.url))));
      }
    }

    return productFutureList;
  }

  Future<Store> findStoreById(int id) async {
    notifyListeners();
    List<Store> stores = await storeFutureList;
    int index = stores.indexWhere((store) => store.id == id);
    currentStore = stores[index];
    return currentStore;
  }

  img.Image getCloudImage(String url) {
    print("store image url: $url");
    try {
      return img.Image.network(url);
    } catch (e) {
      print("Image error: $e");
      return img.Image.asset("images/store.png",);
    }
  }
}