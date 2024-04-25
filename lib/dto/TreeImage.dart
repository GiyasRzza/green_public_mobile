
import 'package:flutter/widgets.dart';

class TreeImage{
  late int id;
  late String treeName;
  late Image treeImage;
  late String description;

  TreeImage(this.id, this.treeName, this.treeImage, this.description);

  TreeImage.empty();
}