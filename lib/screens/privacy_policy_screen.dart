import 'package:flutter/material.dart';
import 'package:gomechanic/utils/ApiConstants.dart';
import 'package:gomechanic/utils/ColorConstants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

  bool isLoading=true;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.APP_THEME_COLOR,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          SafeArea(
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: ApiConstants.PRIVACY_POLICY,
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                },
              )
          ),
          isLoading ? Center( child: CircularProgressIndicator(),)
              : Stack(),
        ],
      ),
    );
  }
}
