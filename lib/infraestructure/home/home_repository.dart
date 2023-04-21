import 'package:get/get.dart';
import 'package:the_cats_app/domain/home/interface/i_home.dart';
import 'package:the_cats_app/domain/home/model/the_cat.dart';
import 'package:the_cats_app/infraestructure/apis/apis.dart';
import 'package:the_cats_app/infraestructure/data/remote/network/network_api_service.dart';

class HomeRepository extends IHome {
  @override
  Future<List<TheCat>> getCats() async {
    var url = Apis.getCats;
    List<TheCat> allCats = [];
    try {
      var apiService = NetworkApiService();

      final response = await apiService
          .getResponse(url, headers: {"x-api-key": Apis.apiKey});
      if (response.isRight) {
        allCats =
            List<TheCat>.from(response.right.map((x) => TheCat.fromJson(x)));
      }
    } catch (e) {
      Get.printError(info: "getAllCats -> $e");
    }

    return allCats;
  }
}
