import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:the_cats_app/domain/home/model/the_cat.dart';
import 'package:the_cats_app/domain/home/service/home_service.dart';
import 'package:the_cats_app/infraestructure/home/home_repository.dart';

class HomeViewModel extends GetxController {
  final HomeServcice homeServcice = HomeServcice(iHome: HomeRepository());

  RxList<TheCat> allCatsList = <TheCat>[].obs;
  RxList<TheCat> auxCats = <TheCat>[].obs;

  TextEditingController controllerSearch = TextEditingController();
  RxInt typeTheme = 1.obs;

  initData() {
    
    auxCats = RxList.from(allCatsList);
  }

  void filterSearchResults() {
    if (controllerSearch.text == '') {
      auxCats = RxList.from(allCatsList);
    } else {
      auxCats.value = allCatsList
          .where((item) => item.name!
              .toLowerCase()
              .contains(controllerSearch.text.toLowerCase()))
          .toList();
    }
  }

  Future<void> getCats() async {
    allCatsList.value = await homeServcice.getCats();
  }
}
