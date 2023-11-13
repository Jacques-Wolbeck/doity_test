import 'package:html/parser.dart';

// Esse conversor serve para tranformar o html presente em alguns dados da API em um String sem as tags
String convertHtmlToString(String html) {
  var document = parse(html);
  return document.body!.text;
}
