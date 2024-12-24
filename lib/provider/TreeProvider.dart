import 'package:flutter/material.dart';
import 'package:green_public_mobile/apis/TreeApis.dart';
import 'package:green_public_mobile/dto/Tree.dart';
import 'package:green_public_mobile/dto/TreeImage.dart';
import 'package:green_public_mobile/dto/TreeVideo.dart';

class TreeProvider extends ChangeNotifier {
  Future<List<Tree>> treeFutureList = Future<List<Tree>>.value([]);
  Future<List<TreeImage>> treeImageFutureList = Future<List<TreeImage>>.value([]);
  Future<List<TreeImage>> treeImageFutureListBottom = Future<List<TreeImage>>.value([]);
  Future<List<TreeVideo>> treeVideoFutureList = Future<List<TreeVideo>>.value([]);

  bool isSearch = false;
  Tree currentTree = Tree.empty();
  int index=-1;
  String? selectedCategory;
  String searchTerm = '';
  Future<List<TreeImage>> filteredTreeImageListBottom = Future.value([]);
  TreeProvider() {
    getFromApiTrees();
  }

  void selectCategory(String category) {
    selectedCategory = category;
    getFromApiTrees();
    notifyListeners();
  }

  void getSearch(bool value) {
    isSearch = value;
    notifyListeners();
  }

  Future<void> getFromApiTrees() async {
    try {
      List<Tree> trees = await TreeApis.getTrees();

      treeFutureList = Future.value(trees);
      await convertImageApis();
      // await convertVideoApis();
      await convertImageApisBottom();
      notifyListeners();
    } catch (e) {
      print("Error fetching trees: $e");
    }
  }

  Future<void> convertImageApis() async {
    try {
      List<Tree> trees = await treeFutureList;
      List<TreeImage> treeImages = trees.map((tree) {
        return TreeImage(
          tree.id,
          tree.name,
          getCloudImage(tree.picture.url),
          tree.description,
          // tree.video.url,
          // getCloudImage(tree.video.previewUrl!),
          tree.price,
        );
      }).toList();
      treeImageFutureList = Future.value(treeImages);
      notifyListeners();
    } catch (e) {
      print("Error processing tree images: $e");
    }
  }

  Future<void> convertImageApisBottom() async {
    try {
      List<Tree> trees = await treeFutureList;
      List<TreeImage> treeImages = trees.map((tree) {
        return TreeImage(
          tree.id,
          tree.name,
          getCloudImage(tree.picture.url),
          tree.description,
          tree.price,
        );
      }).toList();
      treeImageFutureListBottom = Future.value(treeImages);
      notifyListeners();
    } catch (e) {
      print("Error processing tree images: $e");
    }
  }
  // Future<void> convertVideoApis() async {
  //   try {
  //     List<Tree> trees = await treeFutureList;
  //     List<TreeVideo> treeVideoList = trees
  //         .where((tree) => tree.video.previewUrl!.isNotEmpty)
  //         .map((tree) {
  //       return TreeVideo(tree.video.url, tree.video.previewUrl!);
  //     }).toList();
  //     treeVideoFutureList = Future.value(treeVideoList);
  //     notifyListeners();
  //   } catch (e) {
  //     print("Error processing tree videos: $e");
  //   }
  // }

  Future<Tree> findTreeById(int id) async {
    try {
      List<Tree> trees = await treeFutureList;
      int index = trees.indexWhere((element) => element.id == id);
      if (index != -1) {
        currentTree = trees[index];
      }
      return currentTree;
    } catch (e) {
      print("Error finding tree by ID: $e");
      return Tree.empty();
    }
  }

  Image getCloudImage(String url) {
    try {
      return Image.network(url);
    } catch (e) {
      print("Image error: $e");
      return Image.asset("images/tree not found.png");
    }
  }

  void getIndex(int i) {
    index=i;
    notifyListeners();
  }

  void searchTreesInImages(String query) {
    searchTerm = query;
    if (query.isEmpty) {
      filteredTreeImageListBottom = treeImageFutureListBottom;
    } else {
      filteredTreeImageListBottom = Future.value(
          treeImageFutureListBottom.then((images) {
            return images.where((treeImage) {
              return treeImage.treeName.toLowerCase().contains(query.toLowerCase());
            }).toList();
          })
      );
    }
    notifyListeners();
  }
  void getSearchStatus(bool searchStatus) {
    isSearch = searchStatus;
    if (!isSearch) {
      filteredTreeImageListBottom = treeImageFutureListBottom;
    }
    notifyListeners();
  }
}
