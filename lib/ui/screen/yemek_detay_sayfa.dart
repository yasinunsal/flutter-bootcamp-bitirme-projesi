import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/ui/cubit/yemek_detay_cubit.dart';
import 'package:bitirme_projesi/ui/screen/bottom_navigation_sayfa.dart';
import 'package:bitirme_projesi/ui/screen/sepet_sayfa.dart';
import 'package:bitirme_projesi/ui/screen_materials/renkler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YemekDetaySayfa extends StatefulWidget {

  Yemekler yemek;

  YemekDetaySayfa({required this.yemek});

  @override
  State<YemekDetaySayfa> createState() => _YemekDetaySayfaState();
}

class _YemekDetaySayfaState extends State<YemekDetaySayfa> {
  var tfAdet = TextEditingController();
  var adet = 0;
  int secilenIndeks = 0;
 
  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(title: const Text("Yemek Detay", style: TextStyle(fontFamily: "Roboto")), backgroundColor: anaRenk, centerTitle: true),
      body: Center(
        child: Column(
          children: [
            Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.yemek.yemek_adi, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("₺${widget.yemek.yemek_fiyat}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    style: const ButtonStyle(),
                    onPressed: (){
                      setState(() {
                        if(adet == 0){
                          adet = 0;
                        }else{
                          adet--;
                        }
                      });
                    }, icon: const Icon(Icons.remove)),
                Text("$adet", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
                IconButton(
                    onPressed: (){
                      setState(() {
                        adet++;
                      });
                    }, icon: const Icon(Icons.add)),
              ],
            ),
            ElevatedButton(onPressed: (){
              if(adet > 0){
                context.read<YemekDetayCubit>().sepeteYemekEkle(
                    widget.yemek.yemek_adi,
                    widget.yemek.yemek_resim_adi,
                    int.parse(widget.yemek.yemek_fiyat),
                    adet,
                    user.email!);
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Lütfen Adet Seçiniz."))
                );
              }
            },
              style: ElevatedButton.styleFrom(backgroundColor: anaRenk),
              child: const Text("Sepete Ekle", style: TextStyle(fontFamily: "Roboto"),),
            ),
            const SizedBox(height: 64,),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigationSayfa(secilenIndeks: 1), settings: RouteSettings(arguments: user)));
            },
              style: ElevatedButton.styleFrom(backgroundColor: anaRenk),
              child: const Text("Sepete Git", style: TextStyle(fontFamily: "Roboto", fontSize: 16),),

            ),
          ],
        ),
      ),
    );
  }
}
