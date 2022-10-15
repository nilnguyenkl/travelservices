import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travelservices/blocs/area_bloc/area_bloc.dart';
import 'package:travelservices/blocs/area_bloc/area_state.dart';
import 'package:travelservices/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:travelservices/blocs/favorite_bloc/favorite_event.dart';
import 'package:travelservices/blocs/favorite_bloc/favorite_state.dart';
import 'package:travelservices/blocs/search_bloc/search_bloc.dart';
import 'package:travelservices/blocs/search_bloc/search_event.dart';
import 'package:travelservices/blocs/search_bloc/search_state.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/models/product_model.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/arguments/idarguments.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  FocusNode searchClick = FocusNode();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
          child: Column(
            children: [
              const SizedBox(height: paddingWidth),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return Focus(
                    autofocus: false,
                    onFocusChange: (hasFocus) {
                      context.read<SearchBloc>().add(SearchFocusEvent(hasFocus));
                    },
                    child: !state.statusBar ? TextField(
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
                    ) : Row(
                      children: [
                        Flexible(
                          child: TextField(
                            autofocus: true,
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
                            onSubmitted: (value) {
                              context.read<SearchBloc>().add(SearchStringEvent(value));
                              context.read<SearchBloc>().add(SearchLoadEvent());
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                            context.read<SearchBloc>().add(SearchFocusEvent(false));
                            searchController.clear();
                          },
                          child: const Text("Cancel")
                        )
                      ],
                    )
                  );
                }
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder:(context, state) {
                  if (state.statusSearch) {
                    return Column(
                      children: [     
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "20 kết quả tìm kiếm",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)
                                    ),
                                  ),
                                  isScrollControlled: true,
                                  context: context, 
                                  builder: (context) {
                                    return SizedBox(
                                      height: 200,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },                                                   
                                                    icon: const Icon(
                                                      Icons.close,
                                                      size: 20,
                                                    )
                                                  ),
                                                ),
                                              ),
                                              const Expanded(
                                                flex: 1,
                                                child: SizedBox(
                                                  child: Text(
                                                    "Sort by",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 23,
                                                      color: Colors.black
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                              const Expanded(
                                                flex: 1,
                                                child: SizedBox.shrink()
                                              )  
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 50),
                                            child: Column(
                                              children: [
                                                CheckboxListTile(
                                                  title: Text('adasdsd'),
                                                  value: true, 
                                                  onChanged: (value) {

                                                  }
                                                ),
                                                CheckboxListTile(
                                                  title: Text('adasdsd'),
                                                  value: true, 
                                                  onChanged: (value) {
                                                    // 
                                                  }
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    );
                                  }
                                );
                              },
                              icon: const Icon(Icons.sort)
                            )
                          ],
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }  
                }, 
              ),
              const SizedBox(height: paddingWidth - 10),
              BlocBuilder<SearchBloc, SearchState>(
                builder:(context, state) {
                  if (!state.statusSearch) {
                    return searchArea();
                  } else {
                    return resultSearch(state.products);
                  }
                },
              )
            ],
          ),
        )       
    );
  }

  Widget resultSearch(List<ProductData> data) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: List.generate(data.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.productDetails, arguments: IdArguments(data[index].id));     
                },
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
                                image: DecorationImage(
                                  image: NetworkImage(data[index].image ?? productImgDefault),
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
                                  BlocBuilder<FavoriteBloc, FavoriteState>(
                                    builder:(context, state) {
                                      var contain = state.favorites.where((element) => element.idService == data[index].id);
                                      if (contain.isEmpty) {
                                        return IconButton(
                                          onPressed: (){
                                            context.read<FavoriteBloc>().add(FavoriteAddEvent(idProduct: data[index].id));
                                          },
                                          icon: Icon(
                                            Icons.favorite_outline,
                                            color: Colors.blue.shade600,
                                            size: 30,
                                          ),
                                        );
                                      } else {
                                        return IconButton(
                                          onPressed: (){
                                            context.read<FavoriteBloc>().add(FavoriteDeleteEvent(idProduct: data[index].id));
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            color: Colors.blue.shade600,
                                            size: 30,
                                          ),
                                        );
                                      }
                                    },
                                  )
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
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(
                                  data[index].name ?? productNameDefault,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: titleTextSize),
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
                                    child: Text(
                                      "4.5 (${data[index].reviews}) | ${data[index].orders} đã đặt",
                                      style: const TextStyle(
                                        fontSize: 14
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${data[index].ticket.first.value.toString()} VND",
                                style: const TextStyle(
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
              )
            );
          })
        ),
      ),
    );
  }

  Widget searchArea() {
    return Expanded(
      child: BlocBuilder<AreaBloc, AreaState>(
        builder: (context, state) {
          return StaggeredGridView.countBuilder(
            physics: const BouncingScrollPhysics(),
            crossAxisCount: 2,
            itemCount: state.areas.length,
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
                    image: NetworkImage(state.areas[index].url ?? areaImgDefault),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    state.areas[index].name ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ),
                  ),
                )
              )
            ), 
            staggeredTileBuilder: (index) => StaggeredTile.count(1, index == 0 ? 1.2 : 1)
          );
        }
      )
    );   
  }

}
