import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ModalPage extends StatefulWidget {
  const ModalPage({super.key});

  @override
  _ModalPageState createState() => _ModalPageState();
}

class _ModalPageState extends State<ModalPage> {
  bool _isLoading = false;
  List<dynamic> _items = [];
  String _selectedFilter = '';
  String? _selectedItemId;

  Future<void> _fetchItems() async {
    final url =
        'https://bolide.armasoft.ci/bolide_services/index.php/api/pieces/category/1';

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _items = data;
        });
      } else {
        print('Failed to load items. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching items: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
              padding: EdgeInsets.all(5.w),
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
                  const CategoriesDisplay(
                    label: 'Catégories',
                    apiUrl:
                        'https://bolide.armasoft.ci/bolide_services/index.php/api/categorie',
                  ),
                  SizedBox(height: 2.h),
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
                  SizedBox(height: 2.h),
                  FilterSection(
                    title: 'Types de pneus',
                    options: ['Toutes saisons', 'Pneus été', 'Pneus hiver'],
                    onOptionSelected: (option) {
                      if (option == 'Toutes saisons') {
                        _fetchItems();
                      }
                      setState(() {
                        _selectedFilter = option;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (_selectedFilter == 'Toutes saisons' &&
                      _items.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _items.map((item) {
                        return ListTile(
                          title: Text(item['libelle']),
                          subtitle: Text(item['description']),
                          trailing: Text('${item['price']}'),
                          tileColor: item['id'] == _selectedItemId
                              ? Colors.grey[300]
                              : Colors.transparent,
                          onTap: () {
                            setState(() {
                              _selectedItemId = item['id'];
                            });
                          },
                        );
                      }).toList(),
                    ),
                  SizedBox(height: 4.w),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        if (_selectedItemId != null) {
                          print('Selected item ID: $_selectedItemId');
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF1A1A1A),
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 39.w),
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
  final void Function(String)? onOptionSelected;

  const FilterSection({
    super.key,
    required this.title,
    required this.options,
    this.onOptionSelected,
  });

  @override
  _FilterSectionState createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              final isSelected = _selectedOption == option;
              return FilterChip(
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: isSelected ? Colors.white : Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                backgroundColor: isSelected ? Colors.black : Colors.white,
                selectedColor: Colors.black,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Color(0xFFC9CDD2),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                onSelected: (bool value) {
                  setState(() {
                    _selectedOption = isSelected ? null : option;
                    if (widget.onOptionSelected != null) {
                      widget.onOptionSelected!(_selectedOption ?? '');
                    }
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

class CategoriesDisplay extends StatefulWidget {
  final String label;
  final String apiUrl;

  const CategoriesDisplay(
      {super.key, required this.label, required this.apiUrl});

  @override
  _CategoriesDisplayState createState() => _CategoriesDisplayState();
}

class _CategoriesDisplayState extends State<CategoriesDisplay> {
  List<String> _categories = [];
  bool _isLoading = true;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(widget.apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _categories =
              data.map((item) => item['libelle'] as String).toSet().toList();
          _isLoading = false;
        });
      } else {
        print('Failed to load categories. Status code: ${response.statusCode}');
        setState(() => _isLoading = false);
      }
    } catch (e) {
      print('Error fetching categories: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: 2.w),
        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = isSelected ? null : category;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFC9CDD2)),
                        borderRadius: BorderRadius.circular(4),
                        color: isSelected ? Colors.black : Colors.white,
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: isSelected ? Colors.white : Colors.black,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
      ],
    );
  }
}
