import 'package:doity_test/shared/models/category_model.dart';

class PartnersModel {
  final int id;
  final int order;
  final String description;
  final String url;
  final String image;
  final CategoryModel category;

  PartnersModel({
    required this.id,
    required this.order,
    required this.description,
    required this.url,
    required this.image,
    required this.category,
  });

  factory PartnersModel.fromJson(Map<String, dynamic> partner) {
    final id = partner['id'];
    final order = partner['ordem'];
    final description = partner['descricao'] ?? '';
    final url = partner['url'];
    final image = partner['imagem'];
    final category = CategoryModel.fromJson(partner['categoria']);

    return PartnersModel(
        id: id,
        order: order,
        description: description,
        url: url,
        image: image,
        category: category);
  }
}
