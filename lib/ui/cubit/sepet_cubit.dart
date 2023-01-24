import 'package:bitirme_projesi/data/entity/sepet_yemekler.dart';
import 'package:bitirme_projesi/data/repo/sepet_yemekler_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetCubit extends Cubit<List<SepetYemekler>>{
  SepetCubit():super(<SepetYemekler>[]);

  var srepo = SepetYemeklerDaoRepository();

  Future<void> sepettekiYemekleriYukle(String kullaniciAdi) async{
    var liste = await srepo.sepettekiYemekleriGetir(kullaniciAdi);
    emit(liste);
  }

  Future<void> sepettenYemekSil(int sepetYemekId, String kullaniciAdi) async{
    await srepo.sepettenYemekSil(sepetYemekId, kullaniciAdi);
    await sepettekiYemekleriYukle(kullaniciAdi);
  }

  int toplamFiyat(List<SepetYemekler> liste){
    int toplam = 0;
    for(SepetYemekler sy in liste){
      toplam += (int.parse(sy.yemek_fiyat))*(int.parse(sy.yemek_siparis_adet));
    }
    return toplam;
  }


}