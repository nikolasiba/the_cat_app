

import 'package:the_cats_app/domain/description/interface/i_description.dart';
import 'package:the_cats_app/domain/description/model/images_cat.dart';

class DescriptionService {
  final IDescription iDescription;

  DescriptionService({required this.iDescription});


  Future<List<ImagesCat>> getImagesCats (String id){
    return iDescription.getImagesCats(id);
  }


}