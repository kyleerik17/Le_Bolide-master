import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';



class InputDropdown<T> extends StatelessWidget {
  final String hint;
  final List<T> items;
  final Widget Function(T) builder;
  final Function(T?)? onSelected;
  final Widget? prefixIcon;

  const InputDropdown({
    Key? key,
    required this.hint,
    required this.items,
    required this.builder,
    required this.onSelected,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.w),
        border: Border.all(color: Colors.blue.withOpacity(0.5)),
      ),
      child: DropdownButtonFormField<T>(
        isDense: true,
        items: items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: builder(e),
              ),
            )
            .toList(),
        onChanged: onSelected,
        isExpanded: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.w),
          prefixIcon: prefixIcon,
        ),
        hint: Text(
          hint,
          style: TextStyle(
            color: Colors.lightBlue,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }
}
