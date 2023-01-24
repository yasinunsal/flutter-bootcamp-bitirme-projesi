import 'package:bitirme_projesi/ui/cubit/login_cubit.dart';
import 'package:bitirme_projesi/ui/screen/bottom_navigation_sayfa.dart';
import 'package:bitirme_projesi/ui/screen_materials/renkler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginSayfa extends StatefulWidget {
  const LoginSayfa({Key? key}) : super(key: key);

  @override
  State<LoginSayfa> createState() => _LoginSayfaState();
}

class _LoginSayfaState extends State<LoginSayfa> {

  @override
  Widget build(BuildContext context) {

    var tfUserEmail = TextEditingController();
    var tfUserPassword = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: uygulamaArkaPlanRenk,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Giriş Yap", style: TextStyle(fontFamily: "Roboto", fontSize: 44, fontWeight: FontWeight.bold),),
          const SizedBox(height: 32,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: tfUserEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "E-Posta Adresi",
                hintStyle: const TextStyle(fontFamily: "Roboto"),
                prefixIcon: const Icon(Icons.mail, color: Colors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: anaRenk),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: tfUserPassword,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Parola",
                hintStyle: const TextStyle(fontFamily: "Roboto"),
                prefixIcon: const Icon(Icons.lock, color: Colors.black,),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: anaRenk),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: anaRenk,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                onPressed: () async{
                  User? user = await context.read<LoginCubit>().loginUsingEmailPassword(email: tfUserEmail.text, password: tfUserPassword.text, context: context) ;
                  if(user != null){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNavigationSayfa(secilenIndeks: 0), settings: RouteSettings(arguments: user)));
                  }
                },
                child: const Text("Giriş Yap", style: TextStyle(fontFamily: "Roboto", fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
              ),
            ),
          )
        ],
      ),
    );
  }
}
