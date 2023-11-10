enum EndpointsEnum {
  speakers(
      url:
          'https://api.doity.com.br/public/aplicativos/v2/eventos/24043/palestrantes?limit=200&d_rdhid=59c654f003e03cb1f34fb921af330a24cb619c99',
      title: 'palestrantes'),
  schedules(
      url:
          'https://api.doity.com.br/public/aplicativos/v2/eventos/24043/atividades_horarios?sort=hora_inicio&direction=ASC&limit=200&d_rdhid=59c654f003e03cb1f34fb921af330a24cb619c99',
      title: 'horarios'),
  partners(
      url:
          'https://api.doity.com.br/public/aplicativos/v2/eventos/24043/parceiros?sort=ordem&direction=ASC&limit=200&d_rdhid=59c654f003e03cb1f34fb921af330a24cb619c99',
      title: 'parceiros'),
  notifications(
      url:
          'https://api.doity.com.br/public/aplicativos/v2/eventos/24043/apps/20/notificacoes?status=3&sort=id&direction=desc&limit=200&servico_id=1&d_rdhid=59c654f003e03cb1f34fb921af330a24cb619c99',
      title: 'notificacoes'),
  contents(
      url:
          'https://api.doity.com.br/public/aplicativos/v2/eventos/24043/apps/20/conteudos?ativo=1&sort=ordem&direction=asc&limit=200&d_rdhid=59c654f003e03cb1f34fb921af330a24cb619c99',
      title: 'conteudos');

  final String url;
  final String title;

  const EndpointsEnum({required this.url, required this.title});
}
