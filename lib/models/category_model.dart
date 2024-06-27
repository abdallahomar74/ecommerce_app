class CategoryModel {
  String? title;
  String? url;
  int? id;

  CategoryModel.fromJson({required Map<String, dynamic> data}) {
    title = data["name"];
    url = data["image"];
    id = data["id"];
  }
}
