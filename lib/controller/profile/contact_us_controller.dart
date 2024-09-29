import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsController extends GetxController{

 Future<void> urlLuncher(
    String name,
  ) async {
    if (name == "sms") {
      final Uri url = Uri.parse('sms:');
      if (!await launchUrl(url)) {
        throw "can't launch $url";
      }
    } else if (name == "phone") {
      final Uri url = Uri.parse('tel:');
      if (!await launchUrl(url)) {
        throw "can't launch $url";
      }
    } else if (name == "watsappNormal") {
      final Uri url =
          Uri.parse('whatsapp://send?phone=');
      if (!await launchUrl(url)) {
        throw "can't launch $url";
      }
    } else if (name == "watsappWorks") {
      final Uri url =
          Uri.parse('whatsapp://send?phone=');
      if (!await launchUrl(url)) {
        throw "can't launch $url";
      }
    } else if (name == "facebook") {
      final Uri url = Uri.parse(
          'https://m.facebook.com/whiteEagleEventCompany?mibextid=LQQJ4d');
      if (!await launchUrl(url)) {
        throw "can't launch $url";
      }
    } else if (name == "instagram") {
      final Uri url = Uri.parse(
          'https://www.instagram.com/masapp60?igsh=MTc4aXphaDQyeGRnaw==');

      if (!await launchUrl(url)) {
        throw "can't launch $url";
      }
    } else if (name == "twitter") {
      final Uri url = Uri.parse('https://www.threads.net/@whiteeagle_event');

      if (!await launchUrl(url)) {
        throw "can't launch $url";
      }
    } else if (name == "linkedin") {
      final Uri url = Uri.parse(
          'https://www.linkedin.com/company/white-eagle-event-company/');

      if (!await launchUrl(url)) {
        throw "can't launch $url";
      }
    } else if (name == "tiktok") {
      final Uri url = Uri.parse(
          'https://www.tiktok.com/@whiteeagleevent?_t=8lDZLVLCod8&_r=1');

      if (!await launchUrl(url)) {
        throw "can't launch $url";
      }
    } else if (name == "youtup") {
      final Uri url = Uri.parse(
          '');

      if (!await launchUrl(url)) {
        throw "can't launch $url";
      }
    }else if (name == "gmail") {
      
      final Uri url = Uri.parse(
          'mailto:?subject=News&body=New plugin');

      if (!await launchUrl(url)) {
        throw "can't launch $url";
      }
    }
  }

  
} 