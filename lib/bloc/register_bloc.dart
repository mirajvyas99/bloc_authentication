import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with Validators{
  final _name = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _phoneNumber = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _confirmPassword = BehaviorSubject<String>();

  //Getters
  Stream<String> get name => _name.stream.transform(nameValidator);
  Stream<String> get email => _email.stream.transform(emailValidator);
  Stream<String> get phoneNumber => _phoneNumber.stream.transform(phoneValidator);
  Stream<String> get password => _password.stream.transform(passwordValidator);
  Stream<String> get confirmPassword => _confirmPassword.stream;

  Stream<bool> get isValid => Rx.combineLatest5(name, email, phoneNumber, password, confirmPassword, (a, b, c, d, e) => true);
  Stream<bool> get isPassMatch => Rx.combineLatest2(password, confirmPassword, (a, b) {
    if(a!=b){
      return false;
    }
    else{
      return true;
    }
  });

  //Setters
  Function(String) get changeName => _name.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePhoneNumber => _phoneNumber.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeConfirmPassword => _confirmPassword.sink.add;

  void submit(){
    if(password != confirmPassword){
      _confirmPassword.sink.addError("Password doesn't match");
    }
    else{
      print("REGISTER");
    }
  }

  void dispose(){
    _name.close();
    _email.close();
    _phoneNumber.close();
    _password.close();
    _confirmPassword.close();
  }
}