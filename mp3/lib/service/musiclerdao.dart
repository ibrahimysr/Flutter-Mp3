import 'package:mp3/Veritabaniyardimcisi.dart';
import 'package:mp3/service/musicler.dart';

class musiclerdao {

  Future<List<musicler>> Tumkategoriler() async {
    var db = await VeritabaniYardimcisi.veritabanierisim();

    List<Map<String, dynamic>> maps =
    await db.rawQuery("SELECT * FROM musicler");

    return List.generate(maps.length, (i) {
      var satir = maps[i];

      return musicler(
          satir["music_id"], satir["music_ad"], satir["music_sanatci"],
          satir["music_resim"]);
    });

  }
  Future<List<musicler>> Musicara(String ArananKelime) async {
    var db = await VeritabaniYardimcisi.veritabanierisim();

    List<Map<String, dynamic>> maps =
    await db.rawQuery("SELECT * FROM musicler WHERE music_ad like '%$ArananKelime%'");

    return List.generate(maps.length, (i) {
      var satir = maps[i];

      return musicler(
          satir["music_id"], satir["music_ad"], satir["music_sanatci"],
          satir["music_resim"]);
    });
  }
}