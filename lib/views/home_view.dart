import 'dart:async';

import 'package:doity_test/shared/models/speakers_model.dart';
import 'package:doity_test/shared/services/api_service.dart';
import 'package:doity_test/views/widgets/app_progress_indicator.dart';
import 'package:doity_test/views/widgets/app_title.dart';
import 'package:doity_test/views/widgets/home/partners_presentation.dart';
import 'package:doity_test/views/widgets/home/schedules_cards.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final List<dynamic> dataList;
  final _streamController = StreamController<List<dynamic>>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  _loadData() async {
    /*dataList = await ApiService.instance
        .fetchAll<SchedulesModel>(EndpointsEnum.schedules);*/
    //dataList = await ApiService.instance.fetchAllContents();
    //dataList = await ApiService.instance.fetchAllNotifications();
    //dataList = await ApiService.instance.fetchAllPartners();
    dataList = await ApiService.instance.fetchAllSpeakers();
    //dataList = await ApiService.instance.fetchAllSchedules();
    _streamController.add(dataList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        centerTitle: true,
        title: const AppTitle(),
      ),
      body: _body(),
      bottomNavigationBar: const PartnersPresentation(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Grade de Programação',
              style: Theme.of(context).textTheme.titleMedium!.merge(TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold)),
            ),
            const Flexible(flex: 1, child: SchedulesCards()),
            const Divider(),
            Flexible(
              flex: 2,
              child: StreamBuilder(
                  stream: _streamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Erro!!'),
                      );
                    }
                    if (!snapshot.hasData) {
                      return const Center(
                        child: AppProgressIndicator(),
                      );
                    } else {
                      final speakers = snapshot.data as List<SpeakersModel>;
                      debugPrint('---------> SIZE: ${speakers.length}');
                      return ListView.builder(
                          itemCount: speakers.length,
                          itemBuilder: (context, index) {
                            var speaker = speakers[index];

                            return ListTile(
                              title: Text(speaker.company!),
                              subtitle: Text(speaker.order.toString()),
                            );
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
