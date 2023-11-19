import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:trady/constants/app_routes.dart';
import 'package:trady/constants/constants.dart';
import 'package:trady/constants/values_manger.dart';
import 'package:trady/core/notifier/analysis/analysis.notifier.dart';
import 'package:trady/screens/auth/login_screen.dart';
import 'package:trady/screens/home/widgets/text_field_widget.dart';
import '../../constants/asset_manager.dart';
import '../../constants/color_manger.dart';
import '../../constants/font_manager.dart';
import '../../constants/style_manager.dart';
import '../../core/notifier/auth/auth_notifier.dart';
import '../../core/notifier/auth/logout_notifier.dart';
import '../../core/notifier/trade/trade_notifier.dart';
import '../../provider/theme_notifier.dart';
import '../widget/custom_button_widget.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final loginNotifier = context.read<LoginNotifier>();
    final qtyController = useTextEditingController();
    final stockController = useTextEditingController();
    final stockImage =useState<File?>(null);
    final base64Image =useState<String?>(null);
    final buyOrSell =useState<bool>(true);
    ValueNotifier<CroppedFile?> croppedFile = useState<CroppedFile?>(null);
    // ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

    /// Image Picker
    Future _pickImage(ImageSource source, BuildContext context,) async {
        try {
          final image = await ImagePicker().pickImage(source: source);
          if (image == null) return;
          CroppedFile? croppedFile = await ImageCropper().cropImage(
            sourcePath: image.path,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
            uiSettings: [
              AndroidUiSettings(
                  toolbarTitle: 'Crop Emirates Id',
                  toolbarColor: ColorManager.secondary,
                  toolbarWidgetColor: Colors.white,
                  initAspectRatio: CropAspectRatioPreset.original,
                  lockAspectRatio: false),
              IOSUiSettings(
                title: 'Crop Emirates Id',

              ),
              WebUiSettings(
                context: context,
              ),
            ],
          );
          final imageTemporary = File(croppedFile!.path);
          final imageForUpload = File(croppedFile.path).readAsBytesSync();

          base64Image.value = base64Encode(imageForUpload);
          stockImage.value = imageTemporary;


        } on PlatformException catch (e) {
          print("Failed to pick Image : $e");
        }

    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: themeNotifier.getIsLight
                      ? ColorManager.surfaceLight
                      : ColorManager.surface),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p16, vertical: AppPadding.p12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.warning,
                                      buttonsBorderRadius:
                                          const BorderRadius.all(
                                        Radius.circular(2),
                                      ),
                                      dismissOnTouchOutside: true,
                                      dismissOnBackKeyPress: false,
                                      headerAnimationLoop: false,
                                      animType: AnimType.bottomSlide,
                                      title: 'Log Out',
                                      titleTextStyle: getBoldStyle(
                                          color: themeNotifier.getIsLight
                                              ? ColorManager.primaryLight
                                              : ColorManager.primary,
                                          fontSize: AppSize.s18),
                                      descTextStyle: getSemiBoldStyle(
                                          color: themeNotifier.getIsLight
                                              ? ColorManager.black
                                              : ColorManager.white,
                                          fontSize: AppSize.s16),
                                      desc: 'Are you sure, you want to Logout',
                                      showCloseIcon: true,
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () async {
                                        // await context
                                        //     .read<LogoutNotifier>()
                                        //     .logout(context: context);
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Login() ));
                                      },
                                    ).show();
                                  },
                                  child: ClipOval(
                                    child: Container(
                                      height: 60.h,
                                      width: 60.h,
                                      padding: const EdgeInsets.all(3),
                                      color: ColorManager.white,
                                      child: ClipOval(
                                        child: Image.asset(
                                          ImageAssets.profileLogo,
                                          //   "${AppAPI.baseUrl}/files?key=${snapshot.getEntityList?.result?.profileImage ?? ""}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                kSizedW10,
                                Text(
                                  loginNotifier.getLoginResultModel?.data
                                          ?.userName ??
                                      "",
                                  style: getBoldStyle(
                                      color: ColorManager.white,
                                      fontSize: FontSize.s22),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            themeNotifier.getIsLight
                                ? GestureDetector(
                                    onTap: () => themeNotifier.setDarkMode(),
                                    child: Icon(Icons.nights_stay_rounded),
                                  )
                                : GestureDetector(
                                    onTap: () => themeNotifier.setLightMode(),
                                    child: Icon(Icons.sunny)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            kSizedBox24,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Text(
                "Analyse your Stock",
                style: getBoldStyle(
                    color: themeNotifier.getIsLight
                        ? ColorManager.primaryLight
                        : ColorManager.primary,
                    fontSize: FontSize.s22),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            kSizedBox24,

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: DottedBorder(
                  color: ColorManager.grey4,
                  strokeWidth: 2,
                  dashPattern: const [10, 9],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(24),
                  child: InkWell(
                    // onTap: ()async{
                    //   await availableCameras().then(
                    //         (value) => Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => CameraPage(cameras: value,),
                    //       ),
                    //     ),
                    //   );
                    // },
                    // onTap: () => pickFrontImage(ImageSource.gallery),
                    onTap: (){_pickImage(ImageSource.gallery,context);
                    },

                    child: Container(
                      height:160.h,
                      padding: const EdgeInsets.symmetric(
                          vertical: AppPadding.p8,
                          horizontal: AppPadding.p10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: ColorManager.secondary.withOpacity(0.2)),
                      child:  stockImage.value != null


                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child:
                        Image.file(
                          stockImage.value!,
                          fit: BoxFit.cover,
                        ),
                      )
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.upload_file,size: FontSize.s24, color: themeNotifier.getIsLight
                              ? ColorManager.primaryLight
                              : ColorManager.primary,),
                          kSizedBox16,
                          Text(
                            "Upload the the screenshot of the Stock graph in 5 mins",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                color: themeNotifier.getIsLight
                            ? ColorManager.primaryLight
                                : ColorManager.primary,),
                          ),
                          Text(
                            "Image Format: png",
                            style: getRegularStyle(
                                color: const Color(0xFF9F97A0),
                                fontSize:FontSize.s14),
                          ),
                          kSizedBox2,
                          Text(
                            "Max Size 20MB",
                            style: getRegularStyle(
                                color: const Color(0xFF9F97A0),
                                fontSize:FontSize.s14),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            kSizedBox24,
            Row(
              children: [
                Expanded(
                  child: TextFormFieldCustom(
                    controller: qtyController,
                    hintName: "Quantity",
                    inputType: TextInputType.number,
                    icon: Icons.candlestick_chart_rounded,
                  ),
                ),
                Expanded(
                  child: TextFormFieldCustom(
                    controller: stockController,
                    hintName: "Symbol",
                    icon: Icons.bar_chart,
                  ),
                ),
              ],
            ),
            kSizedBox10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Switch(
                  // This bool value toggles the switch.
                  value: buyOrSell.value,
                  activeColor: ColorManager.green,
                  inactiveThumbColor: ColorManager.red,
                  onChanged: (bool value) {
                    buyOrSell.value = !buyOrSell.value;
                  },
                ),
              ),
            ),
            kSizedBox24,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<AnalysisNotifier>(
                    builder: (context, snapshot,_) {
                      return snapshot.getIsLoading ? const CircularProgressIndicator() : CustomButton(
                        onTap: () async {
                          if(base64Image.value != null){
                            snapshot.analysisNotifier(base64Image: base64Image.value!, context: context);
                          }else{
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              buttonsBorderRadius:
                              const BorderRadius.all(
                                Radius.circular(2),
                              ),
                              dismissOnTouchOutside: true,
                              dismissOnBackKeyPress: false,
                              headerAnimationLoop: false,
                              animType: AnimType.bottomSlide,
                              title: 'Error',
                              titleTextStyle: getBoldStyle(
                                  color: themeNotifier.getIsLight
                                      ? ColorManager.primaryLight
                                      : ColorManager.primary,
                                  fontSize: AppSize.s18),
                              descTextStyle: getSemiBoldStyle(
                                  color: themeNotifier.getIsLight
                                      ? ColorManager.black
                                      : ColorManager.white,
                                  fontSize: AppSize.s16),
                              desc: 'Please add an image to Analyse',
                              // showCloseIcon: true,
                              // btnCancelOnPress: () {},
                            ).show();

                          }
                        },
                        width: 120.w,
                        text: "Analysis",
                        isLight: themeNotifier.getIsLight,
                      );
                    }
                ),
                kSizedW15,
                Consumer<TradeNotifier>(
                  builder: (context, snapshot,_) {
                    return snapshot.getIsLoading ? const CircularProgressIndicator() : CustomButton(
                  onTap: () async {
                snapshot.tradeNotifier(context: context, tradingSymbol: stockController.text.toUpperCase(), exchange: "NSE", transactionType: buyOrSell.value ? "BUY":"SELL", orderType: "MARKET", quantity:qtyController.text , product: "MIS", validity: "DAY");
                  },
                  width: 120.w,
                  text: "Trade",
                  isLight: themeNotifier.getIsLight,
                );
                  }
                ),
              ],
            ),
            kSizedBox24,
          ],
        ),
      ),
    );
  }
}
