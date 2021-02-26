import 'dart:async';

mixin Validators{

  //EMAIL VALIDATOR
  var emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if(email.isEmpty){
        return sink.addError("Required");
      }
      if(email.length > 32){
        return sink.addError("Length must be less than 32");
      }
      if(email.length < 6){
        return sink.addError("Length must be more than 6");
      }
      if(!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+").hasMatch(email)){
        return sink.addError("Enter valid a email");
      }
      else{
        sink.add(email);
      }
    },
  );

  //LOGIN PASSWORD
  var loginPasswordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if(password.isEmpty){
        return sink.addError("Required");
      }
      if(password.length < 8){
        return sink.addError("Length must be more than 6");
      }
      else{
        sink.add(password);
      }
    },
  );

  //NAME VALIDATOR
  var nameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if(name.isEmpty){
        return sink.addError("Required");
      }
      if(name.length > 40){
        return sink.addError("Length must be less than 32");
      }
      if(name.length < 3){
        return sink.addError("Length must be more than 6");
      }
      if(!RegExp(r"^[a-zA-Z]+(([',. -])?[a-zA-Z]*)*$").hasMatch(name)){
        return sink.addError("Enter a valid name");
      }
      else{
        sink.add(name);
      }
    },
  );

  //PHONE VALIDATOR
  var phoneValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (phone, sink) {
      if(phone.isEmpty){
        return sink.addError("Required");
      }
      if(phone.length > 10){
        return sink.addError("Length must be less than 10");
      }
      if(phone.length < 10){
        return sink.addError("Length must be 10");
      }
      if(!RegExp(r"^[0-9]{10}").hasMatch(phone)){
        return sink.addError("Enter valid a phone number");
      }
      else{
        sink.add(phone);
      }
    },
  );

  //PASSWORD VALIDATOR
  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (pass, sink) {
      if(pass.isEmpty){
        return sink.addError("Required");
      }
      if(pass.length < 8){
        return sink.addError("Length must be 10");
      }
      if(!RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,15}$").hasMatch(pass)){
        return sink.addError("Enter valid a password");
      }
      else{
        sink.add(pass);
      }
    },
  );
}