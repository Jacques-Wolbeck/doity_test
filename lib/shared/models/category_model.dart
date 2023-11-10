class CategoryModel {
  int id;
  int order;
  String description;
  bool showEventSite;
  bool showDoityPlay;

  CategoryModel({
    required this.id,
    required this.order,
    required this.description,
    required this.showEventSite,
    required this.showDoityPlay,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> category) {
    final id = category['id'];
    final order = category['ordem'];
    final description = category['descricao'];
    final showEventSite = category['mostrar_site_evento'];
    final showDoityPlay = category['mostrar_doity_play'];

    return CategoryModel(
        id: id,
        order: order,
        description: description,
        showEventSite: showEventSite,
        showDoityPlay: showDoityPlay);
  }
}
