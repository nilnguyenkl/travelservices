import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/area_bloc/area_bloc.dart';
import 'package:travelservices/blocs/area_bloc/area_event.dart';
import 'package:travelservices/blocs/category_bloc/category_bloc.dart';
import 'package:travelservices/blocs/category_bloc/category_event.dart';
import 'package:travelservices/blocs/navbar_bloc/navbar_bloc.dart';
import 'package:travelservices/blocs/product_details_bloc/product_details_bloc.dart';
import 'package:travelservices/blocs/product_details_bloc/product_details_event.dart';
import 'package:travelservices/blocs/search_bloc/search_bloc.dart';
import 'package:travelservices/blocs/signup_bloc/signup_bloc.dart';
import 'package:travelservices/repositories/area_repositories.dart';
import 'package:travelservices/repositories/auth_repositories.dart';
import 'package:travelservices/repositories/category_repositories.dart';
import 'package:travelservices/repositories/product_repositories.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/pages/product_details.dart';
import 'package:travelservices/screens/pages/route_page.dart';
import 'package:travelservices/screens/pages/verify_phone_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository()
        ),
        RepositoryProvider(
          create: (context) => AreaRepository()
        ),
        RepositoryProvider(
          create: (context) => CategoryRepository()
        ),
        RepositoryProvider(
          create: (context) => ProductRepository()
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignUpBloc(authRepo: context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => NavbarBloc(),
          ),
          BlocProvider(
            create: (context) => AreaBloc()..add(AreaLoadEvent())
          ),
          BlocProvider(
            create: (context) => CategoryBloc()..add(CategoryLoadEvent())
          ),
          BlocProvider(
            create: (context) => SearchBloc()
          ),
        ],
        child: MaterialApp(
          routes: {
            Routes.verifyPhone: (context) => const VerifyPhonePage(),
            Routes.productDetails: (context) => const ProductDetails()
          },
          debugShowCheckedModeBanner: false,
          home: const RoutePage()
        ),
      )
    );
  }
}
