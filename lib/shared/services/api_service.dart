import 'package:doity_test/shared/models/contents_model.dart';
import 'package:doity_test/shared/models/enums/endpoints_enum.dart';
import 'package:doity_test/shared/models/notifications/notifications_model.dart';
import 'package:doity_test/shared/models/partners_model.dart';
import 'package:doity_test/shared/models/schedules_model.dart';
import 'package:doity_test/shared/models/speakers_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  //Instância utlizando o padrão Singleton para a classe ApiService
  static final ApiService instance = ApiService._init();
  ApiService._init();

  //Busca dados da API para cada endpoint e os converte em uma lista do tipo especificado.
  Future<List<T>> _fetchData<T>(
      EndpointsEnum dataType, T Function(Map<String, dynamic>) fromJson) async {
    var url = Uri.parse(dataType.url);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final list = List<T>.from(jsonResponse[dataType.title]
            .map((value) => fromJson(value as Map<String, dynamic>)));
        return list;
      }
      return [];
    } catch (error) {
      debugPrint('Error accessing ${dataType.title}: $error');
      throw Exception(error);
    }
  }

  Future<List<SpeakersModel>> fetchAllSpeakers() async => _fetchData(
      EndpointsEnum.speakers, (value) => SpeakersModel.fromJson(value));

  Future<List<SchedulesModel>> fetchAllSchedules() async => _fetchData(
      EndpointsEnum.schedules, (value) => SchedulesModel.fromJson(value));

  Future<List<PartnersModel>> fetchAllPartners() async => _fetchData(
      EndpointsEnum.partners, (value) => PartnersModel.fromJson(value));

  Future<List<NotificationsModel>> fetchAllNotifications() async => _fetchData(
      EndpointsEnum.notifications,
      (value) => NotificationsModel.fromJson(value));

  Future<List<ContentsModel>> fetchAllContents() async => _fetchData(
      EndpointsEnum.contents, (value) => ContentsModel.fromJson(value));
}
