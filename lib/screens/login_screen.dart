import '../bloc/login_bloc.dart';
import 'package:provider/provider.dart';

import 'register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of<LoginBloc>(context,listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Login",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              SizedBox(height: 30),
              StreamBuilder<String>(
                stream: bloc.loginEmail,
                builder: (context, AsyncSnapshot<String> snapshot) {
                  return TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Enter Email",
                      labelText: "Email ID",
                      errorText: snapshot.error,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onChanged: (value) => bloc.changeLoginEmail,
                  );
                }
              ),
              SizedBox(height: 30),
              StreamBuilder<String>(
                stream: bloc.loginPassword,
                builder: (context, snapshot) {
                  return TextField(
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      labelText: "Password",
                      errorText: snapshot.error,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onChanged: (value) => bloc.changeLoginPassword,
                  );
                }
              ),
              SizedBox(height: 20),
              _buildButton(),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Don't have an account?",style: TextStyle(color: Colors.black),),
                    WidgetSpan(child: SizedBox(width: 5,)),
                    TextSpan(
                      text:  "Register",
                      recognizer: TapGestureRecognizer() ..onTap = (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                        ));
                      },
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(){

    final bloc = Provider.of<LoginBloc>(context,listen: false);

    return StreamBuilder<Object>(
      stream: bloc.isValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text("Login"),
          color: snapshot.hasError || !snapshot.hasData ? Colors.grey : Colors.black,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: snapshot.hasError || !snapshot.hasData
              ? null
              : (){
            bloc.submit();
          },
        );
      }
    );
  }
}
