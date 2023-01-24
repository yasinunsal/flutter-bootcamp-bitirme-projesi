import 'package:bitirme_projesi/data/repo/sepet_yemekler_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YemekDetayCubit extends Cubit<void>{

  YemekDetayCubit():super(0);

  var srepo = SepetYemeklerDaoRepository();

  Future<void> sepeteYemekEkle(String yemek_adi, String yemek_resim_adi, int yemek_fiyat, int yemek_siparis_adet, String kullanici_adi) async{
    await srepo.sepeteYemekEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }
}