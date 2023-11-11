import 'package:doity_test/shared/models/speakers_model.dart';
import 'package:doity_test/views/widgets/app_progress_indicator.dart';
import 'package:flutter/material.dart';

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
                children: [
                  _speakerImage(),
                  const SizedBox(width: 8.0),
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
        height: 200,
        width: 150,
        fit: BoxFit.fill,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const SizedBox(
            width: 70.0,
            height: 70.0,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: AppProgressIndicator(),
            ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            speaker.name!,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .merge(TextStyle(fontWeight: FontWeight.bold)),
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/company.png',
                height: 25.0,
                width: 25.0,
              ),
              Text(speaker.company!),
            ],
          ),
          Text(
            speaker.description!,
            softWrap: true,
          )
        ],
      ),
    );
  }
}
