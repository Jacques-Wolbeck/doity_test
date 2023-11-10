import 'dart:async';

import 'package:doity_test/shared/models/schedules_model.dart';
import 'package:doity_test/shared/services/api_service.dart';
import 'package:doity_test/views/widgets/app_progress_indicator.dart';
import 'package:flutter/material.dart';

class SchedulesCards extends StatefulWidget {
  const SchedulesCards({super.key});

  @override
  State<SchedulesCards> createState() => _SchedulesCardsState();
}

class _SchedulesCardsState extends State<SchedulesCards> {
  final _scrollController = ScrollController();
  final _streamController = StreamController<List<dynamic>>();
  late final List<dynamic> dataList;

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
    dataList = await ApiService.instance.fetchAllSchedules();
    _streamController.add(dataList);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar os dados'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: AppProgressIndicator(),
            );
          } else {
            final schedulesList = snapshot.data as List<SchedulesModel>;
            if (schedulesList.isEmpty) {
              return const Center(child: Text('Sem programação disponível'));
            } else {
              return _schedulesListView(schedulesList, screenSize);
            }
          }
        });
  }

  Widget _schedulesListView(
      List<SchedulesModel> schedulesList, Size screenSize) {
    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true,
      radius: const Radius.circular(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: schedulesList.length,
          itemBuilder: (context, index) {
            return Card(
              child: _schedulesListTile(schedulesList[index]),
            );
          },
        ),
      ),
    );
  }

  Widget _schedulesListTile(SchedulesModel schedule) {
    return SizedBox(
      width: 300,
      child: ListTile(
        minVerticalPadding: 8.0,
        title: Text(
          schedule.activity!.name!,
          maxLines: 2,
          softWrap: true,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .merge(const TextStyle(fontWeight: FontWeight.bold)),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 8.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_on_outlined),
                const SizedBox(width: 8.0),
                Text(schedule.activity!.local!),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.calendar_month_outlined),
                const SizedBox(width: 8.0),
                Text(schedule.getDate(schedule.activityDate!)),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.schedule_outlined),
                const SizedBox(width: 8.0),
                Text(
                    '${schedule.getTime(schedule.startTime!)}h às ${schedule.getTime(schedule.endTime!)}h'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
