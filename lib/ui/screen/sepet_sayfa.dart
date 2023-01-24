import 'package:bitirme_projesi/data/entity/sepet_yemekler.dart';
import 'package:bitirme_projesi/ui/cubit/sepet_cubit.dart';
import 'package:bitirme_projesi/ui/screen_materials/renkler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetSayfa extends StatefulWidget {

  User user;
  SepetSayfa({required this.user});

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {

  @override
  void initState() {
    super.initState();
    context.read<SepetCubit>().sepettekiYemekleriYukle(widget.user.email!);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Sepet", style: TextStyle(fontFamily: "Roboto")), backgroundColor: anaRenk, centerTitle: true),
      backgroundColor: uygulamaArkaPlanRenk,
      body: BlocBuilder<SepetCubit, List<SepetYemekler>>(
        builder: (context, sepetYemeklerListesi){
          if(sepetYemeklerListesi.isNotEmpty){
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 488,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: sepetYemeklerListesi.length,
                    itemBuilder: (context, index){
                      var sepetYemek = sepetYemeklerListesi[index];
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
                                    child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${sepetYemek.yemek_resim_adi}")),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8, top: 16),
                                      child: Text(sepetYemek.yemek_adi, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8, top: 16),
                                      child: Text("${sepetYemek.yemek_siparis_adet} Adet", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8, top: 16),
                                      child: Text("₺${int.parse(sepetYemek.yemek_fiyat)* int.parse(sepetYemek.yemek_siparis_adet)}", style: const TextStyle(fontSize: 18, fontFamily: "Roboto")),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: (){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("${sepetYemek.yemek_adi} silinsin mi?"),
                                      action: SnackBarAction(
                                          label: "Evet",
                                          onPressed: (){
                                            context.read<SepetCubit>().sepettenYemekSil(int.parse(sepetYemek.sepet_yemek_id), sepetYemek.kullanici_adi);
                                          }),
                                    ),
                                  );
                                },
                                child: Container(width: 40, height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                                    color: anaRenk,
                                  ),
                                  child: const Icon(Icons.delete, color: Colors.white, size: 20,),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32, right: 32, bottom: 4, top: 4),
                    child: Container(height: 50,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 7,
                            )
                          ],
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Toplam:  ₺${context.read<SepetCubit>().toplamFiyat(sepetYemeklerListesi)}", style: const TextStyle(fontFamily: "Roboto", fontSize: 16, color: Colors.black),),
                          ),
                          SizedBox(
                            height: 50,
                            width: 130,
                            child: RawMaterialButton(shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                            ),
                              fillColor: anaRenk,
                              onPressed: (){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                        content: const Text("Sipariş Başarıyla Verildi.", style: TextStyle(fontSize: 20, fontFamily: "Roboto", fontWeight: FontWeight.bold,),),
                                        actions: [
                                          TextButton(
                                              onPressed: (){
                                                Navigator.pop(context);
                                              },
                                              child: Text("Kapat", style: TextStyle(color: anaRenk, fontFamily: "Roboto")),
                                          ),
                                        ],
                                      );
                                    }
                                  );
                                  setState(() {
                                    for(SepetYemekler sy in sepetYemeklerListesi){
                                      context.read<SepetCubit>().sepettenYemekSil(int.parse(sy.sepet_yemek_id), sy.kullanici_adi);
                                    }
                                  });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text("Sipariş Ver", style: TextStyle(fontFamily: "Roboto", fontSize: 16, color: Colors.white)),
                                  Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16,),
                                ],
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }else{
            return const Center(
              child: Text("Sepetinizde ürün bulunmamaktadır.", style: TextStyle(fontFamily: "Roboto", fontSize: 24, color: Colors.grey),),
            );
          }
        },
      ),
    );
  }
}
