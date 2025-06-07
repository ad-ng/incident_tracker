import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String appName = '';
  String packageName = '';
  String version = '';
  String buildNumber = '';

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      appName = info.appName;
      packageName = info.packageName;
      version = info.version;
      buildNumber = info.buildNumber;
    });
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'App Name: $appName',
            style: TextStyle(color: Colors.blue, fontSize: 18),
          ),
        ),
        Center(
          child: Text(
            'Version: $version',
            style: TextStyle(color: Colors.blue, fontSize: 18),
          ),
        ),
        Center(
          child: Text(
            'Build Number: $buildNumber',
            style: TextStyle(color: Colors.blue, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
