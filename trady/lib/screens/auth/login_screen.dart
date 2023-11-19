import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:trady/constants/app_routes.dart';
import 'package:trady/constants/constants.dart';
import 'package:trady/constants/string_manager.dart';
import 'package:trady/constants/style_manager.dart';
import 'package:trady/constants/values_manger.dart';
import 'package:trady/core/service/shared_preferance_service.dart';
import 'package:trady/screens/auth/web_view_login_screen.dart';
import '../../constants/asset_manager.dart';
import '../../constants/color_manger.dart';
import '../../core/notifier/auth/auth_notifier.dart';

class Login extends HookWidget {
  const Login({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    ValueNotifier<String?> requestCode = useState<String?>(null);
    ValueNotifier<bool> isLoading = useState<bool>(false);
    final loginNotifier = context.read<LoginNotifier>();
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  <Widget>[
                        kSizedBox20,
                        Center(
                          child: DottedBorder(
                            dashPattern: const [6, 3, 2, 3],
                            borderType: BorderType.RRect,
                            radius: Radius.circular(80),
                            padding: EdgeInsets.all(8.h),
                            color: Colors.grey,
                            strokeWidth: 2,
                            child: CircleAvatar(
                              radius: 50.h,
                              backgroundImage: AssetImage(ImageAssets.login),

                            ),
                          ),
                        ),
                      kSizedBox71,
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Log in",style: getSemiBoldStyle(color: ColorManager.grey4,fontSize: AppSize.s20),)),
                      kSizedBox25,
                      InkWell(
                        onTap: ()async{
                          Navigator.pushReplacementNamed(context, homeRoute);
                         //  isLoading.value = true;
                         // requestCode.value = await Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen())) as String?;
                         //  await loginNotifier.getLogin(context: context,token: requestCode.value ?? "");
                         //  isLoading.value = false;
                        },
                        child: Container(
                          // padding: EdgeInsets.symmetric(horizontal: AppPadding.p16,vertical: AppPadding.p10),
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorManager.grey5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Image.asset(ImageAssets.kiteLogo),
                              kSizedW15,
                              Text("Log in with Kite Connect",style: getSemiBoldStyle(color: ColorManager.grey4),)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Positioned.fill(
                      child: Align(
                        child: isLoading.value ? Container(
                          child: CircularProgressIndicator(),
                        ): kSizedBox
                      ) )

                ],
              ),
            ),
          ),
        )
    );
  }
}
