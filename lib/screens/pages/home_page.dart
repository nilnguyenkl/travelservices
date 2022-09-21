import 'package:flutter/material.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String,String>> listCategory = [
    {
      "url" : "assets/images/categories/ticket.png",
      "name" : "Vé vui chơi, tham quan"
    },
    {
      "url" : "assets/images/categories/mountain.png",
      "name" : "Vé vui chơi, tham quan"
    },
    {
      "url" : "assets/images/categories/spa.png",
      "name" : "Vé vui chơi, tham quan"
    },
    {
      "url" : "assets/images/categories/event.png",
      "name" : "Vé vui chơi, tham quan"
    },
    {
      "url" : "assets/images/categories/balloon.png",
      "name" : "Vé vui chơi, tham quan"
    },
    {
      "url" : "assets/images/categories/ticket.png",
      "name" : "Tham quan"
    },
    {
      "url" : "assets/images/categories/mountain.png",
      "name" : "Vé vui chơi, tham quan"
    },
    {
      "url" : "assets/images/categories/spa.png",
      "name" :"Tham quan"
    },
    {
      "url" : "assets/images/categories/event.png",
      "name" : "Vé vui chơi, tham quan"
    },
    {
      "url" : "assets/images/categories/balloon.png",
      "name" : "Tham quan"
    },
    {
      "url" : "assets/images/categories/ticket.png",
      "name" : "Vé vui chơi, tham quan"
    },
    {
      "url" : "assets/images/categories/mountain.png",
      "name" : "Vé vui chơi, tham quan"
    },
    {
      "url" : "assets/images/categories/mountain.png",
      "name" : "Vé vui chơi, tham quan"
    }
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            snap: true,
            floating: true,
            pinned: true,
            bottom: AppBar(
              toolbarHeight: 90,
              backgroundColor: Colors.white,
              elevation: 0,
              title: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.symmetric(horizontal: paddingWidth/2),
                height: 50,
                child: TextField(
                  style: const TextStyle(
                    fontSize: 14
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.all(4),
                    filled: true,
                    fillColor: searchbar,
                    prefixIcon: const Icon(
                      Icons.search_outlined,
                      color: Colors.black,
                    ),
                    suffixIcon: null,
                    hintText: "Tìm kiếm",
                    hintStyle: const TextStyle(
                      color: hintText,
                      fontSize: 14
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none
                    )
                  ),
                ),
              ),
            ),  
            title: Text(
              "FVTravel",
              style: TextStyle(
                color: Colors.blue.shade600
              ),
            ),
            actions: [
              IconButton(
                onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/pageOne', (Route<dynamic> route) => false
                  );
                }, 
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.blue.shade600,
                )
              ),
              IconButton(
                onPressed: (){}, 
                icon: Icon(
                  Icons.notifications_outlined,
                  color: Colors.blue.shade600,
                )
              )
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: paddingWidth, vertical: 20),
              child: Column(
                children: [
                  categoriesOption(),
                  title("Các thành được yêu thích"),
                  areaFavorite(context),
                  title("Top 10 trải nghiệm hot nhất"),
                  serviceTravelHot(context)
                ],
              ),
            ),
          ), 
        ],
      ),
    );
  }

  Widget categoriesOption() {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    children: List.generate(8, (index) {
                      return InkWell(    
                        onTap: (){
                          print(index);
                        },
                        child: SizedBox(
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.asset(
                                  listCategory[index]["url"].toString(), 
                                  color: Colors.blue.shade600,
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  listCategory[index]["name"].toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                      );
                    })
                  ),
                ),
                SizedBox(
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4, 
                    children: List.generate(listCategory.length-8, (index) {
                      return InkWell(
                        onTap: (){
                          print(index);
                        },
                        child: SizedBox(
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.asset(
                                  listCategory[index+8]["url"].toString(), 
                                  color: Colors.blue.shade600,
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  listCategory[index+8]["name"].toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    })
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              width: 30,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.grey,
              ),
              child: AnimatedAlign(
                alignment: currentIndex == 0 ? Alignment.centerLeft : Alignment.centerRight, 
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 400),
                child: Container(
                  width: 15,
                  height: 4,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.blue.shade600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget areaFavorite(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(10, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Card(
              color: Colors.black,
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: MediaQuery.of(context).size.width*0.4,
                width: MediaQuery.of(context).size.width/3.2,
                alignment: Alignment.bottomLeft,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/ct.jpg"),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Can Tho",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ),
                  ),
                )
              )
            ),
          );
        })
      ),
    );
  }

  Widget title(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      child: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: titleTextSize,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }

  Widget serviceTravelHot(BuildContext context){
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(10, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Card(
              elevation: 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.width*0.6,
                width: MediaQuery.of(context).size.width/2.3,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: const DecorationImage(
                              image: AssetImage("assets/images/test.jpg")
                            )
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 3,
                          child: IconButton(
                            onPressed: (){},
                            icon: Icon(
                              Icons.favorite_outline,
                              color: Colors.blue.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 65),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(top: 7, bottom: 7),
                            child: const Text(
                              "Vé ăn tối thuyền Nữ Hoàng Đông Dương | Hồ Chí Minh | Quận Gò Vấp",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: nameTextDescriptSize),
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
                                  "4.5 (512)",
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
    );
  }
}