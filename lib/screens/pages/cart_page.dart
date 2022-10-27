import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/cart_bloc/cart_bloc.dart';
import 'package:travelservices/blocs/cart_bloc/cart_state.dart';
import 'package:travelservices/configs/colors.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool? status = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Cart",
            style: TextStyle(
              color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: (){}, 
              child: const Text(
                "Tiếp tục mua hàng",
                style: TextStyle(
                  fontSize: 18
                ),
              )
            )
          ],
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Colors.blue.shade600,
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
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder:(context, state) {
            if (state.getLoading) {
              return Text("adsadasdsa");
            } else {
              print("${state.items.length}");
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          SizedBox(
                            child: Column(
                              children: List.generate(state.items.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Card(
                                    elevation: 2,
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 20),
                                      width: double.infinity,
                                      height: MediaQuery.of(context).size.height/3.5,
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5),
                                                child: Checkbox(
                                                  activeColor: Colors.blue.shade600,
                                                  value: status, 
                                                  onChanged: (value) {
                                                    setState(() {
                                                      status = value;
                                                      print(value);
                                                    });
                                                  }
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: (){},
                                                child: const Text(
                                                  "Thay đổi",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: hintText
                                                  ),
                                                )
                                              )
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Divider(thickness: 1),
                                          ),
                                          SizedBox(
                                            height: 120,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 20),
                                                    child: Container(
                                                      height: 110,
                                                      width: 110,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        image: const DecorationImage(
                                                          image: AssetImage("assets/images/ct.jpg"),
                                                          fit: BoxFit.fitHeight,
                                                          alignment: Alignment.topCenter,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 20),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Text(
                                                          "Vé VinWonders Nam Hội An",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 17
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 5),
                                                          child: Text(
                                                            "Vé VinWonders Nam Hội An Vé VinWonders Nam Hội An Vé VinWonders Nam Hội An Vé VinWonders Nam Hội An Vé VinWonders Nam Hội An",
                                                            maxLines: 3,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                              color: Colors.grey.shade500,
                                                              fontSize: 14
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 5),
                                                          child: Text(
                                                            "2022-09-27",
                                                            maxLines: 3,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                              color: Colors.grey.shade500,
                                                              fontSize: 14
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 5),
                                                          child: Text(
                                                            "Trẻ em x1",
                                                            maxLines: 3,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                              color: Colors.grey.shade500,
                                                              fontSize: 14
                                                            ),
                                                          ),
                                                        ),
                                                      
                                                      ],
                                                    ),
                                                  ) 
                                                )
                                              ],
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Divider(thickness: 1),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "1700000 VDN",
                                              style: TextStyle(
                                                color: Colors.blue.shade600,
                                                fontSize: 22
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }) 
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 4,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(3),
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        "Thông tin khách hàng",
                                        style: TextStyle(
                                          fontSize: 20
                                        ),
                                      )
                                    ],
                                  ),
                                  const Divider(thickness: 1),
                                  const Text(
                                    "Tên",
                                    style: TextStyle(
                                      fontSize: 18
                                    ),  
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Tên người đặt hàng"
                                    ),
                                  ),
                                  const Divider(thickness: 1),
                                  const Text(
                                    "Email",
                                    style: TextStyle(
                                      fontSize: 18
                                    ),  
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email người đặt hàng"
                                    ),
                                  ),
                                  const Divider(thickness: 1),
                                  const Text(
                                    "Số điện thoại",
                                    style: TextStyle(
                                      fontSize: 18
                                    ),  
                                  ),
                                  const Divider(thickness: 1),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Số điện thoại người đặt hàng"
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    width: double.infinity,
                    height: 80,            
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total\n3200000 VND",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        ElevatedButton(
                          onPressed: (){}, 
                          child: const SizedBox(
                            height: 50,
                            width: 100,
                            child: Center(
                              child: Text(
                                "Đặt hàng (1)",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16
                                ),
                              ),
                            ),
                          )
                        )
                      ],
                    ),
                  )

                ],
              );
            }   
          },
        )
      )
    );   
  }
}