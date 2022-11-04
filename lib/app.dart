import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/area_bloc/area_bloc.dart';
import 'package:travelservices/blocs/area_bloc/area_event.dart';
import 'package:travelservices/blocs/cart_bloc/cart_bloc.dart';
import 'package:travelservices/blocs/cart_bloc/cart_event.dart';
import 'package:travelservices/blocs/category_bloc/category_bloc.dart';
import 'package:travelservices/blocs/category_bloc/category_event.dart';
import 'package:travelservices/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:travelservices/blocs/favorite_bloc/favorite_event.dart';
import 'package:travelservices/blocs/login_bloc/login_bloc.dart';
import 'package:travelservices/blocs/navbar_bloc/navbar_bloc.dart';
import 'package:travelservices/blocs/order_bloc/order_bloc.dart';
import 'package:travelservices/blocs/search_bloc/search_bloc.dart';
import 'package:travelservices/blocs/signup_bloc/signup_bloc.dart';
import 'package:travelservices/repositories/area_repositories.dart';
import 'package:travelservices/repositories/auth_repositories.dart';
import 'package:travelservices/repositories/cart_repositories.dart';
import 'package:travelservices/repositories/category_repositories.dart';
import 'package:travelservices/repositories/favorite_repositories.dart';
import 'package:travelservices/repositories/order_repositories.dart';
import 'package:travelservices/repositories/product_repositories.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/pages/addtocart_page.dart';
import 'package:travelservices/screens/pages/admin/route_page_admin.dart';
import 'package:travelservices/screens/pages/cart_page.dart';
import 'package:travelservices/screens/pages/chat_content_page.dart';
import 'package:travelservices/screens/pages/chat_page.dart';
import 'package:travelservices/screens/pages/login_page.dart';
import 'package:travelservices/screens/pages/order_details.dart';
import 'package:travelservices/screens/pages/product_details.dart';
import 'package:travelservices/screens/pages/reviews_details_page.dart';
import 'package:travelservices/screens/pages/route_page.dart';
import 'package:travelservices/screens/pages/signup_page.dart';
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
        RepositoryProvider(
          create: (context) => FavoriteRepository()
        ),
        RepositoryProvider(
          create: (context) => OrderRepository()
        ),
        RepositoryProvider(
          create: (context) => CartRepository()
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignUpBloc(authRepo: context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => LoginBloc(authRepo: context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => FavoriteBloc(repo: context.read<FavoriteRepository>())..add(FavoriteReadEvent()),
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
            create: (context) => SearchBloc(
              favoriteBloc: BlocProvider.of<FavoriteBloc>(context), 
              navbarBloc: BlocProvider.of<NavbarBloc>(context),
            )
          ),
          BlocProvider(
            create: (context) => CartBloc()..add(CartReadEvent()),
          ),
          BlocProvider(
            create: (context) => OrderBloc(),
          ),
        ],
        child: MaterialApp(
          routes: {
            Routes.verifyPhone: (context) => const VerifyPhonePage(),
            Routes.productDetails: (context) => const ProductDetails(),
            Routes.routesPage: (context) => const RoutePage(),
            Routes.reviewsDetails: (context) => const ReviewsDetailsPage(),
            Routes.addToCart: (context) => const AddToCartPage(),   
            Routes.login: (context) => const LoginPage(),
            Routes.register: (context) => const SignUpPage(),
            Routes.routePageAdmin: (context) => const RoutePageAdmin(),
            Routes.orderDetails: (context) => const OrderDetails(),
            Routes.cartPage: (context) => const CartPage(),
            Routes.chatPage: (context) => const ChatPage(),
            Routes.chatContentPage: (context) => const ChatContentPage() 
          },
          debugShowCheckedModeBanner: false,
          home: const RoutePage()
        ),
      )
    );
  }
}
