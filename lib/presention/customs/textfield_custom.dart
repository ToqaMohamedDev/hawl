import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final IconData iconData;
  final String hint;
  final Function? function;
  final TextInputType? textInputType;

  const CustomTextField({
    super.key,
    required this.iconData,
    required this.controller,
    required this.hint,
    this.function,
    this.textInputType,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false; // حالة إظهار كلمة المرور

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 370,
        child: TextFormField(
          validator: (val) {
            if (widget.hint == "البريد الإلكتروني") {
              if (val!.isEmpty) {
                return "من فضلك أدخل البريد الإلكتروني";
              } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(val)) {
                return "البريد الإلكتروني غير صحيح";
              }
            } else if (val!.isEmpty && widget.hint == "كلمة المرور") {
              return "من فضلك أدخل كلمة المرور";
            } else if (val.length < 6 && widget.hint == "كلمة المرور") {
              return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
            } else if (val.isEmpty && widget.hint == "تأكيد كلمة المرور") {
              return "من فضلك أدخل تأكيد كلمة المرور";
            } else if (val.length < 6 && widget.hint == "تأكيد كلمة المرور") {
              return "تأكيد كلمة المرور يجب أن يكون 6 أحرف على الأقل";
            } else if (val.isEmpty && widget.hint == "الاسم") {
              return "من فضلك أدخل اسمك";
            }
            return null;
          },
          obscureText: widget.hint == "كلمة المرور" ? !_isPasswordVisible : false,
          keyboardType: widget.textInputType ?? TextInputType.text,
          controller: widget.controller,
          onChanged: (val) => widget.function?.call(val),
          cursorColor: Colors.black, // جعل لون الكروسر أسود
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: Colors.black54, // اللون الثانوي يكون داكن قليلاً
            ),
            isDense: true,
            prefixIcon: Icon(widget.iconData, color: Colors.black54), // الأيقونة تكون بلون داكن
            contentPadding: const EdgeInsets.all(10),
            suffixIcon: widget.hint == "كلمة المرور"
                ? IconButton(
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.black54, // الأيقونة باللون الداكن
              ),
            )
                : null,
            border: _widgetOutlineBorder(context),
            focusedBorder: _widgetOutlineBorder(context),
            enabledBorder: _widgetOutlineBorder(context),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _widgetOutlineBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Colors.black54, // اللون الثانوي للكروسر والحدود
      ),
    );
  }
}
