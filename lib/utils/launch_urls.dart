import 'package:ConnecTen/utils/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchExternalUrl(String link) async {
  final Uri url = Uri.parse(link);
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    toastWidget("Something went wrong");
    throw 'Could not launch $url';
  }
}
