import 'bloc/register_bloc.dart';
import 'package:provider/provider.dart';
import 'bloc/login_bloc.dart';
import 'screens/login_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginBloc>(create: (context) => LoginBloc()),
        Provider<RegisterBloc>(create: (context) => RegisterBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Authentication",
        theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
        home: LoginScreen(),
      ),
    );
  }
}
