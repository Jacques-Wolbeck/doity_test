class AppDetailsModel {
  int id;
  String name;
  String banner;
  String appMap;
  String theme;
  String googleAnalytics;
  bool isActive;
  bool allowNotifications;
  bool isUpdate;

  AppDetailsModel(
      {required this.id,
      required this.name,
      required this.banner,
      required this.appMap,
      required this.theme,
      required this.googleAnalytics,
      required this.isActive,
      required this.allowNotifications,
      required this.isUpdate});

  factory AppDetailsModel.fromJson(Map<String, dynamic> appDetail) {
    final id = appDetail['id'];
    final name = appDetail['nome'];
    final banner = appDetail['banner'];
    final theme = appDetail['tema'];
    final appMap = appDetail['mapa'];
    final googleAnalytics = appDetail['google_analytics'];
    final isActive = appDetail['ativo'];
    final allowNotifications = appDetail['permitir_notificacoes'];
    final isUpdate = appDetail['atualizacao'];

    return AppDetailsModel(
        id: id,
        name: name,
        banner: banner,
        appMap: appMap,
        theme: theme,
        googleAnalytics: googleAnalytics,
        isActive: isActive,
        allowNotifications: allowNotifications,
        isUpdate: isUpdate);
  }
}
