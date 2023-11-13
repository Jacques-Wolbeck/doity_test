import 'package:doity_test/shared/models/notifications/app_details_model.dart';

class ContentsModel {
  final int id;
  final String title;
  final String text;
  final AppDetailsModel appDetails;

  ContentsModel(
      {required this.id,
      required this.title,
      required this.text,
      required this.appDetails});

  factory ContentsModel.fromJson(Map<String, dynamic> content) {
    final id = content['id'];
    final title = content['titulo'];
    final text = content['texto'];
    final appDetails = AppDetailsModel.fromJson(content['app']);

    return ContentsModel(
        id: id, title: title, text: text, appDetails: appDetails);
  }
}
