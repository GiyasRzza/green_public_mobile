
import 'package:flutter/widgets.dart';

class TreeImage{
  late int id;
  late String treeName;
  late Image treeImage;
  late String description;
  late String treeVideo;
  late Image treeVideoPreview;


  TreeImage(this.id, this.treeName, this.treeImage, this.description,
      this.treeVideo, this.treeVideoPreview);

  TreeImage.empty();
}