import 'package:doity_test/shared/models/speakers_model.dart';
import 'package:doity_test/views/widgets/app_progress_indicator.dart';
import 'package:flutter/material.dart';

import '../../../shared/utils/converters.dart';

class SpeakersBottomSheet extends StatelessWidget {
  final SpeakersModel speaker;
  const SpeakersBottomSheet({super.key, required this.speaker});

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _speakerImage(),
                  const SizedBox(width: 4.0),
                  _speakerInformation(context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _speakerImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      child: Image.network(
        speaker.image!,
        height: 220,
        width: 150,
        fit: BoxFit.fill,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const SizedBox(
            height: 220,
            width: 150,
            child: Center(child: AppProgressIndicator()),
          );
        },
        errorBuilder: ((context, error, stackTrace) {
          return const Icon(Icons.error);
        }),
      ),
    );
  }

  Widget _speakerInformation(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .5,
      child: ListTile(
        minVerticalPadding: 0,
        title: Text(
          speaker.name!,
          softWrap: true,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .merge(const TextStyle(fontWeight: FontWeight.bold)),
        ),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/company.png',
                    height: 25.0,
                    width: 25.0,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      speaker.company!,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.description_outlined),
                  const SizedBox(width: 8.0),
                  Expanded(
                      child: Text(convertHtmlToString(speaker.description!))),
                ],
              ),
              const Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.subject_outlined),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      speaker.activities!.map((e) => e.name).toString(),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
