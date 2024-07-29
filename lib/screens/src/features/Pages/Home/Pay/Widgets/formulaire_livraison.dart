import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class FormulaireLivraison extends StatefulWidget {
  final int userId;
  final void Function(String name, String surname, String email, String country, String address) onInformationChanged;

  const FormulaireLivraison({
    Key? key,
    required this.userId,
    required this.onInformationChanged,
  }) : super(key: key);

  @override
  _FormulaireLivraisonState createState() => _FormulaireLivraisonState();
}

class _FormulaireLivraisonState extends State<FormulaireLivraison> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();

  String _selectedCountry = 'Côte d\'Ivoire'; // Default country selection

  @override
  void initState() {
    super.initState();
    _fetchUserData();

    // Listen to changes and notify the parent widget
    _nomController.addListener(_notifyParent);
    _prenomController.addListener(_notifyParent);
    _emailController.addListener(_notifyParent);
    _adresseController.addListener(_notifyParent);
  }

  void _notifyParent() {
    widget.onInformationChanged(
      _nomController.text,
      _prenomController.text,
      _emailController.text,
      _selectedCountry,
      _adresseController.text,
    );
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _adresseController.dispose();
    super.dispose();
  }

  /// Fonction pour récupérer les données utilisateur
  Future<void> _fetchUserData() async {
    const String apiUrl =
        'https://bolide.armasoft.ci/bolide_services/index.php/api/auth/users';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Filtrer les données pour obtenir l'utilisateur avec l'ID spécifique
        final userList = data['Liste des utilisateurs'];
        final user = userList.firstWhere(
          (user) => user['id'] == widget.userId.toString(),
          orElse: () => null,
        );

        if (user != null) {
          setState(() {
            _nomController.text = user['name'] ?? '';
            _prenomController.text = user['surname'] ?? '';
            _emailController.text = user['email'] ?? '';
          });
        } else {
          print('Utilisateur non trouvé');
        }
      } else {
        print('Erreur API: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur: $e');
    }
  }

  /// Fonction de validation pour les champs
  bool _isFieldValid(String? value) {
    return value != null && value.isNotEmpty;
  }

  /// Build function for each input field
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    bool isEditable = true,
    bool hasCheckIcon = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h),
        Text(
          '$label *',
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: controller,
          enabled: isEditable,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontFamily: "Cabin",
          ),
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(vertical: 1.5.h),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Image.asset(
                'assets/icons/crt.png', // Icon à gauche
                width: 5.w,
              ),
            ),
            suffixIcon: hasCheckIcon && _isFieldValid(controller.text)
                ? Padding(
                    padding: EdgeInsets.all(0.w),
                    child: Image.asset(
                      'assets/icons/check.png',
                      width: 5.w,
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Color(0xFF1A1A1A), width: 2.0),
            ),
          ),
        ),
      ],
    );
  }

  /// Build function for dropdown menu
  Widget _buildCountryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h),
        Text(
          'Pays *',
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        DropdownButtonFormField<String>(
          value: _selectedCountry,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Color(0xFF1A1A1A), width: 2.0),
            ),
          ),
          items: [
            DropdownMenuItem(
              value: 'Côte d\'Ivoire',
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/civ.png',
                    width: 5.w,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Côte d\'Ivoire',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Cabin",
                    ),
                  ),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'Sénégal',
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/sng.png',
                    width: 5.w,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Sénégal',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Cabin",
                    ),
                  ),
                ],
              ),
            ),
          ],
          onChanged: (String? newValue) {
            setState(() {
              _selectedCountry = newValue!;
              _notifyParent(); // Notify the parent widget on change
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField(
          label: 'Nom(s)',
          controller: _nomController,
          hintText: 'Nom(s)',
          isEditable: false,
          hasCheckIcon: true,
        ),
        _buildInputField(
          label: 'Prénom(s)',
          controller: _prenomController,
          hintText: 'Prénom(s)',
          isEditable: false,
          hasCheckIcon: true,
        ),
        _buildInputField(
          label: 'Adresse Email',
          controller: _emailController,
          hintText: 'Entrez votre adresse email',
          hasCheckIcon: true,
        ),
        _buildCountryDropdown(),
        _buildInputField(
          label: 'Adresse',
          controller: _adresseController,
          hintText: 'Entrez votre adresse',
          hasCheckIcon: true,
        ),
        SizedBox(height: 1.h),
      ],
    );
  }
}
