import 'package:flutter/material.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  final String title;
  const AboutUsScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
            color: AppColor.primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.primaryColor,
          ),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Introduction',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryColor,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 8.0, bottom: 10.0),
                child: Text(
                  'UNICORN CAFE is one of the Coffee Shop. Cafe is guaranteed to become the daily necessity for all the coffee addicts. A place with good ambience where people can escape from their daily stress and cherish with a morning cup of coffee. Our café offers homestyle delicious breakfast and snacks. We focus on finding the most aromatic and exotic coffee beans. We have our branches in many states of India. We have a romantic ambience which attracts youth. Our cafe has spectacular interior designs with stupendous taste of coffee. We have attached our menu which contains multi-cuisines at attractive prices.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColor.black.withOpacity(0.5),
                    fontSize: 15,
                  ),
                ),
              ),
              const Text(
                'Email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryColor,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: GestureDetector(
                  onTap: () async {
                    Uri url = Uri(
                      scheme: 'mailto',
                      path: 'unicorncafe@gmail.com',
                    );
                    if (await canLaunchUrl(url)) {
                      launchUrl(url);
                    }
                  },
                  child: Text(
                    'unicorncafe@gmail.com',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColor.blue..withOpacity(0.5),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
