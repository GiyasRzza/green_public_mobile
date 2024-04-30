import 'package:green_public_mobile/apis/TreeApis.dart';
import 'package:green_public_mobile/dto/Tree.dart';
import 'package:green_public_mobile/dto/TreeImage.dart';
import 'package:flutter/material.dart';
import 'package:green_public_mobile/dto/TreeVideo.dart';
class TreeProvider extends ChangeNotifier{

  Future<List<Tree>> treeFutureList = Future<List<Tree>>.value([]);
  Future<List<TreeImage>> treeImageFutureList = Future<List<TreeImage>>.value([]);
  Future<List<TreeVideo>> treeVideoFutureList = Future<List<TreeVideo>>.value([]);
  Tree currentTree=Tree.empty();
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
    convertVideoApis();
    return treeFutureList;
  }
  Future<List<TreeImage>> convertImageApis() async {
    notifyListeners();
   List<Tree> trees=await treeFutureList;
    for (var element in trees) {
      treeImageFutureList.then((value) => value.add(TreeImage(element.id, element.name,
          getCloudImage(element.pictureUrl), element.description,element.videoUrl,getCloudImage(element.videoPreview))));
    }
    return treeImageFutureList;
  }

  Future<List<TreeVideo>> convertVideoApis() async {
    notifyListeners();
    List<Tree> trees = await treeFutureList;
    List<TreeVideo> treeVideoList = [];

    for (var element in trees) {
      if (element.videoUrl.isNotEmpty) {
        TreeVideo treeVideo = TreeVideo(element.videoUrl, element.videoPreview);
        treeVideoList.add(treeVideo);
      }
    }

    treeVideoFutureList.then((value) {
      value.clear();
      value.addAll(treeVideoList);
    });

    return treeVideoFutureList;
  }
  Future<Tree> findTreeByIn(int id) async {
    notifyListeners();
    List<Tree> stores= await treeFutureList;
    int index = stores.indexWhere((element) =>element.id == id);
    currentTree=stores[index];
    return currentTree;

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