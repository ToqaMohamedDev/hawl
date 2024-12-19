import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:untitled/presention/resorces/color_app.dart';

class CustomDropDownMenu extends StatefulWidget {
  final List<String> items;
  final String? selectedValue;
  final String name;
  const CustomDropDownMenu({
    Key? key,
    required this.items,
    required this.selectedValue,
    required this.name,
  }) : super(key: key);

  @override
  _CustomDropDownMenuState createState() => _CustomDropDownMenuState();
}
class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  String? selectedValue;
  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue ?? widget.items.first;
  }
  void onChanged(String? value) {
    setState(() {
      selectedValue = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint:  Row(
          children: [
            Icon(
              Icons.list,
              size: 16,
              color: ColorManager.blackColor,
            ),
            SizedBox(width: 4),
            Expanded(
              child: Text(
                widget.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.blackColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items.map((String item) => DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color:ColorManager.blackColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        )).toList(),
        value: selectedValue,
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: 160,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color:ColorManager.whiteColor, // تغيير اللون بناءً على الاختيار
          ),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: ColorManager.blackColor,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color:ColorManager.whiteColor,
          ),
          offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
