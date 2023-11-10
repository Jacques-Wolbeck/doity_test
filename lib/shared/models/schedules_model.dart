import 'package:doity_test/shared/models/activity_model.dart';
import 'package:intl/intl.dart';

class SchedulesModel {
  final int id;
  final DateTime? activityDate;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? activityId;
  final ActivityModel? activity;

  SchedulesModel(
      {required this.id,
      this.activityDate,
      this.startTime,
      this.endTime,
      this.activityId,
      this.activity});

  factory SchedulesModel.fromJson(Map<String, dynamic> schedule) {
    final id = schedule['id'];
    final activityDate = DateTime.parse(schedule['data_atividade']);
    final startTime = DateTime.parse(schedule['hora_inicio']);
    final endTime = DateTime.parse(schedule['hora_fim']);
    final activityId = schedule['atividade_id'];

    final activity = schedule['atividade'] != null
        ? ActivityModel.fromJson(schedule['atividade'])
        : ActivityModel(id: -1);

    return SchedulesModel(
        id: id,
        activityDate: activityDate,
        startTime: startTime,
        endTime: endTime,
        activityId: activityId,
        activity: activity);
  }

  String getDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  String getTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }
}
