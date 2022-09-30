import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/navbar_bloc/navbar_bloc.dart';
import 'package:travelservices/blocs/signup_bloc/signup_bloc.dart';
import 'package:travelservices/repositories/auth_repositories.dart';
import 'package:travelservices/routes.dart';
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
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignUpBloc(authRepo: context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => NavbarBloc(),
          )
        ],
        child: MaterialApp(
          routes: {
            Routes.verifyPhone: (context) => const VerifyPhonePage()
          },
          debugShowCheckedModeBanner: false,
          home: RoutePage()
        ),
      )
    );
  }
}
