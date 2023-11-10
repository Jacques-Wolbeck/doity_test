import 'dart:async';

import 'package:doity_test/shared/models/partners_model.dart';
import 'package:doity_test/shared/services/api_service.dart';
import 'package:doity_test/views/widgets/app_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PartnersPresentation extends StatefulWidget {
  const PartnersPresentation({super.key});

  @override
  State<PartnersPresentation> createState() => _PartnersPresentationState();
}

class _PartnersPresentationState extends State<PartnersPresentation> {
  late final List<dynamic> dataList;
  final _streamController = StreamController<List<dynamic>>();

  final _pageController = PageController(initialPage: 0);
  late Timer timer;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
    _pageController.dispose();
    timer.cancel();
  }

  _loadData() async {
    dataList = await ApiService.instance.fetchAllPartners();
    timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (currentPage < dataList.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    });
    _streamController.add(dataList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .1,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8.0),
          topLeft: Radius.circular(8.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Parceiros:',
            style: Theme.of(context).textTheme.titleMedium!.merge(TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8.0),
          StreamBuilder(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Erro ao carregar os parceiros'),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: AppProgressIndicator(),
                  );
                } else {
                  final partnersList = snapshot.data as List<PartnersModel>;
                  if (partnersList.isEmpty) {
                    return const Center(child: Text('Sem Parceiros'));
                  } else {
                    return _partnersPageView(partnersList);
                  }
                }
              }),
        ],
      ),
    );
  }

  Widget _partnersPageView(List<PartnersModel> partnersList) {
    return SizedBox(
      height: 50.0,
      width: 50.0,
      child: PageView.builder(
        controller: _pageController,
        itemCount: partnersList.length,
        itemBuilder: (context, index) {
          var partner = partnersList[index];
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: InkWell(
              onTap: () async => _openUrl(),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(partner.image)),
            ),
          );
        },
      ),
    );
  }

  void _openUrl() async {
    const url = 'https://docs.flutter.dev';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
