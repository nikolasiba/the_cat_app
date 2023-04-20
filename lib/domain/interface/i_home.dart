


import 'package:the_cats_app/domain/model/the_cat.dart';

abstract class IHome {
  

  Future<List<TheCat>> getCats();
}