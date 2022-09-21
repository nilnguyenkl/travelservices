import 'package:flutter/material.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Mục yêu thích",
              style: TextStyle(
                color: Colors.black
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1), 
            child: Container(
              color: searchbar, 
              width: double.infinity, 
              height: 1
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingWidth, vertical: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                                    fit: BoxFit.fitWidth
                                  )
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: IconButton(
                                  onPressed: (){},
                                  icon: Icon(
                                    Icons.favorite_outline,
                                    color: Colors.blue.shade600,
                                    size: 30,
                                  ),
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
        ),
      )
    );  
  }
}