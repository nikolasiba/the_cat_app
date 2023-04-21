

import 'package:get/get.dart';
import 'package:the_cats_app/domain/description/model/images_cat.dart';
import 'package:the_cats_app/domain/description/service/description_servie.dart';
import 'package:the_cats_app/infraestructure/description/description_repository.dart';

class DescriptionViewModel extends GetxController {

  final DescriptionService descriptionService = DescriptionService(iDescription: DescriptionRepository());

  RxList<ImagesCat> imagesCat = <ImagesCat>[].obs;



  Future<void> getImagesCat(String id) async {

    imagesCat.value = await descriptionService.getImagesCats(id);

  }
  
}