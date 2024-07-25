import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../Widgets/inputs/inputs.dart';

class FormulaireLivraison extends StatefulWidget {
  const FormulaireLivraison({Key? key}) : super(key: key);

  @override
  _FormulaireLivraisonState createState() => _FormulaireLivraisonState();
}

class _FormulaireLivraisonState extends State<FormulaireLivraison> {
  final TextEditingController _nomController = TextEditingController(text: "Diallo");
  final TextEditingController _prenomController = TextEditingController(text: "Fanta");
  final TextEditingController _emailController = TextEditingController(text: "fanta.d@gmail.com");
  final TextEditingController _paysController = TextEditingController(text: "Sénégal");
  final TextEditingController _adresseController = TextEditingController(text: "Hann Maristes, Rte Brioche Dorée, Z98");

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _paysController.dispose();
    _adresseController.dispose();
    super.dispose();
  }

  Widget _buildInputField(String label, TextEditingController controller) {
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
        InputText(
          hintText: "",
          controller: controller,
          prefixIcon: Padding(
            padding: EdgeInsets.all(0.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 3.w),
                Text(
                  controller.text,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Cabin",
                  ),
                ),
              ],
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 1.5.h),
                Image.asset(
                  'assets/icons/check.png',
                  width: 5.w,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField('Nom(s)', _nomController),
        _buildInputField('Prénom(s)', _prenomController),
        _buildInputField('Adresse Email', _emailController),
        _buildInputField('Pays', _paysController),
        _buildInputField('Adresse', _adresseController),
        SizedBox(height: 1.h),
      ],
    );
  }
}