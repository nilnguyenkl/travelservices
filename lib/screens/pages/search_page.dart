import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FocusNode searchClick = FocusNode();
  TextEditingController searchController = TextEditingController();
  bool status = false;

  List<Map<String, String>> listImage = [
    {
      "url" : "assets/images/ct.jpg",
      "name" : " Can Tho"
    },
    {
      "url" : "assets/images/hcm.jpg",
      "name" : " Ho Chi Minh"
    },
    {
      "url" : "assets/images/kg.jpg",
      "name" : " Kien Giang"
    },
    {
      "url" : "assets/images/cm.jpg",
      "name" : " Ca Mau"
    },
    {
      "url" : "assets/images/ct.jpg",
      "name" : " Can Tho"
    },
    {
      "url" : "assets/images/hcm.jpg",
      "name" : " Ho Chi Minh"
    },
    {
      "url" : "assets/images/kg.jpg",
      "name" : " Kien Giang"
    },
    {
      "url" : "assets/images/cm.jpg",
      "name" : " Ca Mau"
    },
    {
      "url" : "assets/images/ct.jpg",
      "name" : " Can Tho"
    },
    {
      "url" : "assets/images/hcm.jpg",
      "name" : " Ho Chi Minh"
    },
    {
      "url" : "assets/images/kg.jpg",
      "name" : " Kien Giang"
    },
    {
      "url" : "assets/images/cm.jpg",
      "name" : " Ca Mau"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
          child: Column(
            children: [
              const SizedBox(height: paddingWidth),
              Focus(
                onFocusChange: (hasFocus) {
                  setState(() {
                    status = hasFocus;
                  });
                },
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: searchbar,
                    prefixIcon: const Icon(
                      Icons.search_outlined,
                      color: Colors.black,
                    ),
                    suffixIcon: null,
                    hintText: "Tìm kiếm",
                    hintStyle: const TextStyle(
                      color: hintText
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none
                    )
                  ),
                ),
              ),
              const SizedBox(height: paddingWidth),
              resultSearch()
            ],
          ),
        )       
    );
  }

  Widget resultSearch() {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: List.generate(8, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Card(
                color: Colors.transparent,
                elevation: 0,
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width*2/2.5,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 230,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image: const DecorationImage(
                                image: AssetImage("assets/images/test2.jpg"),
                                fit: BoxFit.fitWidth,
                                opacity: 0.9
                              )
                            ),
                          ),
                          Positioned(
                            top: 5,
                            left: 5,
                            right: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.blue.shade600,
                                      size: 30,
                                    ),
                                    Container(
                                      width: 290,
                                      padding: const EdgeInsets.only(left: 10),
                                      child: const Text(
                                        "xa Khanh Lam, huyen U Minh, tinh Ca Mauuuuuuu",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                IconButton(
                                  onPressed: (){},
                                  icon: Icon(
                                    Icons.favorite_outline,
                                    color: Colors.blue.shade600,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 60),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: const Text(
                                "Vé ăn tối thuyền Nữ Hoàng Đông Dương | Hồ Chí Minh | Quận Gò Vấp",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: titleTextSize),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.blue.shade600,
                                  size: 18,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: const Text(
                                    "4.5 (512) | 230000 đã đặt",
                                    style: TextStyle(
                                      fontSize: 14
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "1.420.000 VND",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: titleTextSize
                              ),
                            ),
                          )           
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          })
        ),
      ),
    );
  }

  Widget searchArea() {
    return Expanded(
      child: StaggeredGridView.countBuilder(
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2,
        itemCount: listImage.length,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemBuilder: (context, index) => Card(
          color: Colors.black,
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(listImage[index]['url'].toString()),
                fit: BoxFit.fitHeight,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                listImage[index]['name'].toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),
              ),
            )
          )
        ), 
        staggeredTileBuilder: (index) => StaggeredTile.count(1, index == 0 ? 1.2 : 1)
      ),
    );
  }
}
