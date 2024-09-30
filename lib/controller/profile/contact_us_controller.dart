import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsController extends GetxController {
  Future<void> urlLuncher(
    String name,
  ) async {
    if (name == "sms") {
      final Uri url = Uri.parse('sms:+965 6576 6660');
      if (!await launchUrl(url)) {
        throw "can't launch $url";
      }
    } else if (name == "phone") {
      final Uri url = Uri.parse('tel:+965 6576 6660');
      if (!await launchUrl(url)) {
        throw "can't launch $url";
      }
    } else if (name == "watsappNormal") {
      final Uri url = Uri.parse('whatsapp://send?phone=+965 6576 6660');
      if (!await launchUrl(url)) {
        throw "can't launch $url";
      }
    } else if (name == "watsappWorks") {
      final Uri url = Uri.parse('whatsapp://send?phone=+965 6576 6660');
      if (!await launchUrl(url)) {
        throw "can't launch $url";
      }
    } else if (name == "facebook") {
      final Uri url = Uri.parse(
          'https://www.facebook.com/profile.php?id=61565047828243&mibextid=LQQJ4d');
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
      final Uri url = Uri.parse('https://x.com/masaapp9?t=4CZYrU4IX-_99TrJ1L4ovw&s=08');

      if (!await launchUrl(url)) {
        throw "can't launch $url";
      }
    } else if (name == "linkedin") {
      final Uri url = Uri.parse('');

      if (!await launchUrl(url)) {
        throw "can't launch $url";
      }
    } else if (name == "tiktok") {
      final Uri url = Uri.parse('');

      if (!await launchUrl(url)) {
        throw "can't launch $url";
      }
    } else if (name == "youtup") {
      final Uri url = Uri.parse('');

      if (!await launchUrl(url)) {
        throw "can't launch $url";
      }
    } else if (name == "gmail") {
      final Uri url = Uri.parse(
          'mailto:online.almasyaa@gmail.com?subject=News&body=New plugin');

      if (!await launchUrl(url)) {
        throw "can't launch $url";
      }
    }
  }
}
