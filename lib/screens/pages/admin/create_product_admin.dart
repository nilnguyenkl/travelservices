import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelservices/blocs/admin_product_bloc/admin_product_bloc.dart';
import 'package:travelservices/blocs/admin_product_bloc/admin_product_event.dart';
import 'package:travelservices/blocs/admin_product_bloc/admin_product_state.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/screens/widgets/dynamic_schedule_widget.dart';
import 'package:travelservices/screens/widgets/dynamic_ticket_widget.dart';

class CreateProductAdmin extends StatefulWidget {
  const CreateProductAdmin({Key? key}) : super(key: key);

  @override
  State<CreateProductAdmin> createState() => _CreateProductAdminState();
}

class _CreateProductAdminState extends State<CreateProductAdmin> {
  
  int currentStep = 0;

  List<DynamicTicketWidget> listTicketWidget = [];

  List<DynamicScheduleTicket> listScheduleWidget = [];

  addTicketWidget () {
    listTicketWidget.add(DynamicTicketWidget());
    setState(() {});
  }

  addSchedule () {
    listScheduleWidget.add(DynamicScheduleTicket());
    setState(() {
    });
  }

  

  @override
  Widget build(BuildContext context) {

    AdminProductBloc bloc = context.read<AdminProductBloc>();

    TextEditingController nameProductController = TextEditingController();
    TextEditingController addressProductController = TextEditingController();
    TextEditingController descriptionProductController = TextEditingController();
    TextEditingController eventProductController = TextEditingController();
    TextEditingController noteProductController = TextEditingController();


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
        content: SizedBox(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: addTicketWidget,
                  child: const Text("Add ticket"),
                ),
              ),
              SizedBox(
                child: Column(
                  children: List.generate(listTicketWidget.length, (index) {
                    return Column(
                      children: [
                        const SizedBox(height: 25),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          child: Text(
                            "Ticket ${index + 1}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),
                          )
                        ),
                        const SizedBox(height: 10),
                        listTicketWidget[index]
                      ],
                    );
                  })
                )
              )
            ],
          ),
        )
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Schedules/Picture"), 
        content: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: addSchedule,
                child: const Text("Add Schedule"),
              ),
            ),
            SizedBox(
              child: Column(
                children: List.generate(listScheduleWidget.length, (index) {
                  return Column(
                    children: [
                      const SizedBox(height: 25),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        child: Text(
                          "Schedule ${index + 1}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                        )
                      ),
                      const SizedBox(height: 10),
                      listScheduleWidget[index]
                    ],
                  );
                })
              )
            ),
            const SizedBox(height: 25),
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
            BlocBuilder<AdminProductBloc, AdminProductState>(
              bloc: bloc,
              builder: (context, state) {
                return InkWell(
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
                );
              }
            )
          ],
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
        body: Stepper(
          currentStep: currentStep,
          type: StepperType.horizontal,
          steps: getSteps(),
          onStepContinue: () {
            
            if (currentStep == getSteps().length - 1) {
              listScheduleWidget.forEach((element) {
              print(element.timeController.text);
            });
            } else {
              setState(() {
              currentStep++;
            });
            }
            
            // print(nameProductController.text);
            // print(addressProductController.text);
            // print(descriptionProductController.text);
            // print(eventProductController.text);
            // print(noteProductController.text);

            // listTicketWidget.forEach((element) {
            //   print(element.valueController.text);
            // });

            
          },
          onStepCancel: () {
            setState(() {
              currentStep--;
            });
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
        ),
      )
    );   
  }
}
