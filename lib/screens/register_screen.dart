import '../bloc/register_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of<RegisterBloc>(context, listen: false);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Register",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                SizedBox(height: 30),
                StreamBuilder<Object>(
                  stream: bloc.name,
                  builder: (context, snapshot) {
                    return TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Enter Name",
                        labelText: "Name",
                        errorText: snapshot.error,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onChanged: (value) =>bloc.changeName,
                    );
                  }
                ),
                SizedBox(height: 30),
                StreamBuilder<Object>(
                  stream: bloc.email,
                  builder: (context, snapshot) {
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
                      onChanged: (value) => bloc.changeEmail,
                    );
                  }
                ),
                SizedBox(height: 20),
                StreamBuilder<Object>(
                  stream: bloc.phoneNumber,
                  builder: (context, snapshot) {
                    return TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Enter Phone Number",
                        labelText: "Phone Number",
                        errorText: snapshot.error,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onChanged: (value) => bloc.changePhoneNumber,
                    );
                  }
                ),
                SizedBox(height: 20),
                StreamBuilder<Object>(
                  stream: bloc.password,
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
                      onChanged: (value) => bloc.changePassword,
                    );
                  }
                ),
                SizedBox(height: 20),
                StreamBuilder<Object>(
                  stream: bloc.confirmPassword,
                  builder: (context, snapshot) {
                    return TextField(
                      keyboardType: TextInputType.emailAddress,
                      obscureText: isVisible,
                      decoration: InputDecoration(
                        hintText: "confirm Password",
                        labelText: "Confirm Password",
                        errorText: snapshot.error,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        suffixIcon: IconButton(
                          icon: isVisible
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: (){
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) => bloc.changeConfirmPassword,
                    );
                  }
                ),
                SizedBox(height: 20),
                _buildButton(),
                SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "Already have an account?",style: TextStyle(color: Colors.black),),
                      WidgetSpan(child: SizedBox(width: 5,)),
                      TextSpan(
                        text:  "Login",
                        recognizer: TapGestureRecognizer() ..onTap = (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen(),
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
      ),
    );
  }

  Widget _buildButton(){

    final bloc = Provider.of<RegisterBloc>(context, listen: false);

    return StreamBuilder<Object>(
      stream: bloc.isValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text("Register"),
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
