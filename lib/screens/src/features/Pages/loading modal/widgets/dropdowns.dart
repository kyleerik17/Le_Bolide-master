import 'package:flutter/material.dart';
import 'package:Bolide/screens/src/features/Pages/loading%20modal/widgets/dropdown_items.dart';
import 'package:sizer/sizer.dart';

import 'model_dropdown.dart';
import 'engine_dropdown.dart';

class Dropdowns extends StatefulWidget {
  const Dropdowns({Key? key}) : super(key: key);

  @override
  _DropdownsState createState() => _DropdownsState();
}

class _DropdownsState extends State<Dropdowns> {
  String? selectedManufacturer;
  String? selectedModel;
  String? selectedEngine;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ManufacturerDropdown(
          selectedManufacturer: selectedManufacturer,
          onChanged: (newValue) {
            setState(() {
              selectedManufacturer = newValue;
              selectedModel = null;
              selectedEngine = null;
            });
          },
        ),
        SizedBox(height: 1.5.h),
        ModelDropdown(
          selectedModel: selectedModel,
          onChanged: (newValue) {
            setState(() {
              selectedModel = newValue;
              selectedEngine = null;
            });
          },
        ),
        SizedBox(height: 1.5.h),
        EngineDropdown(
          selectedEngine: selectedEngine,
          onChanged: (newValue) {
            setState(() {
              selectedEngine = newValue;
            });
          },
        ),
      ],
    );
  }
}
