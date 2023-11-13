import 'package:doity_test/shared/models/block_model.dart';
import 'package:doity_test/shared/models/schedules_model.dart';
import 'package:doity_test/shared/models/speakers_model.dart';

class ActivityModel {
  final int id;
  final String? name;
  final String? description;
  final String? local;
  final BlockModel? block;
  final String? speakersList;
  final List<SchedulesModel>? schedules;
  final List<SpeakersModel>? speakers;

  ActivityModel(
      {required this.id,
      this.name,
      this.description,
      this.block,
      this.local,
      this.schedules,
      this.speakers,
      this.speakersList});

  // Cria uma nova instância da classe ActivityModel a partir de um objeto JSON.
  //Todos os outros 'models' seguem este padrão
  factory ActivityModel.fromJson(Map<String, dynamic> activity) {
    final id = activity['id'];
    final name = activity['nome'];
    final description = activity['descricao'];
    final block = BlockModel.fromJson(activity['bloco']);
    final local = activity['local'];

    final schedules = activity['horarios'] != null
        ? List<SchedulesModel>.from(
            activity['horarios'].map((data) => SchedulesModel.fromJson(data)))
        : [SchedulesModel(id: -1)];

    final speakersList = activity['lista_palestrantes'] ?? '';
    final speakers = activity['palestrantes'] != null
        ? List<SpeakersModel>.from(activity['palestrantes']
            .map((data) => SpeakersModel.fromJson(data)))
        : [SpeakersModel(id: -1)];

    return ActivityModel(
        id: id,
        name: name,
        description: description,
        block: block,
        local: local,
        speakersList: speakersList,
        schedules: schedules,
        speakers: speakers);
  }
}
