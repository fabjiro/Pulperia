class ProductSpecific {
  String idm;
  String title;
  String imagen;
  String urlimage;
  String idgeneral;

  ProductSpecific({
    required this.idm,
    required this.title,
    required this.imagen,
    required this.idgeneral,
    required this.urlimage,
  });

  ProductSpecific.fromMap(Map<String, dynamic> res)
      : idm = res["id"],
        title = res["title"],
        imagen = res['imagen'],
        idgeneral = res['idgeneral'],
        urlimage = res['urlimage'];

  Map<String, Object?> toMap() {
    return {
      'id': idm,
      'title': title,
      'imagen': imagen,
      'idgeneral': idgeneral,
      'urlimage': urlimage,
    };
  }
}
