


import 'package:the_cats_app/domain/description/model/images_cat.dart';

abstract class IDescription {
  Future<List<ImagesCat>> getImagesCats(String id);
}