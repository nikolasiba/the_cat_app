import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_cats_app/infraestructure/apis/apis.dart';
import 'package:the_cats_app/presentation/description/view/description_cat.dart';
import 'package:the_cats_app/presentation/home/view_model/home_vm.dart';
import 'package:the_cats_app/shared/assets/assets.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel homeViewModel = Get.isRegistered<HomeViewModel>()
      ? Get.find<HomeViewModel>()
      : Get.put(HomeViewModel());
  @override
  void initState() {
    homeViewModel.getCats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cat Breeds'),
          centerTitle: true,
          backgroundColor: Colors.brown,
        ),
        body: Obx(
          () => RawScrollbar(
             crossAxisMargin: 0,
             mainAxisMargin: 10,
             
             
              thumbColor: Colors.brown,
              scrollbarOrientation: ScrollbarOrientation.right,
              thumbVisibility: true,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.search, color: Colors.brown),
                        labelStyle: const TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        labelText: "Search Breed",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                            color: Colors.brown,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                            color: Colors.brown,
                            width: 2.0,
                          ),
                        ),
                      ))),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: homeViewModel.allCatsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 2, color: Colors.brown)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    'Name breed: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    homeViewModel.allCatsList[index].name!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              CachedNetworkImage(
                                  errorWidget: (context, url, error) =>
                                      Image.asset(Res.images.catNotFound),
                                  imageUrl:
                                      '${Apis.imageCat}${homeViewModel.allCatsList[index].referenceImageId}.jpg'),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        'Country of origin: ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(homeViewModel
                                          .allCatsList[index].origin!)
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'Intelligence: ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(homeViewModel
                                          .allCatsList[index].intelligence
                                          .toString())
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 5),
                              GestureDetector(
                                onTap: () => Get.to(DescriptionCatPage(
                                    cat: homeViewModel.allCatsList[index])),
                                child: const Text(
                                  'View more',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
