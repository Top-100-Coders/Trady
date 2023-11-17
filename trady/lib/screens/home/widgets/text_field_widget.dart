import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


import '../../../constants/color_manger.dart';
import '../../../constants/style_manager.dart';
import '../../../constants/values_manger.dart';
import '../../../provider/theme_notifier.dart';

class TextFormFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String? hintName;
  final IconData? icon;
  final bool isObscureText;
  final int? maxLength,maxLine;
  final TextInputType inputType;
  final bool isEnable, isEditable, isReadOnly;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final void Function()? onTap;
  final double paddingWidth;


  const TextFormFieldCustom(
      {required this.controller,
        this.hintName,
        this.icon,
        this.onChanged,
        this.validator,
        this.isEditable = true,
        this.maxLength,
        this.maxLine,
        this.inputFormatters,
        this.isObscureText = false,
        this.inputType = TextInputType.text,
        this.isEnable = true,
        this.onTap,
        this.isReadOnly = false,
        this.paddingWidth = AppPadding.p20,

        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Container(
        padding:  EdgeInsets.symmetric(horizontal: paddingWidth),
        child: TextFormField(
            controller: controller,
            obscureText: isObscureText,
            readOnly: isReadOnly,
            onTap: onTap,
            enabled: isEnable,
            style: getSemiBoldStyle(color:themeNotifier.getIsLight ?  ColorManager.black : ColorManager.white),
            keyboardType: inputType,
            inputFormatters: inputFormatters,
            validator: validator ??
                    (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter $hintName';
                  }
                  return null;
                },
            onChanged:  onChanged,
            maxLines: maxLine,
            autocorrect: isEditable,
            enableSuggestions: isEditable,
            enableInteractiveSelection: isEditable,
            maxLength: maxLength,
            decoration: InputDecoration(

              floatingLabelStyle: getSemiBoldStyle(color:themeNotifier.getIsLight ? ColorManager.primaryLight : ColorManager.primary),
              enabledBorder: OutlineInputBorder(
                borderRadius:const BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color:themeNotifier.getIsLight ?ColorManager.primaryLight :ColorManager.primary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:const  BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: themeNotifier.getIsLight ?ColorManager.primaryLight :ColorManager.grey5),
              ),
              prefixIcon: Icon(
                icon,
                color:themeNotifier.getIsLight ? ColorManager.primaryLight : ColorManager.secondary,
              ),

              // hintText: hintName,
              labelText: hintName,
              labelStyle: getBoldStyle(color:themeNotifier.getIsLight ?  ColorManager.primaryLight : ColorManager.primary),
              fillColor:themeNotifier.getIsLight ? ColorManager.grey5 :ColorManager.surface,
              filled: true,
            ),
         ),
  );
}
}