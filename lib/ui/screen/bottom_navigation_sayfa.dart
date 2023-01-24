import 'package:bitirme_projesi/ui/screen/anasayfa.dart';
import 'package:bitirme_projesi/ui/screen/sepet_sayfa.dart';
import 'package:bitirme_projesi/ui/screen_materials/renkler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomNavigationSayfa extends StatefulWidget {
  //const BottomNavigationSayfa({Key? key}) : super(key: key);
  int secilenIndeks;


  BottomNavigationSayfa({super.key, required this.secilenIndeks});

  @override
  State<BottomNavigationSayfa> createState() => _BottomNavigationSayfaState();
}

class _BottomNavigationSayfaState extends State<BottomNavigationSayfa> {

  //int secilenIndeks = 0;

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as User;
    var sayfaListesi = [const Anasayfa(), SepetSayfa(user: user)];
    return Scaffold(
      body: sayfaListesi[widget.secilenIndeks],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Anasayfa",

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Sepet"),
        ],
        selectedLabelStyle: const TextStyle(fontFamily: "Roboto"),
        unselectedLabelStyle: const TextStyle(fontFamily: "Roboto"),
        selectedItemColor: anaRenk,
        currentIndex: widget.secilenIndeks,
        onTap: (indeks){
          setState(() {
            widget.secilenIndeks = indeks;
          });
        },
      ),
    );
  }
}
