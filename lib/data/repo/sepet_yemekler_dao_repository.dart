import 'package:bitirme_projesi/data/entity/sepet_yemekler.dart';
import 'package:bitirme_projesi/data/entity/sepet_yemekler_cevap.dart';
import 'dart:convert';

import 'package:dio/dio.dart';

class SepetYemeklerDaoRepository{

  List<SepetYemekler> parseSepetYemeklerCevap(String cevap){
    try{
      return SepetYemeklerCevap.fromJson(json.decode(cevap)).sepet_yemekler;
    }
    catch(e){
      return [];
    }
  }

  Future<void> sepeteYemekEkle(String yemek_adi, String yemek_resim_adi, int yemek_fiyat, int yemek_siparis_adet, String kullanici_adi) async{
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {"yemek_adi":yemek_adi, "yemek_resim_adi":yemek_resim_adi, "yemek_fiyat":yemek_fiyat, "yemek_siparis_adet":yemek_siparis_adet, "kullanici_adi":kullanici_adi};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Sepete Eklenen Yemek: $veri");
    print("Sepete Yemek Ekle: ${cevap.data.toString()}");
  }

  Future<List<SepetYemekler>> sepettekiYemekleriGetir(String kullanici_adi) async{
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi":kullanici_adi};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Sepetteki Yemekleri Yükle: ${cevap.data.toString()}");
    return parseSepetYemeklerCevap(cevap.data.toString());
  }

  Future<void> sepettenYemekSil(int sepet_yemek_id, String kullanici_adi) async{
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {"sepet_yemek_id":sepet_yemek_id, "kullanici_adi":kullanici_adi};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Sepetten Yemek Sil: ${cevap.data.toString()}");
  }
}