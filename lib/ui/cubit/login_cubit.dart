import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<User?>{
  LoginCubit() : super(null);

  Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    }
    catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("E-posta adresiniz veya şifreniz hatalıdır."),
          ),
        );
    }
    return user;
  }
}