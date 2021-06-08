class Segnalazioni {
  String ltg;
  String date;
  String type;
  String descript;
  String image;

  Segnalazioni(this.ltg, this.date, this.type,this.descript, {this.image});

  Segnalazioni.fromMap(Map snapshot,String id) :
        ltg = snapshot["ltg"] ?? "",
        date = snapshot['date'] ?? '',
        type = snapshot['type'] ?? '',
        descript = snapshot['descript'] ?? '',
        image = snapshot["image"] ?? "";

  toJson() {
    return {
      "ltg": ltg,
      "date": date,
      "type": type,
      "descript": descript,
      "image": image,
    };
  }
}