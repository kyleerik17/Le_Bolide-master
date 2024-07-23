import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ModalPage extends StatelessWidget {
  const ModalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.7,
        maxChildSize: 0.7,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.zero,
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                      ),
                      color: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Filtres",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFEBEBEB),
                            ),
                            padding: const EdgeInsets.all(3),
                            child: Image.asset(
                              'assets/icons/close.png',
                              width: 12.w,
                              height: 12.w,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const FilterSection(
                    title: 'Marques',
                    options: [
                      'Michelin',
                      'Hankook',
                      'Continental',
                      'Goodyear',
                      'Bridgestone',
                      'Maxxis'
                    ],
                  ),
                  const FilterSection(
                    title: 'Types de véhicules',
                    options: [
                      'Auto',
                      '4X4/SUV',
                      'Camion léger',
                      'Camion',
                      'Moto/Scooter'
                    ],
                  ),
                  const FilterSection(
                    title: 'Types de pneus',
                    options: [
                      'Toutes saisons',
                      'Pneus été',
                      'Pneus hiver'
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dimensions',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DimensionInput(label: 'Largeur', options: ['205']),
                      DimensionInput(label: 'Hauteur', options: ['55']),
                      DimensionInput(label: 'Diamètre', options: ['55']),
                    ],
                  ),
                  SizedBox(height: 4.w),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF1A1A1A),
                        padding: EdgeInsets.symmetric(
                            vertical: 4.w, horizontal: 39.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                      ),
                      child: Text(
                        "Valider",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Cabin',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class FilterSection extends StatefulWidget {
  final String title;
  final List<String> options;

  const FilterSection({super.key, required this.title, required this.options});

  @override
  _FilterSectionState createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  Map<String, bool> selectedOptions = {};

  @override
  void initState() {
    super.initState();
    for (var option in widget.options) {
      selectedOptions[option] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2.w),
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2.w),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.options.map((option) {
              return FilterChip(
                label: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: selectedOptions[option]!
                          ? Colors.white
                          : Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                backgroundColor:
                    selectedOptions[option]! ? Colors.black : Colors.white,
                selectedColor: Colors.black,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Color(0xFFC9CDD2),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
           
                onSelected: (bool value) {
                  setState(() {
                    selectedOptions[option] = value;
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class DimensionInput extends StatelessWidget {
  final String label;
  final List<String> options;

  const DimensionInput({super.key, required this.label, required this.options});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 2.w),
        Container(
          width: 25.w,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 9),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFC9CDD2), width: 1),
          ),
          child: DropdownButton<String>(
            value: options[0],
            onChanged: (String? newValue) {},
            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            isExpanded: true,
          ),
        ),
      ],
    );
  }
}
