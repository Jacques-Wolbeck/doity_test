import 'dart:async';

import 'package:doity_test/shared/models/speakers_model.dart';
import 'package:doity_test/shared/services/api_service.dart';
import 'package:doity_test/views/widgets/app_progress_indicator.dart';
import 'package:doity_test/views/widgets/speakers_widgets/search_field.dart';
import 'package:doity_test/views/widgets/speakers_widgets/speakers_bottom_sheet.dart';
import 'package:flutter/material.dart';

class SpeakersView extends StatefulWidget {
  const SpeakersView({super.key});

  @override
  State<SpeakersView> createState() => _SpeakersViewState();
}

class _SpeakersViewState extends State<SpeakersView> {
  late final List<dynamic> dataList;
  final _streamController = StreamController<List<dynamic>>();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
    _searchController.dispose();
  }

  _loadData() async {
    dataList = await ApiService.instance.fetchAllSpeakers();
    _streamController.add(dataList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        centerTitle: true,
        title: const Text('Palestrantes'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchField(controller: _searchController),
            const SizedBox(height: 16.0),
            Expanded(
              child: StreamBuilder(
                  stream: _streamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child:
                            Text('Não foi possível carregar os palestrantes'),
                      );
                    }
                    if (!snapshot.hasData) {
                      return const Center(
                        child: AppProgressIndicator(),
                      );
                    } else {
                      final speakers = snapshot.data as List<SpeakersModel>;
                      debugPrint('---------> SIZE: ${speakers.length}');
                      return _showData(speakers);
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showData(List<SpeakersModel> speakers) {
    if (_searchController.text.isNotEmpty) {
      speakers = _searchData(speakers);
    }
    if (speakers.isEmpty) {
      return const Center(
        child: Text(
          "Não há palestrantes",
        ),
      );
    }
    return ListView.builder(
        itemCount: speakers.length,
        itemBuilder: (context, index) {
          var speaker = speakers[index];
          return _speakersCard(speaker);
        });
  }

  List<SpeakersModel> _searchData(List<SpeakersModel> speakers) {
    final List<SpeakersModel> searchResult = [];
    for (var speaker in speakers) {
      if (speaker.name!
          .toLowerCase()
          .contains(_searchController.text.toLowerCase())) {
        searchResult.add(speaker);
      }
    }
    return searchResult;
  }

  Widget _speakersCard(SpeakersModel speaker) {
    return SizedBox(
      height: 80,
      child: Card(
        child: Material(
          borderRadius: BorderRadius.circular(8.0),
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  isDismissible: false,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0)),
                  ),
                  builder: (context) {
                    return SpeakersBottomSheet(speaker: speaker);
                  });
            },
            child: ListTile(
              title: Text(speaker.name!),
            ),
          ),
        ),
      ),
    );
  }
}
