import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_cats_app/domain/home/model/the_cat.dart';
import 'package:the_cats_app/infraestructure/apis/apis.dart';
import 'package:the_cats_app/presentation/description/view_model/description_vm.dart';
import 'package:the_cats_app/shared/assets/assets.dart';

class DescriptionCatPage extends StatefulWidget {
  DescriptionCatPage({super.key, required this.cat});

  final TheCat cat;

  @override
  State<DescriptionCatPage> createState() => _DescriptionCatPageState();
}

class _DescriptionCatPageState extends State<DescriptionCatPage> {
  final DescriptionViewModel descriptionViewModel =
      Get.isRegistered<DescriptionViewModel>()
          ? Get.find<DescriptionViewModel>()
          : Get.put(DescriptionViewModel());

  final CarouselController _controller = CarouselController();
  int _current = 0;
  @override
  void initState() {
    descriptionViewModel.getImagesCat(widget.cat.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle =
        const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        centerTitle: true,
        title: Text(widget.cat.name!),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            child: Center(
              child: Obx(
                () =>   descriptionViewModel.imagesCat.isNotEmpty ?  Column(
                  children: [
                    CarouselSlider(
                      carouselController: _controller,
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 1,
                        viewportFraction: 1,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        enlargeCenterPage: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      items: descriptionViewModel.imagesCat
                          .map(
                            (item) => ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: CachedNetworkImage(
                                  imageUrl: '${item.url}',
                                  // 'http://66.33.94.204/SyncEmart/Imgs/7037/banners/${item.link}.png',
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(Res.images.catNotFound),
                                  fit: BoxFit.fill),
                            ),
                          )
                          .toList(),
                    ),
                     Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: descriptionViewModel.imagesCat.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: _current == entry.key ? 20.0 : 9.0,
                      height: 10.0,
                      padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                      margin:
                          const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          shape: BoxShape.rectangle,
                          color: _current == entry.key
                              ? Colors.brown
                              : Colors.grey),
                    ),
                  );
                }).toList(),
              ),
                  ],
                ) : 
                Image.asset(Res.images.catNotFound)
                
              ),
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
                      Text(
                        'Description: ',
                        style: titleStyle,
                      ),
                      const SizedBox(height: 10),
                      Text(widget.cat.description!),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Country of origin: ',
                            style: titleStyle,
                          ),
                          SizedBox(width: Get.width * .1),
                          Text(widget.cat.origin!),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Intelligence: ',
                            style: titleStyle,
                          ),
                          SizedBox(width: Get.width * .1),
                          Text(widget.cat.intelligence.toString()),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Adaptability: ',
                            style: titleStyle,
                          ),
                          SizedBox(width: Get.width * .1),
                          Text(widget.cat.adaptability.toString()),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Life Span: ',
                            style: titleStyle,
                          ),
                          SizedBox(width: Get.width * .1),
                          Text(widget.cat.lifeSpan!),
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
