import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/ui/cubit/anasayfa_cubit.dart';
import 'package:bitirme_projesi/ui/screen/yemek_detay_sayfa.dart';
import 'package:bitirme_projesi/ui/screen_materials/renkler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();

  }
  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(title: const Text("Yemek Sipariş", style: TextStyle(fontFamily: "Roboto"),), backgroundColor: anaRenk, centerTitle: true,),
      backgroundColor: uygulamaArkaPlanRenk,
      body: BlocBuilder<AnasayfaCubit, List<Yemekler>>(
        builder: (context, yemeklerListesi){
          if(yemeklerListesi.isNotEmpty){
            return ListView.builder(
                itemCount: yemeklerListesi.length,
                itemBuilder: (context, index){
                  var yemek = yemeklerListesi[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 16),
                    child: Container(height: 150,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 7,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(20))
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}")),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8, top: 16),
                                  child: Text(yemek.yemek_adi, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8, top: 16),
                                  child: Text("₺${yemek.yemek_fiyat}", style: const TextStyle(fontSize: 18, fontFamily: "Roboto")),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => YemekDetaySayfa(yemek: yemek),
                                  settings: RouteSettings(arguments: user)))
                                  .then((value) { context.read<AnasayfaCubit>().yemekleriYukle();});
                            },
                            child: Container(width: 40, height: 150,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                                color: anaRenk,
                              ),
                              child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }else{
            return const Center();
          }
        },
      ),
    );
  }
}
