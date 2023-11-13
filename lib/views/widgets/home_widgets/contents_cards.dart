import 'dart:async';

import 'package:doity_test/shared/models/contents_model.dart';
import 'package:doity_test/shared/services/api_service.dart';
import 'package:doity_test/views/widgets/app_progress_indicator.dart';
import 'package:flutter/material.dart';

class ContentsCards extends StatefulWidget {
  const ContentsCards({super.key});

  @override
  State<ContentsCards> createState() => _ContentsCardsState();
}

class _ContentsCardsState extends State<ContentsCards> {
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
    dataList = await ApiService.instance.fetchAllContents();
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
            final contentsList = snapshot.data as List<ContentsModel>;
            if (contentsList.isEmpty) {
              return const Center(child: Text('Sem conteúdo disponível'));
            } else {
              return _contentsListView(contentsList, screenSize);
            }
          }
        });
  }

  Widget _contentsListView(List<ContentsModel> contentsList, Size screenSize) {
    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true,
      radius: const Radius.circular(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: contentsList.length,
          itemBuilder: (context, index) {
            return _contentsCards(contentsList[index]);
          },
        ),
      ),
    );
  }

  Widget _contentsCards(ContentsModel content) {
    return Card(
      child: InkWell(
        onTap: () => _contentsAlertDialog(content),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 200.0,
              height: 100.0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.network(
                  content.appDetails.banner,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              content.appDetails.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(content.title)
          ],
        ),
      ),
    );
  }

  void _contentsAlertDialog(ContentsModel content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.map_outlined,
                size: 30.0,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Text(
                'Mapa',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ],
          ),
          content: Image.network(
            content.appDetails.appMap,
            width: 200,
            height: 150,
            fit: BoxFit.fill,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const SizedBox(
                width: 200,
                height: 150,
                child: Center(child: AppProgressIndicator()),
              );
            },
            errorBuilder: ((context, error, stackTrace) {
              return const Icon(Icons.error);
            }),
          ),
          actions: [
            ElevatedButton(
              child: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
