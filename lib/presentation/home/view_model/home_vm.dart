

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:the_cats_app/domain/model/the_cat.dart';
import 'package:the_cats_app/domain/service/home_service.dart';
import 'package:the_cats_app/infraestructure/home/home_repository.dart';

class HomeViewModel extends GetxController {

  final HomeServcice homeServcice = HomeServcice(iHome: HomeRepository());

  RxList<TheCat> allCatsList = <TheCat>[].obs;

  TextEditingController controllerSearch = TextEditingController();






  Future<void> getCats()async {
    
    allCatsList.value = await homeServcice.getCats();
  }


  
}