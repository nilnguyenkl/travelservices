import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:travelservices/blocs/admin_product_bloc/admin_product_bloc.dart';
import 'package:travelservices/blocs/admin_product_bloc/admin_product_event.dart';
import 'package:travelservices/blocs/admin_product_bloc/admin_product_state.dart';
import 'package:travelservices/blocs/area_bloc/area_bloc.dart';
import 'package:travelservices/blocs/area_bloc/area_event.dart';
import 'package:travelservices/blocs/area_bloc/area_state.dart';
import 'package:travelservices/blocs/category_bloc/category_bloc.dart';
import 'package:travelservices/blocs/category_bloc/category_event.dart';
import 'package:travelservices/blocs/category_bloc/category_state.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/models/area_model.dart';
import 'package:travelservices/models/category_model.dart';
import 'package:travelservices/models/product_admin_model.dart';
import 'package:travelservices/screens/arguments/action_product_by_admin.dart';
import 'package:travelservices/screens/widgets/dynamic_schedule_widget.dart';
import 'package:travelservices/screens/widgets/dynamic_ticket_widget.dart';

class CreateProductAdmin extends StatefulWidget {

  const CreateProductAdmin({Key? key}) : super(key: key);

  @override
  State<CreateProductAdmin> createState() => _CreateProductAdminState();
}

class _CreateProductAdminState extends State<CreateProductAdmin> {
  
  // Controller
  TextEditingController nameProductController = TextEditingController();
  TextEditingController addressProductController = TextEditingController();
  TextEditingController descriptionProductController = TextEditingController();
  TextEditingController eventProductController = TextEditingController();
  TextEditingController noteProductController = TextEditingController();

  int currentStep = 0;
  bool? statusAction;
  
