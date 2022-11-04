import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/cart_bloc/cart_bloc.dart';
import 'package:travelservices/blocs/cart_bloc/cart_state.dart';
import 'package:travelservices/blocs/category_bloc/category_bloc.dart';
import 'package:travelservices/blocs/category_bloc/category_event.dart';
import 'package:travelservices/blocs/category_bloc/category_state.dart';
import 'package:travelservices/blocs/navbar_bloc/navbar_bloc.dart';
import 'package:travelservices/blocs/navbar_bloc/navbar_event.dart';
import 'package:travelservices/blocs/navbar_bloc/navbar_state.dart';
import 'package:travelservices/blocs/search_bloc/search_bloc.dart';
import 'package:travelservices/blocs/search_bloc/search_event.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/models/category_model.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/arguments/current_user_arguments.dart';
import 'package:travelservices/screens/pages/cart_page.dart';
import 'package:travelservices/utils/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  int currentIndex = 0;

  late int idAuth;
  late String username;
  
  @override
  void initState() {
    getValueShared();  
    super.initState();
  }

  void getValueShared() async {
    idAuth = await SharedPreferencesCustom.getIntCustom('idAuth');
    username = await SharedPreferencesCustom.getStringCustom('username');
  }

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
                child: BlocBuilder<NavbarBloc, NavbarState>(
                  builder:(context, state) {
                    return GestureDetector(
                      onTap: (){
                        context.read<NavbarBloc>().add(NavbarSearchStatusEvent());
                        context.read<NavbarBloc>().add(NavbarSearchPageEvent());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        decoration: BoxDecoration(
                          color: searchbar,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.search_outlined,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Tim kiem",
                              style: TextStyle(
                                color: hintText,
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                              ),
                            )
                          ],
                        ),
                      )
                    );
                  },
                )          
              ),
            ),  
            title: Text(
              "FVTravel",
              style: TextStyle(
                color: Colors.blue.shade600
              ),
            ),
            actions: [
              BlocBuilder<CartBloc, CartState>(
                builder:(context, state) {
                  return Badge(
                    badgeContent: Text(state.items.length.toString()),
                    position: BadgePosition.bottomEnd(bottom: 4, end: 5),
                    child: IconButton(
                      onPressed: (){
                        Navigator.pushNamed(context, Routes.cartPage);
                      }, 
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.blue.shade600,
                      )
                    ),
                  );
                },
              ),
              IconButton(
                onPressed: (){
                  Navigator.pushNamed(context, Routes.chatPage, arguments: CurrentArguments(id: idAuth));
                }, 
                icon: Icon(
                  Icons.sms_outlined,
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
                  // title("Các thành được yêu thích"),
                  // areaFavorite(context),
                  // title("Top 10 trải nghiệm hot nhất"),
                  // serviceTravelHot(context)
                ],
              ),
            ),
          ), 
        ],
      ),
    );
  }

  Widget categoriesOption() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder:(context, state) {
        if (state.getLoading) {
          return const SizedBox.shrink();
        } else {
          List<CategoryData> listItemsCate = state.categories;
          if (listItemsCate.isNotEmpty) {
            for (int i = 0; i < listItemsCate.length; i++) {
              if (listItemsCate[i].name == "All Categories") {
                listItemsCate.removeAt(i);
              } 
            }
          }
          return SizedBox(
            child: Column(
              children: [
                SizedBox(
                  height: listItemsCate.length > 4 ? 200 : 100,
                  child: PageView(
                    onPageChanged: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                    children: List.generate(listItemsCate.length > 8 ? 2 : 1, (index) {
                      return SizedBox(
                        child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 4,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          children: List.generate(listItemsCate.length, (index) {
                            return InkWell(    
                              onTap: (){
                                context.read<NavbarBloc>().add(NavbarSearchPageEvent());
                                context.read<SearchBloc>().add(SearchByClickCategoryIconEvent(listItemsCate[index].id));
                                context.read<CategoryBloc>().add(CategoryClickEvent(category: listItemsCate[index]));
                              },
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Image.network(
                                        listItemsCate[index].icon.toString(), 
                                        color: Colors.blue.shade600,
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        listItemsCate[index].name.toString(),
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
                      );
                    })
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    width: listItemsCate.length > 8 ? 30 : 15,
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
      }
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