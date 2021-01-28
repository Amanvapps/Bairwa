import 'package:flutter/material.dart';
import 'package:gomechanic/utils/ApiConstants.dart';
import 'package:gomechanic/utils/ColorConstants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreenRequestEng extends StatefulWidget {

  var query;
  PaymentScreenRequestEng(this.query);

  @override
  _PaymentScreenRequestEngState createState() => _PaymentScreenRequestEngState();
}

class _PaymentScreenRequestEngState extends State<PaymentScreenRequestEng> {

  var headingTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 22
  );

  bool isLoading=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Center(child: Text('Payment' , style: headingTextStyle,)),
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
                initialUrl: ApiConstants.URL + ApiConstants.PAY_REQUEST_ENGINEER + "?" + widget.query,
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