  List<DynamicTicketWidget> ticketsWidget = [];
  List<DynamicScheduleWidget> schedulessWidget = [];
  List<GalleryDetailsProduct> gralleries = []; 

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        ActionProductByAdmin args = ModalRoute.of(context)!.settings.arguments as ActionProductByAdmin;
        statusAction = args.status;
        if(args.status) {
          // Create
          
        } else {
          // Show and update
          nameProductController.text = args.productDetails?.service.name ?? "";
          addressProductController.text = args.productDetails?.service.address ?? "";
          descriptionProductController.text = args.productDetails?.service.description ?? "";
          eventProductController.text = args.productDetails?.service.event ?? "";
          noteProductController.text = args.productDetails?.service.note ?? "";

          gralleries = args.productDetails?.galleries ?? <GalleryDetailsProduct>[];

          final int sizeTicket = args.productDetails?.ticket.length ?? 999999;

          if (sizeTicket != 999999) {
            for (int i = 0; i < sizeTicket; i++) {
              ticketsWidget.add(DynamicTicketWidget());
            }
          }

          if (ticketsWidget.isNotEmpty) {
            for (int i = 0; i < ticketsWidget.length; i++) {
              ticketsWidget[i].typeController.text = args.productDetails?.ticket[i].typeTicket ?? "";
              ticketsWidget[i].noteController.text = args.productDetails?.ticket[i].note ?? "";
              ticketsWidget[i].amountController.text = args.productDetails?.ticket[i].amountTicket.toString() ?? "0";
              ticketsWidget[i].valueController.text = args.productDetails?.ticket[i].valueTicket.toString() ?? "0";
            }
          } 

          final int sizeSchedule = args.productDetails?.schedule.length ?? 999999;
          if (sizeSchedule != 999999) {
            for (int i = 0; i < sizeSchedule; i++) {
              schedulessWidget.add(DynamicScheduleWidget());
            }
          }

          if (schedulessWidget.isNotEmpty) {
            for (int i = 0; i < schedulessWidget.length; i++) {
              schedulessWidget[i].perController.text = args.productDetails?.schedule[i].quantityPerDay.toString() ?? "0";
              schedulessWidget[i].timeController.text = args.productDetails?.schedule[i].time ?? "";
            }
          }



        }
      });
    });
    super.initState();
  }

  


  @override
  Widget build(BuildContext context) {

    AdminProductBloc bloc = context.read<AdminProductBloc>();

    List<Step> getSteps() => [
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Information"), 
        content: SizedBox(
          child: Column(
            children: [
              TextFormField(
                controller: nameProductController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  label: const Text("Name")
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: addressProductController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  label: const Text("Address")
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 25),
              statusAction == true ? Column(
                children: [
                  BlocBuilder<AreaBloc, AreaState>(
                    builder: (context, state) {
                      List<AreaData> listItems = state.areas;
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue.shade600),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        height: 55,   
                        child: DropdownButton<AreaData>(
                          isDense: true,
                          isExpanded: true,
                          underline: const SizedBox.shrink(),
                          value: state.clickArea,
                          hint: const Text("Area"),
                          onChanged: (value) {
                            context.read<AreaBloc>().add(AreaClickEvent(area: value!));
                            context.read<AdminProductBloc>().add(AdminIdAreaEvent(idArea: value.id));
                          },
                          items: listItems.map<DropdownMenuItem<AreaData>>((value) {
                            return DropdownMenuItem<AreaData>(
                              value: value,
                              child: SizedBox(
                                width: 500,
                                child: Text(
                                  value.name!,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      final List<CategoryData> listItems = state.categories;
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue.shade600),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        padding: const EdgeInsets.all(10),
                        height: 55,
                        alignment: Alignment.center,      
                        child: DropdownButton<CategoryData>(
                          isDense: true,
                          isExpanded: true,
                          underline: const SizedBox.shrink(),
                          value: state.clickCategory,
                          hint: const Text("Category"),
                          onChanged: (value) {
                            context.read<CategoryBloc>().add(CategoryClickEvent(category: value!));
                            context.read<AdminProductBloc>().add(AdminIdCategoryEvent(idCategory: value.id));
                          },
                          items: listItems.map<DropdownMenuItem<CategoryData>>((value) {
                            return DropdownMenuItem<CategoryData>(
                              value: value,
                              child: SizedBox(
                                width: 500,
                                child: Text(
                                  value.name!,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                ],
              ) : const SizedBox.shrink(),
              TextFormField(
                controller: descriptionProductController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  label: const Text(
                    "Description",
                  )
                ),
                minLines: 6,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: eventProductController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  label: const Text(
                    "Event",
                  )
                ),
                minLines: 6,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: noteProductController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  label: const Text(
                    "Note",
                  )
                ),
                minLines: 6,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
              ),
            ],
          ),
        )
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Tickets"), 
        content: BlocBuilder<AdminProductBloc, AdminProductState>(
          builder:(context, state) {
            return SizedBox(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<AdminProductBloc>().add(AdminAddDynamicTicketProductEvent());
                      },
                      child: const Text("Add ticket"),
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: List.generate(state.dynamicTicket.length, (index) {
                        return Container(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    child: Text(
                                      "New Ticket",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontStyle: FontStyle.italic
                                      ),
                                    )
                                  ),
                                  SizedBox(
                                    child: IconButton(
                                      onPressed: (){}, 
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red
                                      )
                                    )
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              state.dynamicTicket[index]
                            ],
                          ),
                        );
                      })
                    )
                  ),
                  SizedBox(
                    child: Column(
                      children: List.generate(ticketsWidget.length, (index){
                        return Container(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Text(
                                      "Ticket ${index + 1}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontStyle: FontStyle.italic
                                      ),
                                    )
                                  ),
                                  SizedBox(
                                    child: IconButton(
                                      onPressed: (){}, 
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red
                                      )
                                    )
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              ticketsWidget[index]
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Schedules/Picture"), 
        content: BlocConsumer<AdminProductBloc, AdminProductState>(
          listener: (context, state) {
            // if (state.statusDeleteImage == 1) {
            //   MotionToast.success(
            //     height: 80,
            //     width: MediaQuery.of(context).size.width*3/4,
            //     title: const Text(
            //       "Success",
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold
            //       ),
            //     ),
            //     description: const Text("Successful")
            //   ).show(context);
            // }
            // if (state.statusDeleteImage == -1) {
            //   MotionToast.success(
            //     height: 80,
            //     width: MediaQuery.of(context).size.width*3/4,
            //     title: const Text(
            //       "Failed",
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold
            //       ),
            //     ),
            //     description: const Text("Something was wrong")
            //   ).show(context);
            // }
          },
          builder:(context, state) {
            return Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AdminProductBloc>().add(AdminAddDynamicScheduleProductEvent());
                    },
                    child: const Text("Add Schedule"),
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: List.generate(state.dynamicSchedule.length, (index) {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  child: Text(
                                    "New Schedule",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic
                                    ),
                                  )
                                ),
                                SizedBox(
                                  child: IconButton(
                                    onPressed: (){}, 
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red
                                    )
                                  )
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            state.dynamicSchedule[index]
                          ],
                        ),
                      );
                    })
                  )
                ),
                SizedBox(
                  child: Column(
                    children: List.generate(schedulessWidget.length, (index){
                      return Container(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  child: Text(
                                    "Schedule ${index + 1}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic
                                    ),
                                  )
                                ),
                                SizedBox(
                                  child: IconButton(
                                    onPressed: (){}, 
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red
                                    )
                                  )
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            schedulessWidget[index]
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: const Text(
                    "Picture",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  )
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    List<XFile> images = await picker.pickMultiImage();
                    if (images.isNotEmpty) {
                      bloc.add(AdminSelectMultipleImageEvent(images: images));
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: state.images.isEmpty ? const Icon(
                      Icons.photo_camera,
                      size: 80,
                      color: Colors.grey,
                    ) : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      itemCount: state.images.length,
                      itemBuilder: (_, i) => Container(
                        height: 100,
                        width: 120,
                        margin: const EdgeInsets.only(left: 3.0, right: 3.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(state.images[i].path)),
                            fit: BoxFit.cover,
                          )
                        ),
                      )
                    )
                  ),
                ),
                statusAction == false ? Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      child: const Text(
                        "Previous image",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      )
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        itemCount: gralleries.length,
                        itemBuilder: (_, i) {
                          return Container(
                            height: 100,
                            width: 120,
                            alignment: Alignment.bottomLeft,
                            margin: const EdgeInsets.only(left: 3.0, right: 3.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(state.readProduct?.galleries[i].url ?? productImgDefault),
                                fit: BoxFit.cover,
                              )
                            ),
                            child: IconButton(
                              onPressed: (){
                                context.read<AdminProductBloc>().add(AdminDeleteImageProductEvent(idLink: state.readProduct?.galleries[i].id ?? 0, publicId: state.readProduct?.galleries[i].publicId ?? ""));
                              }, 
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )
                            )
                          );
                        }
                      )
                    )
                  ],
                ) : const SizedBox.shrink(),
              ],
            );
          },
        )
      ),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Create Product",
            style: TextStyle(
              color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            onPressed: (){
              context.read<AdminProductBloc>().add(AdminResetCurrentStepProductEvent());
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
        body: BlocBuilder<AdminProductBloc, AdminProductState>(
          builder:(context, state) {
            return Stepper(
              currentStep: currentStep,
              type: StepperType.horizontal,
              steps: getSteps(),
              onStepContinue: () async {
                
                if (currentStep == getSteps().length - 1) {
                  // Send to server
                  // InforProduct service = InforProduct(
                  //   name: nameProductController.text, 
                  //   address: addressProductController.text, 
                  //   description: descriptionProductController.text, 
                  //   event: eventProductController.text, 
                  //   note: noteProductController.text, 
                  //   idArea: state.idArea, 
                  //   idCategory: state.idCategory
                  // );

                  // List<TicketForProductForAdd> tickets = [];

                  // for (var widget in state.dynamicTicket) {
                  //   TicketForProductForAdd ticket = TicketForProductForAdd(
                  //     valueTicket: int.parse(widget.valueController.text), 
                  //     typeTicket: widget.typeController.text, 
                  //     noteTicket: widget.amountController.text, 
                  //     amountTicket: int.parse(widget.amountController.text)
                  //   );
                  //   tickets.add(ticket);
                  // }

                  // List<ScheduleProductForAdd> schedules = [];
                  // for (var widget in state.dynamicSchedule) {
                  //   ScheduleProductForAdd schedule = ScheduleProductForAdd(
                  //     time: widget.timeController.text, 
                  //     quantityPerDay: int.parse(widget.perController.text)
                  //   );
                  //   schedules.add(schedule);
                  // }

                  // List<GalleryProduct> galleries = [];
                  // Api api = Api();
                  // var object = await api.uploadGalleryProduct("admin/upload", state.images);
                  // if (object is Response) {
                  //   galleries = (object.data as List).map((e) => GalleryProduct.fromJson(e)).toList();
                  
                  //   CreateProduct product = CreateProduct(
                  //     service: service, 
                  //     ticket: tickets, 
                  //     schedule: schedules, 
                  //     galleries: galleries
                  //   );
                  //   bloc.add(AdminAddProductEvent(product: product));

                  // } else {
                  //   //
                  // }
                } else {
                  currentStep = state.curentIndex + 1;
                  bloc.add(AdminCurrentIndexProductEvent(currentIndex: currentStep));
                }     
              },
              onStepCancel: () {
                currentStep = state.curentIndex - 1;
                bloc.add(AdminCurrentIndexProductEvent(currentIndex: currentStep));
              },
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width/3,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: details.onStepCancel,
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                                )
                              ),
                              backgroundColor: MaterialStateProperty.all(Colors.grey.shade200)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black
                                ),
                              ),
                            ),  
                          )
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width/3,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: details.onStepContinue,
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                                )
                              ),
                              backgroundColor: MaterialStateProperty.all(Colors.blue.shade400)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),  
                          )
                        )
                      ],
                    ),
                );
              },
            );
          },
        )
      )
    );   
  }
}
