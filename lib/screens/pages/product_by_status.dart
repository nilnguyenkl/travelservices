
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:travelservices/api/api.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/models/product_by_status_model.dart';
import 'package:travelservices/screens/arguments/status_order_arguments.dart';
import 'package:travelservices/screens/widgets/loading_widget.dart';

class ProductByStatus extends StatefulWidget {
  const ProductByStatus({Key? key}) : super(key: key);

  @override
  State<ProductByStatus> createState() => _ProductByStatusState();
}

class _ProductByStatusState extends State<ProductByStatus> {

  Future<List<ProductByStatusModel>>? listOrder;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        StatusOrderArguments args = ModalRoute.of(context)!.settings.arguments as StatusOrderArguments;
        listOrder = getListOrderByStatus(args.status);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Orders",
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
              Icons.arrow_back,
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
        body: SizedBox(
          child: FutureBuilder(
            future: listOrder,
            builder:(context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data as List<ProductByStatusModel>;
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder:(context, index) {
                    return SizedBox(
                      child: Card(
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                                        image: DecorationImage(
                                          image: NetworkImage(data[index].url),
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
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  showDialog(
                                                    context: context, 
                                                    builder: (context) {
                                                      return Container(
                                                        height: 100,
                                                        width: 100,
                                                      );
                                                    }
                                                  );
                                                },
                                                child: Text(
                                                  "Order Information",
                                                  style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.blue.shade600
                                                  ),
                                                )
                                              ),
                                              const SizedBox(width: 7),
                                              InkWell(
                                                onTap: (){

                                                },
                                                child: Text(
                                                  "Product Details",
                                                  style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.blue.shade600
                                                  ),  
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Text(
                                          data[index].nameService,
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
                                            data[index].description,
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
                                            "${data[index].bookDay} ${data[index].bookTime}",
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
                                            ticketAllType(data[index].tickets),
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
                                            "Note: ....",
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
                                            "Total: ${data[index].total} VND",
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 18
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 5),
                                            child: Text(
                                              "Time: ${data[index].createDate.year}-${data[index].createDate.month}-${data[index].createDate.day} ${data[index].createDate.hour}:${data[index].createDate.minute}",
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontSize: 14,
                                                fontStyle: FontStyle.italic
                                              ),
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
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const LoadingWidget();
              }
            },
          )
        ),
      )
    );   
  }

  String ticketAllType(List<TicketProductByStatus> items) {
    String temp = "";
    for (int i = 0; i < items.length; i++) {
      temp = "$temp${items[i].typeTicket} x ${items[i].amountTicket}, ";
    }
    return temp.substring(0, temp.length - 2);
  }

  Future<List<ProductByStatusModel>> getListOrderByStatus(String status) async {
    Api api = Api();
    var response = await api.getRequestAuth(Api.url, "orderitem/$status");
    if (response is Response) {
      return (response.data as List).map((e) => ProductByStatusModel.fromJson(e)).toList();
    } else {
      return <ProductByStatusModel>[];
    }
  }


}