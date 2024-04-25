import 'package:green_public_mobile/apis/TreeApis.dart';
import 'package:green_public_mobile/dto/Tree.dart';
import 'package:green_public_mobile/dto/TreeImage.dart';
import 'package:flutter/material.dart';
class TreeProvider extends ChangeNotifier{

  Future<List<Tree>> treeFutureList = Future<List<Tree>>.value([]);
  Future<List<TreeImage>> treeImageFutureList = Future<List<TreeImage>>.value([]);


  TreeProvider(){
    getFromApiTrees();
  }

  Future<List<Tree>> getFromApiTrees() async {
    notifyListeners();
   List<Tree> trees = await TreeApis.getTrees();
    treeFutureList.then((value) => value.clear());
    treeFutureList.then((value) => value.addAll(trees));
    treeImageFutureList.then((value) => value.clear());
    convertImageApis();
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
      return Image.network(url);
    } catch (e) {
      print("Image error: $e");
      return Image.asset("images/tree not found.png",);
    }
  }

}