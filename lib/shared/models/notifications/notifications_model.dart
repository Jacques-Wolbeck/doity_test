import 'package:doity_test/shared/models/notifications/app_details_model.dart';

class NotificationsModel {
  int id;
  String message;
  int status;
  DateTime creationDate;
  String title;
  bool isUpdated;
  AppDetailsModel appDetails;

  NotificationsModel(
      {required this.id,
      required this.message,
      required this.status,
      required this.creationDate,
      required this.title,
      required this.isUpdated,
      required this.appDetails});

  factory NotificationsModel.fromJson(Map<String, dynamic> notification) {
    final id = notification['id'];
    final message = notification['mensagem'];
    final status = notification['status'];
    final creationDate = DateTime.parse(notification['created']);
    final title = notification['titulo'];
    final isUpdated = notification['atualizacao'];
    final appDetails = AppDetailsModel.fromJson(notification['app']);

    return NotificationsModel(
        id: id,
        message: message,
        status: status,
        creationDate: creationDate,
        title: title,
        isUpdated: isUpdated,
        appDetails: appDetails);
  }
}
