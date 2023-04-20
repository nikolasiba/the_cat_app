import 'package:the_cats_app/domain/interface/i_home.dart';
import 'package:the_cats_app/domain/model/the_cat.dart';

class HomeServcice {
  final IHome iHome;

  HomeServcice({required this.iHome});


  Future<List<TheCat>> getCats(){
    return iHome.getCats();
  }
}
