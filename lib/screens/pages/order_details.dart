import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/order_bloc/order_bloc.dart';
import 'package:travelservices/blocs/order_bloc/order_event.dart';
import 'package:travelservices/blocs/order_bloc/order_state.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/models/order_model.dart';
import 'package:travelservices/screens/arguments/order_arguments.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    OrderArguments args = ModalRoute.of(context)!.settings.arguments as OrderArguments;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Order",
            style: TextStyle(
              color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
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
        body: Column(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(1, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Card(
                              elevation: 2,
                              child: Container(
                                padding: const EdgeInsets.only(right: 20),
                                width: double.infinity,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 20, top: 7),
                                      alignment: Alignment.centerLeft,
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Thay đổi",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: hintText
                                          ),
                                        )
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Divider(thickness: 1),
                                    ),
                                    SizedBox(
                                      height: 130,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  Text(
                                                    args.nameProduct,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      args.description,
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
                                                      "${args.items.first.bookDay} ${args.items.first.bookTime}",
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
                                                      ticketAllType(args.items.first.tickets),
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
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: TextFormField(
                                        autofocus: false,
                                        controller: noteController,
                                        decoration: InputDecoration(
                                          hintText: 'Note',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15)
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Divider(thickness: 1),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Text(
                                        "${totalValue(args.items.first.tickets)} VND",
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
                              controller: nameController,
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
                              controller: emailController,
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
                              controller: phoneController,
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
            BlocBuilder<OrderBloc, OrderState>(
              builder:(context, state) {
                return Container(
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
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total\n${totalValue(args.items.first.tickets)} VND",
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      ElevatedButton(
                        onPressed: (){
                          OrderRequestModel model = OrderRequestModel(
                            infor: InforUserOrder(
                              email: emailController.text, 
                              fullname: nameController.text, 
                              phone: phoneController.text
                            ), 
                            statusOrder: true, 
                            items: setNote(args.items, noteController.text)
                          );
                          context.read<OrderBloc>().add(OrderSubmitEvent(orderData: model));
                        }, 
                        child: const SizedBox(
                          height: 50,
                          width: 100,
                          child: Center(
                            child: Text(
                              "Order",
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
                );
              },
            )
          ],
        ),
      )
    ); 
  }

  String ticketAllType(List<TicketsOrder> items) {
    String temp = "";

    for (int i = 0; i < items.length; i++) {
      temp = "$temp${items[i].typeTicket} x ${items[i].amountTicket}, ";
    }
    return temp.substring(0, temp.length - 2);
  }

  int totalValue(List<TicketsOrder> items) {
    int temp = 0;
    for (int i = 0; i < items.length; i++) {
      temp = temp + items[i].amountTicket*items[i].valueTicket;
    }
    return temp;
  }

  List<ItemsTicket> setNote(List<ItemsTicket> temps, String note) {
    List<ItemsTicket> tickets = temps;
    for (int i = 0; i < temps.length; i++) {
      tickets[i].note = note;
    }
    return tickets;
  }
  
}