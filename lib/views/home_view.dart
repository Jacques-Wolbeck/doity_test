import 'package:doity_test/views/widgets/app_title.dart';
import 'package:doity_test/views/widgets/home_widgets/partners_presentation.dart';
import 'package:doity_test/views/widgets/home_widgets/schedules_cards.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        centerTitle: true,
        title: const AppTitle(),
      ),
      body: _body(context),
      bottomNavigationBar: const PartnersPresentation(),
    );
  }

  Widget _body(BuildContext context) {
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
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/speakers_view'),
                child: const Text(
                  'Lista dos Palestrantes',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
