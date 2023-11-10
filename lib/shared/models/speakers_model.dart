import 'package:doity_test/shared/models/activity_model.dart';

class SpeakersModel {
  final int id;
  final String? name;
  final String? company;
  final String? description;
  final String? image;
  final int? order;
  final List<ActivityModel>? activities;

  SpeakersModel(
      {required this.id,
      this.name,
      this.description,
      this.company,
      this.image,
      this.order,
      this.activities});

  factory SpeakersModel.fromJson(Map<String, dynamic> speaker) {
    final id = speaker['id'];
    final name = speaker['nome'];
    final description = speaker['descricao'];
    final company = speaker['empresa'];
    final image = speaker['imagem'];
    final order = speaker['ordem'];

    final activities = speaker['atividades'] != null
        ? List<ActivityModel>.from(
            speaker['atividades'].map((data) => ActivityModel.fromJson(data)))
        : [ActivityModel(id: -1)];

    return SpeakersModel(
      id: id,
      name: name,
      description: description,
      company: company,
      image: image,
      order: order,
      activities: activities,
    );
  }
}
