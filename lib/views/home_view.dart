import 'package:doity_test/views/widgets/app_title.dart';
import 'package:doity_test/views/widgets/home_widgets/contents_cards.dart';
import 'package:doity_test/views/widgets/home_widgets/partners_presentation.dart';
import 'package:doity_test/views/widgets/home_widgets/schedules_cards.dart';
import 'package:flutter/material.dart';

//Aqui é definido o esqueleto da tela incial do App, onde grande parte dos Widgets foram componetizados
//Como medida de organização do código e tbm melhora de desempenho
//Os componentes deste tela estão presentes em ../views/widgets/home_widgets/...
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
            const Flexible(flex: 3, child: SchedulesCards()),
            const SizedBox(height: 16.0),
            Flexible(
              flex: 2,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/speakers_view'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        'assets/images/speaker.png',
                        height: 35.0,
                        width: 35.0,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    const Text(
                      'Lista dos Palestrantes',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Divider(),
            const Flexible(flex: 3, child: ContentsCards()),
          ],
        ),
      ),
    );
  }
}
