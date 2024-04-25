import 'package:green_public_mobile/apis/settings/ServerSideConnection.dart';
import 'package:green_public_mobile/dto/Tree.dart';
import 'package:green_public_mobile/dto/TreeImage.dart';
import 'package:flutter/material.dart';
class TreeProvider extends ChangeNotifier{

  Future<List<Tree>> treeFutureList = Future<List<Tree>>.value([]);
  Future<List<TreeImage>> treeImageFutureList = Future<List<TreeImage>>.value([]);

  Future<List<Tree>> getFromApiTrees(List<Tree> orderApis){
    notifyListeners();
    treeFutureList.then((value) => value.clear());
    treeFutureList.then((value) => value.addAll(orderApis));
    treeImageFutureList.then((value) => value.clear());
    return treeFutureList;
  }
  Future<List<TreeImage>> convertImageApis() async {
    notifyListeners();
   List<Tree> trees=await treeFutureList;
    for (var element in trees) {
      treeImageFutureList.then((value) => value.add(TreeImage(element.id, element.name,
          getCloudImage(element.pictureUrl), element.description)));
    }
    return treeImageFutureList;
  }

  Image getCloudImage(String url) {
    try {
      return Image.network("${ServerSideConnection.connectionUrl}$url");
    } catch (e) {
      print(e);
      return Image.asset("images/tree not found.png",);
    }
  }

}