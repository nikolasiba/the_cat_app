import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_cats_app/domain/model/the_cat.dart';
import 'package:the_cats_app/infraestructure/apis/apis.dart';
import 'package:the_cats_app/shared/assets/assets.dart';

class DescriptionCatPage extends StatelessWidget {
  const DescriptionCatPage({super.key, required this.cat});

  final TheCat cat;

  @override
  Widget build(BuildContext context) {

    TextStyle titleStyle =  const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16
    ) ;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        centerTitle: true,
        title: Text(cat.name!),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            child: Center(
              child: CachedNetworkImage(
                  height: Get.height * .46,
                  errorWidget: (context, url, error) =>
                      Image.asset(Res.images.catNotFound),
                  imageUrl: '${Apis.imageCat}${cat.referenceImageId}.jpg'),
            ),
          ),
          SizedBox(
            height: Get.height * .4,
            child: RawScrollbar(
              crossAxisMargin: 8,
              thumbColor: Colors.brown,
              scrollbarOrientation: ScrollbarOrientation.right,
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text('Description: ', style: titleStyle,),
                      const SizedBox(height: 10),
                      Text(cat.description!),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text('Country of origin: ', style: titleStyle,),
                          SizedBox(width: Get.width * .1),
                          Text(cat.origin!),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text('Intelligence: ', style: titleStyle,),
                          SizedBox(width: Get.width * .1),
                          Text(cat.intelligence.toString()),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text('Adaptability: ', style: titleStyle,),
                          SizedBox(width: Get.width * .1),
                          Text(cat.adaptability.toString()),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text('Life Span: ' , style: titleStyle,),
                          SizedBox(width: Get.width * .1),
                          Text(cat.lifeSpan!),
                          const Text(' years'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
