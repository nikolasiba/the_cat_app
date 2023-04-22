import 'package:get/get.dart';
import 'package:the_cats_app/domain/description/interface/i_description.dart';
import 'package:the_cats_app/domain/description/model/images_cat.dart';
import 'package:the_cats_app/infraestructure/apis/apis.dart';
import 'package:the_cats_app/infraestructure/data/remote/network/network_api_service.dart';

class DescriptionRepository extends IDescription {
  @override
  Future<List<ImagesCat>> getImagesCats(String id) async {
    var url = Apis.allImageCat + id;
    List<ImagesCat> allImageCats = [];
    try {
      var apiService = NetworkApiService();

      final response = await apiService
          .getResponse(url, headers: {"x-api-key": Apis.apiKey});
      if (response.isRight) {
        allImageCats = List<ImagesCat>.from(
            response.right.map((x) => ImagesCat.fromJson(x)));
      }
    } catch (e) {
      Get.printError(info: "getAllImagesCats -> $e");
    }

    return allImageCats;
  }
}
