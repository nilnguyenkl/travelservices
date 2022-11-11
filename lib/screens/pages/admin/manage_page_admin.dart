import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/admin_product_bloc/admin_product_bloc.dart';
import 'package:travelservices/blocs/admin_product_bloc/admin_product_event.dart';
import 'package:travelservices/blocs/admin_product_bloc/admin_product_state.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/arguments/action_product_by_admin.dart';

class ManagePageAdmin extends StatefulWidget {
  const ManagePageAdmin({Key? key}) : super(key: key);

  @override
  State<ManagePageAdmin> createState() => _ManagePageAdminState();
}

class _ManagePageAdminState extends State<ManagePageAdmin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextButton(
              onPressed: (){
                Navigator.pushNamed(context, Routes.createProductAdmin, arguments: ActionProductByAdmin(status: true));
              }, 
              child: Text("Create")
            ),
            BlocConsumer<AdminProductBloc, AdminProductState>(
              listener: (context, state) {
                if (state.getProductDetails) {
                  Navigator.pushNamed(context, Routes.createProductAdmin, arguments: ActionProductByAdmin(productDetails: state.readProduct, status: false));
                }
              },
              builder:(context, state) {
                return TextButton(
                  onPressed: (){
                    context.read<AdminProductBloc>().add(AdminProductDetailsEvent(idService: 7));
                  }, 
                  child: Text("Update")
                );
              },
            )
          ],
        )
      )
    );   
  }
}