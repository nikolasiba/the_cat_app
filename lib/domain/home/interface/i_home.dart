




import 'package:the_cats_app/domain/home/model/the_cat.dart';

abstract class IHome {
  

  Future<List<TheCat>> getCats();
}