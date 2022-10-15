import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travelservices/blocs/product_details_bloc/product_details_bloc.dart';
import 'package:travelservices/blocs/product_details_bloc/product_details_event.dart';
import 'package:travelservices/blocs/product_details_bloc/product_details_state.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/models/product_details_model.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/arguments/idarguments.dart';
import 'package:travelservices/screens/arguments/list_reviews_details_arguments.dart';
import 'package:travelservices/screens/widgets/delegate_list_widget.dart';
import 'package:travelservices/screens/widgets/get_box_offse_widget.dart';
import 'package:travelservices/screens/widgets/map_custom_widget.dart';



class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  late List<Map<String, dynamic>> items;
  late ScrollController scrollController;
  ProductDetailsBloc bloc = ProductDetailsBloc();
  late Map<String, double> latlng;
  @override
  void initState() {
    scrollController = ScrollController();
    Future.delayed(Duration.zero, () {
      setState(() {
        IdArguments args = ModalRoute.of(context)!.settings.arguments as IdArguments;
        bloc.add(ProductDetailsLoadEvent(id: args.getId));
      });
    });
    items = [
      {
        'name' : 'Introduce',
        'position' : 0,
      },
      {
        'name' : 'Address',
        'position' : 0,
      },
      {
        'name' : 'Event',
        'position' : 0,
      },
      {
        'name' : 'Note',
        'position' : 0,
      },
      {
        'name' : 'Reviews',
        'position' : 0,
      },
      {
        'name' : '',
        'position' : 99999,
      }
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      bloc: bloc,
      builder:(context, state) {
        if (state.getLoading) {
          return Text('asdasd');
        } else { 
          
          List<GalleryDetailsModel> list = state.productDetails?.galleries ?? <GalleryDetailsModel>[];
          List<ReviewProductDetailsModel> listReviews = state.productDetails?.reviews ?? <ReviewProductDetailsModel>[];
          String address = state.productDetails?.address ?? "";

          return Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverLayoutBuilder(
                    builder:(context, constraints) {
                      final scrolled = constraints.scrollOffset > 175;
                      return SliverAppBar(
                        expandedHeight: 240,
                        floating: false,
                        pinned: true,
                        stretch: true,
                        backgroundColor: Colors.white,
                        elevation: 0.5,
                        leading: IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          }, 
                          icon: Icon(
                            Icons.arrow_back,
                            color: scrolled ? Colors.blue.shade600 : Colors.white,
                          )
                        ),
                        title: scrolled ? Text("Details", style: TextStyle(color: Colors.blue.shade600)) : const SizedBox.shrink(),       
                        flexibleSpace: FlexibleSpaceBar(
                          stretchModes: const [StretchMode.zoomBackground],
                          background: SizedBox(
                            width: double.infinity,
                            child: CarouselSlider(
                              items: list.map((e) {
                                return carouselElement(e.url.toString());
                              }).toList(),
                              options: CarouselOptions(
                                viewportFraction: 1,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                disableCenter: false,
                              ),     
                            ),
                          )
                        ),
                        actions: [
                          IconButton(
                            onPressed: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context){
                              //   return MapSample();
                              // }));
                            }, 
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              color: scrolled ? Colors.blue.shade600 : Colors.white,
                            )
                          ),               
                        ],
                      );
                    },
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.grey.shade200, style: BorderStyle.solid)
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: paddingWidth, vertical: 10),
                      child: SizedBox(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  state.productDetails?.name.toString() ?? 'adad',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.blue.shade600,
                                    ),
                                    const Text(
                                      'Cần Thơ - Việt Nam',
                                      style: TextStyle(
                                        fontSize: 16
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Chỉ từ',
                                      style: TextStyle(
                                        fontSize: 16
                                      ),
              
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '${state.productDetails?.minPrice} VND',
                                      style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.blue.shade600
                                      ),
                                    )
                                  ],
                                ),
                              ),                      
                            ],
                          ),
                        ),
                      ),         
                    ),
                  ),
                  SliverLayoutBuilder(
                    builder: (context, constraints) {
                      final scrolled = constraints.scrollOffset;
                      return SliverPersistentHeader(
                        pinned: true,
                        floating: false,
                        delegate: DelegateListOption(items, scrolled)
                      ); 
                    },

                  ),   
                  SliverToBoxAdapter(
                    child: SizedBox(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Column(
                            children: [
                              GetBoxOffse(
                                offset: (offset) => items[0]['position'] = offset.dy,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 1, color: Colors.grey.shade200, style: BorderStyle.solid)
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: paddingWidth, vertical: 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 4,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.blue.shade600,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const Text(
                                              "Mô tả",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          state.productDetails?.description.toString() ?? productDescriptDefault,
                                          style: const TextStyle(
                                            fontSize: 16
                                          ),
                                        ),
                                      )    
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              GetBoxOffse(
                                offset: (offset) => items[1]['position'] = offset.dy,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 1, color: Colors.grey.shade200, style: BorderStyle.solid)
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: paddingWidth, vertical: 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 4,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.blue.shade600,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const Text(
                                              "Address",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: address.isEmpty ? 
                                          Text("adasd") : 
                                          SizedBox(
                                            height: 400,
                                            width: double.infinity,
                                            child: MapCustom(text: state.productDetails!.address.toString(), title: state.productDetails!.address.toString())
                                          )   
                                      )     
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              GetBoxOffse(
                                offset: (offset) => items[2]['position'] = offset.dy,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 1, color: Colors.grey.shade200, style: BorderStyle.solid)
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: paddingWidth, vertical: 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 4,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.blue.shade600,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const Text(
                                              "Event",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          state.productDetails?.event.toString() ?? productEventDefault,
                                          style: const TextStyle(
                                            fontSize: 16
                                          ),
                                        ),
                                      )     
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              GetBoxOffse(
                                offset: (offset) => items[3]['position'] = offset.dy,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 1, color: Colors.grey.shade200, style: BorderStyle.solid)
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: paddingWidth, vertical: 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 4,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.blue.shade600,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const Text(
                                              "Note",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          state.productDetails?.note.toString() ?? productNoteDefault,
                                          style: const TextStyle(
                                            fontSize: 16
                                          ),
                                        ),
                                      )     
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              GetBoxOffse(
                                offset: (offset) => items[4]['position'] = offset.dy,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 1, color: Colors.grey.shade200, style: BorderStyle.solid)
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: paddingWidth, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Row(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 4,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: Colors.blue.shade600,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                const Text(
                                                  "Reviews",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      listReviews.isEmpty ? const Text(
                                        "Chưa có review nào cả",
                                        style: TextStyle(
                                          fontSize: 16
                                        ),
                                      ) : IntrinsicHeight(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(listReviews[0].user.avatar ?? avatarDefault),
                                              radius: 35,
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: SizedBox(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 3),
                                                      child: Text(
                                                        getValueName(listReviews[0].user.firstname.toString(), listReviews[0].user.lastname.toString()),
                                                        style: const TextStyle(
                                                          fontSize: 18
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 5),
                                                      child: Text(
                                                        listReviews[0].modifiedDate.toString()
                                                      ),
                                                    ),
                                                    RatingBarIndicator(
                                                      rating: listReviews[0].point,
                                                      itemBuilder: (context, index) => const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                      ),
                                                      itemCount: 5,
                                                      itemSize: 20,
                                                      direction: Axis.horizontal,
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Expanded(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.grey.shade100,
                                                          borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        padding: const EdgeInsets.all(10),
                                                        child: Text(
                                                          listReviews[0].content,
                                                          style: const TextStyle(
                                                            fontSize: 17
                                                          ),
                                                        ),
                                                      ),
                                                    ),  
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      listReviews.isEmpty ? const SizedBox.shrink() : const Divider(thickness: 1),
                                      listReviews.isEmpty ? const SizedBox.shrink() : Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        child: TextButton(
                                          onPressed: (){
                                            Navigator.pushNamed(context, Routes.reviewsDetails, arguments: ReviewsDetailsArgument(listReviews));
                                          }, 
                                          child: const Text('Xem thêm')
                                        ),
                                      )    
                                    ],
                                  ),
                                ),
                              ), 
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }  
      },
    ); 
    
  }

  String getValueName(String? firstname, String? lastname) {
    if (firstname == "null") {
      if (lastname == "null") {
        return "User";
      } else {
        return lastname!;
      }
    } else {
      if (lastname == "null") {
        return firstname!;
      } else {
        return "$firstname $lastname";
      }
    }
  }

  Future<Map<String, double>> getAddressFromText(String text) async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    List<Location> locations = await locationFromAddress(text);
    
    print(locations.first.latitude);
    print(locations.first.longitude);

    return {
      "latitude" : locations.first.latitude,
      "longitude" : locations.first.longitude
    };
  }

  Widget carouselElement(String url){
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
        ),
      )
    );
  }
}


