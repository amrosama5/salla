import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import '../../models/onBoarding_model.dart';


Widget buildOnBoardItem(OnBoardingModel model) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Lottie.network(model.image),
    const SizedBox(height: 35,),
    Text(
      model.title,
      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
    const SizedBox(height: 15,),
    Text(
      model.subTitle,
      style: const TextStyle(
        fontSize: 15,
      ),
    )
  ],
);

Future navigatorPushAndRemove({required context,required Widget widget}) {
  return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Future navigatTo({required context,required Widget widget}) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

class CustomFormField extends StatelessWidget {
  CustomFormField({
    required this.labelText,
    this.prefixIcon,
    this.keyboardType,
    this.onSubmitted,
    this.onChanged,
    this.obscureText=false,
    this.hintText,
    this.suffixIcon,
    this.borderRadius = const BorderRadius.all(Radius.circular(5)),
    this.key,
    this.validator,
    this.controller,
    this.padding,
    this.suffixStyle,
    this.prefixStyle,
    this.labelStyle,
    this.hintStyle,
    this.paddingOutForm
  });


  String labelText;
  String? hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextInputType? keyboardType;
  ValueChanged<String>? onSubmitted;
  ValueChanged<String>? onChanged;
  String? Function(String ?)? validator;
  bool obscureText;
  BorderRadius borderRadius ;
  Key? key;
  TextEditingController? controller;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? paddingOutForm;
  TextStyle? labelStyle;
  TextStyle? hintStyle;
  TextStyle? suffixStyle;
  TextStyle? prefixStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingOutForm!,
      child: TextFormField(
        key: key,
        controller: controller,
        onFieldSubmitted: onSubmitted,
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        decoration:  InputDecoration(
          labelStyle: labelStyle,
          hintStyle: hintStyle,
          suffixStyle: suffixStyle,
          prefixStyle: prefixStyle,
          contentPadding: padding,
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
              borderRadius: borderRadius
          ),
        ),

      ),
    );
  }
}

class CustomMaterialButton extends StatelessWidget {
  CustomMaterialButton({
    this.color,
    this.width= double.infinity,
    this.height = 54,
    required this.text,
    required this.onPressed,
    this.borderRadius,
    this.textStyle,
    this.shape,
    this.widget
  }) ;

  Color? color;
  double width;
  double height;
  String text;
  BorderRadiusGeometry? borderRadius;
  TextStyle? textStyle;
  ShapeBorder? shape;
  Widget? widget;
  void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
      ),
      width: width,
      child: MaterialButton(
          onPressed: onPressed,
          height: height,
          shape: shape,
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              widget!,
              Text(text,style:textStyle),
            ],
          )
      ),
    );
  }
}


Future<bool?> showToast({required String msg,required Color color}){
  return  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
