import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:trady/constants/api_const/api_const.dart';
import 'package:trady/constants/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../constants/color_manger.dart';
import '../../constants/font_manager.dart';
import '../../constants/style_manager.dart';
import '../../constants/values_manger.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen(
      {Key? key})
      : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  String? reqParams;
  var loadingPercentage = 0;
  bool isLoading = false;
  final Completer<WebViewController> controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
           print("start $isLoading");

          },
          onPageFinished: (String url) {
            setState(() {
            isLoading = false;
            });
            print("end $isLoading");

          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://kite.trade/')) {
              setState(() {
                print(request.url);
                reqParams = request.url.split("request_token=").last.substring(0,32);
              });
              Navigator.pop(context,reqParams);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse("${AppAPI.loginFlowUrl}${AppAPI.apiKey}"));
    _controller = controller;
  }// Here the login flow logic is handled, https://kite.trade/docs/connect/v3/user/



  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: ColorManager.white,
              elevation: 0,
              centerTitle: false,
              leading: InkWell(
                onTap: () {
                 Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p12),
                  child: CircleAvatar(
                    backgroundColor: ColorManager.secondary.withOpacity(0.5),
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: ColorManager.black,
                    ),
                  ),
                ),
              ),
              leadingWidth: 40,
              title: Padding(
                padding: const EdgeInsets.only(left: AppPadding.p6),
                child: Text(
                  'LM APP',
                  style: getSemiBoldStyle(
                      color: ColorManager.black, fontSize: FontSize.s16),
                ),
              ),
            ),
            body: Stack(
              children: [
                WebViewWidget(
                  controller: _controller,
                ),
                isLoading ? LinearProgressIndicator(
                  value: loadingPercentage / 100.0,
                  color: ColorManager.primary,
                  backgroundColor: ColorManager.secondary,
                ):kSizedBox,
              ],
            ),
           ),
      );
   }
}