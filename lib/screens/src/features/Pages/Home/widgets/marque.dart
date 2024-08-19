import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Bolide/data/models/api_services.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class MarquePopu extends StatefulWidget {
  const MarquePopu({Key? key}) : super(key: key);

  @override
  _MarquePopuState createState() => _MarquePopuState();
}

class _MarquePopuState extends State<MarquePopu> {
  late Future<List<Map<String, dynamic>>> marques;

  @override
  void initState() {
    super.initState();
    marques = fetchMarques();
  }

  Future<List<Map<String, dynamic>>> fetchMarques() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}api/marques'));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        List<dynamic> marquesList = jsonData['Liste des marques'];

        return marquesList
            .map((marque) => {
                  'imagePath': marque['logo'],
                  'label': marque['libelle'],
                  'onTap': () {
                    // Action à effectuer lorsqu'on appuie sur la marque
                  },
                })
            .toList();
      } else {
        throw Exception('Failed to load marques: ${response.statusCode}');
      }
    } on http.ClientException catch (_) {
      throw Exception('No Internet connection');
    } catch (e) {
      print('Error fetching marques: $e');
      throw Exception('Failed to connect to server');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: marques,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          String errorMessage = 'Erreur inconnue';
          if (snapshot.error.toString().contains('No Internet connection')) {
            errorMessage = 'Pas de connexion Internet';
          } else {
            errorMessage = 'Erreur: ${snapshot.error}';
          }
          return Center(
            child: Text(
              errorMessage,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Aucune marque trouvée'));
        } else {
          return Container(
            height: 32
                .w, // Ajustez la hauteur du conteneur pour le défilement horizontal
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: snapshot.data!.map((marque) {
                  return _buildMarque(
                    imagePath: marque['imagePath'],
                    label: marque['label'],
                    onTap: marque['onTap'],
                  );
                }).toList(),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildMarque({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 25.w, // Largeur du conteneur pour chaque marque

        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Column(
          children: [
            Container(
              width: 25.w,
              height: 20.w, // Ajustez la hauteur selon vos besoins
              child: Center(
                child: Image.network(
                  imagePath,
                  width: 25.w,
                  height: 22.w, // Ajustez la hauteur selon vos besoins
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Icon(Icons.error, color: Colors.grey));
                  },
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Cabin',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
