import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:the_cats_app/infraestructure/apis/apis.dart';
import 'package:the_cats_app/presentation/description/view/description_cat.dart';
import 'package:the_cats_app/presentation/home/view_model/home_vm.dart';
import 'package:the_cats_app/shared/assets/assets.dart';
import 'package:the_cats_app/shared/theme/themes.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel homeViewModel = Get.isRegistered<HomeViewModel>()
      ? Get.find<HomeViewModel>()
      : Get.put(HomeViewModel());

  final Debouncer debouncer =
      Debouncer(delay: const Duration(milliseconds: 800));

  ScrollController scrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await homeViewModel.getCats();
      homeViewModel.auxCats = RxList.from(homeViewModel.allCatsList);
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('Cat Breeds'),
          centerTitle: true,
          backgroundColor: Colors.brown,
          actions: [
            homeViewModel.typeTheme.value == 1
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          homeViewModel.typeTheme.value = 2;
                          Get.changeTheme(DefaultThemes().darkTheme);
                          setState(() {});
                        },
                        child: const Icon(Icons.dark_mode)),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          homeViewModel.typeTheme.value = 1;
                          Get.changeTheme(DefaultThemes().lightTheme);
                          setState(() {});
                        },
                        child: const Icon(Icons.light_mode)),
                  )
          ],
        ),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    onChanged: (value) {
                      debouncer(() => {
                            homeViewModel.filterSearchResults(),
                            setState(() {})
                          });
                    },
                    controller: homeViewModel.controllerSearch,
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
            Flexible(
              child: RawScrollbar(
                crossAxisMargin: 5,
                mainAxisMargin: 0,
                minThumbLength: Get.height * .2,
                thumbColor: Colors.brown,
                scrollbarOrientation: ScrollbarOrientation.right,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: homeViewModel.auxCats.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 2, color: Colors.brown)),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text(
                                        'Name breed: ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        homeViewModel.auxCats[index].name!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: Get.width,
                                    height: Get.height * .45,
                                    child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            Image.asset(Res.images.catLoading),
                                        errorWidget: (context, url, error) =>
                                            CachedNetworkImage(
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                        Res.images.catLoading),
                                                imageUrl:
                                                    '${Apis.imageCat}${homeViewModel.auxCats[index].referenceImageId}.png',
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset(Res.images
                                                            .catNotFound)),
                                        imageUrl:
                                            '${Apis.imageCat}${homeViewModel.auxCats[index].referenceImageId}.jpg'),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                                              .auxCats[index].origin!)
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
                                              .auxCats[index].intelligence
                                              .toString())
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  GestureDetector(
                                    onTap: () => Get.to(() =>
                                        DescriptionCatPage(
                                            cat: homeViewModel.auxCats[index])),
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
            ),
          ],
        ),
      ),
    );
  }
}
