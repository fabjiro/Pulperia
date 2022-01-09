class ProductGeneral {
  String idm;
  String title;

  ProductGeneral({
    required this.idm,
    required this.title,
  });

  ProductGeneral.fromMap(Map<String, dynamic> res)
      : idm = res["id"],
        title = res["title"];

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'id': idm,
    };
  }
}
