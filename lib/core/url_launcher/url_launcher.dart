import 'package:url_launcher/url_launcher.dart';

import 'url_repository.dart';

class UrlLauncherImpl implements UrlRepository{
  @override
  Future<void> openUrl(String url) async {
    final parsedUrl = Uri.parse(url);
    await launchUrl(parsedUrl,mode: LaunchMode.externalApplication);
  }

  @override
  Future<bool> canParseUrl(String url) async {
    if(Uri.tryParse(url)==null){
      return false;
    }

    final parsedUrl = Uri.parse(url);
    return await canLaunchUrl(parsedUrl);

  }

}