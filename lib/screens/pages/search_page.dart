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
                    hintText: "adasdsadsadsad",
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
              Expanded(
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
              )
            ],
          ),
        )       
    );
  }
}
