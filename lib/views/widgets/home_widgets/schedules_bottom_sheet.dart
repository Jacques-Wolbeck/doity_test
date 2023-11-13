import 'package:doity_test/shared/models/schedules_model.dart';
import 'package:doity_test/shared/utils/converters.dart';
import 'package:flutter/material.dart';

class SchedulesBottomSheet extends StatelessWidget {
  final SchedulesModel schedule;
  const SchedulesBottomSheet({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Divider(
                thickness: 4.0,
                indent: MediaQuery.of(context).size.width * 0.4,
                endIndent: MediaQuery.of(context).size.width * 0.4,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [_speakerInformation(context)],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _speakerInformation(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      child: ListTile(
        title: Text(
          schedule.activity!.name!.toUpperCase(),
          maxLines: 3,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .merge(const TextStyle(fontWeight: FontWeight.bold)),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_on_outlined),
                const SizedBox(width: 8.0),
                Expanded(child: Text(schedule.activity!.local!)),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.calendar_month_outlined),
                const SizedBox(width: 8.0),
                Expanded(child: Text(schedule.getDate(schedule.activityDate!))),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.schedule_outlined),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                      '${schedule.getTime(schedule.startTime!)}h às ${schedule.getTime(schedule.endTime!)}h'),
                ),
              ],
            ),
            const Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.description_outlined),
                const SizedBox(width: 8.0),
                Expanded(
                    child: Text(
                        convertHtmlToString(schedule.activity!.description!))),
              ],
            ),
            const Divider(),
            schedule.activity!.block!.id == -1
                ? const Text('Bloco: Não determinado')
                : Text('Bloco: ${schedule.activity!.block!.name}'),
            schedule.activity!.speakersList!.isEmpty
                ? const Text('Palestrantes: Sem palestrantes definidos')
                : Text('Palestrantes: ${schedule.activity!.speakersList}'),
          ],
        ),
      ),
    );
  }
}
