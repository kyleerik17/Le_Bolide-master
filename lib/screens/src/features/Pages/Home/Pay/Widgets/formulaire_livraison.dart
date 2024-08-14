import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:Bolide/data/services/user.dart';
import 'package:Bolide/screens/src/features/Pages/Home/Pay/Pages/checkout3_page.dart';
import 'package:sizer/sizer.dart';

class FormulaireLivraison extends StatefulWidget {
  final int userId;
  final int partId;
  final void Function(String name, String surname, String email, String country,
      String address) onInformationChanged;

  const FormulaireLivraison({
    Key? key,
    required this.userId,
    required this.onInformationChanged,
    required this.partId,
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
  final _formKey = GlobalKey<FormState>();
  late User user;
  bool _isEmailValid = false;
  bool _isAddressValid = false;

  @override
  void initState() {
    super.initState();

    try {
      user = GetIt.instance.get<User>();
      _nomController.text = user.name; // Remplir le champ du nom
      _prenomController.text = user.surname; // Remplir le champ du prénom
    } catch (e) {
      print(e);
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (builder) => const RegistrationPage()));
    }

    _fetchUserData();

    // Écouter les changements et notifier le parent
    _nomController.addListener(_notifyParent);
    _prenomController.addListener(_notifyParent);
    _emailController.addListener(_validateEmail);
    _adresseController.addListener(_validateAddress);
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

  void _validateEmail() {
    final email = _emailController.text;
    final emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    setState(() {
      _isEmailValid = RegExp(emailPattern).hasMatch(email);
    });
    _notifyParent();
  }

  void _validateAddress() {
    final address = _adresseController.text;
    setState(() {
      _isAddressValid = address.isNotEmpty;
    });
    _notifyParent();
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _adresseController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserData() async {
    String apiUrl =
        'https://bolide.armasoft.ci/bolide_services/index.php/api/auth/users/${user.id}';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final userList = data['Liste des utilisateurs'] as List<dynamic>;

        // Trouver l'utilisateur avec l'ID spécifique
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

  bool _isFieldValid(String? value) {
    return value != null && value.isNotEmpty;
  }

  bool _validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    bool isEditable = true,
    bool hasCheckIcon = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1.h),
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
          validator: validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champ est obligatoire';
                }
                return null;
              },
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontFamily: "Cabin",
          ),
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(
                vertical: 0.8.h, horizontal: 4.w), // Réduit la hauteur
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

  Widget _buildCountryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1.h),
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
            contentPadding: EdgeInsets.symmetric(
                vertical: 0.8.h, horizontal: 2.w), // Réduit la hauteur
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

  void _handleSubmit() {
    if (_validateForm()) {
      // Pass data to the next page or save it
      widget.onInformationChanged(
        _nomController.text,
        _prenomController.text,
        _emailController.text,
        _selectedCountry,
        _adresseController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
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
            hintText: 'Email',
            hasCheckIcon: _isEmailValid,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ est obligatoire';
              } else if (!_isEmailValid) {
                return 'Format d\'email invalide';
              }
              return null;
            },
          ),
          _buildCountryDropdown(),
          _buildInputField(
            label: 'Adresse de livraison',
            controller: _adresseController,
            hintText: 'Adresse de livraison',
            hasCheckIcon: _isAddressValid,
          ),
          SizedBox(height: 1.h),
        ],
      ),
    );
  }
}
