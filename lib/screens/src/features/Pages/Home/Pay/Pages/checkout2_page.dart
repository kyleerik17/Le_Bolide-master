import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'checkout3_page.dart'; // Assurez-vous que ce fichier est bien importé

class Pay2Page extends StatelessWidget {
  final int partId;
  final int userId; // Utilisé pour l'identifiant de l'utilisateur
  final List<dynamic> cartItems;

  const Pay2Page({
    Key? key,
    required this.partId,
    required this.userId,
    required this.cartItems,
  }) : super(key: key);

  /// Méthode pour récupérer les méthodes de paiement depuis l'API
  Future<List<dynamic>> fetchPaymentMethods() async {
    const String apiUrl =
        'https://bolide.armasoft.ci/bolide_services/index.php/api/payments';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['Liste des methodes de paiements'];
      } else {
        throw Exception('Échec du chargement des méthodes de paiement');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Échec du chargement des méthodes de paiement');
    }
  }

  /// Méthode pour créer une commande en envoyant une requête POST au serveur
  Future<void> createOrder({
    required int userId,
    required int paymentMethodId,
    required String deliveryAddress,
    required BuildContext context,
  }) async {
    const String apiUrl =
        'https://bolide.armasoft.ci/bolide_services/index.php/api/orders/add'; // Remplacez par votre point de terminaison API

    // Création d'un corps de requête pour la commande
    final Map<String, dynamic> body = {
      'user_id': userId, // Utiliser l'userId correct ici
      'payment_method_id': paymentMethodId,
      'delivery_address': deliveryAddress,
      'cart_items': cartItems, // Transmettez cartItems à la commande
    };

    try {
      // Effectuer la requête POST
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      // Vérifiez si la requête a réussi
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);

        // Naviguez vers la page de confirmation avec les détails de la commande
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Pay3Page(
              orderDetails: jsonResponse,
            ),
          ),
        );
      } else {
        // Gérer la réponse d'erreur
        print('Erreur: ${response.statusCode}');
        print(
            'Message d\'erreur: ${response.body}'); // Afficher le message d'erreur

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Impossible de créer la commande. Code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Une erreur est survenue lors de la création de la commande.')),
      );
    }
  }

  /// Fonction pour gérer la création de commande
  void _handlePayment(
      String label, int paymentMethodId, BuildContext context) async {
    const deliveryAddress =
        "Abidjan"; // Vous pouvez le rendre dynamique si nécessaire

    print('Creating order with payment method: $label');
    print('User ID: $userId'); // Affiche l'userId pour le débogage
    print('Payment Method ID: $paymentMethodId');
    print('Delivery Address: $deliveryAddress');
    print('Cart Items: $cartItems');

    // Appelez la fonction createOrder
    await createOrder(
      userId: userId,
      paymentMethodId: paymentMethodId,
      deliveryAddress: deliveryAddress,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            'assets/icons/gc.png',
            width: 15.w,
            height: 15.w,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Paiement',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchPaymentMethods(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Échec du chargement des méthodes de paiement'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('Aucune méthode de paiement disponible'));
          } else {
            final paymentMethods = snapshot.data!;
            return Container(
              color: Colors.white,
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 0.w),
                    child: Row(
                      children: [
                        SizedBox(width: 2.w),
                        Image.asset(
                          'assets/icons/lgo.png',
                          width: 8.w,
                        ),
                        SizedBox(width: 35.w),
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/lock.png',
                              width: 8.w,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              'Paiement sécurisé',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      SizedBox(width: 2.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.2.w),
                        child: Image.asset(
                          'assets/icons/cs.png',
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                        child: const Divider(
                          color: Colors.grey,
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.2.w),
                        child: Image.asset(
                          'assets/icons/cs1.png',
                        ),
                      ),
                      SizedBox(
                        width: 33.w,
                        child: const Divider(
                          color: Colors.grey,
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.2.w),
                        child: Image.asset(
                          'assets/icons/cs2.png',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStep('  Livraison'),
                      _buildStep('Paiement'),
                      _buildStep('Confirmation'),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  const Text(
                    'Choisissez un moyen de paiement',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins"),
                  ),
                  SizedBox(height: 2.h),
                  Expanded(
                    child: ListView.builder(
                      itemCount: paymentMethods.length,
                      itemBuilder: (context, index) {
                        final method = paymentMethods[index];
                        return PaymentOptionRow(
                          label: method['libelle'],
                          imagePath: method['logo'],
                          imageWidth: 10.w,
                          height: 10.w,
                          onTap: () => _handlePayment(method['libelle'],
                              int.parse(method['id']), context),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  /// Widget pour construire les étapes de paiement
  Widget _buildStep(String label) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

/// Widget pour les options de paiement
class PaymentOptionRow extends StatelessWidget {
  final String label;
  final String imagePath;
  final double imageWidth;
  final double height;
  final VoidCallback onTap;

  const PaymentOptionRow({
    Key? key,
    required this.label,
    required this.imagePath,
    required this.imageWidth,
    required this.height,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 10.h, // Ajuster la hauteur du conteneur
        margin: EdgeInsets.symmetric(
            vertical: 2.h), // Espacement vertical entre les options
        padding: EdgeInsets.symmetric(
            horizontal:
                4.w), // Espacement horizontal à l'intérieur du conteneur
        decoration: BoxDecoration(
          color: Colors.white, // Couleur de fond blanche
          borderRadius: BorderRadius.circular(15), // Coins arrondis
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2), // Position de l'ombre
            ),
          ],
        ),
        child: Row(
          children: [
            // Remplacez cette ligne par un NetworkImage si vous avez des images en ligne
            Image.network(
              imagePath,
              width: imageWidth,
              height: height,
              fit: BoxFit.contain,
            ),
            SizedBox(
                width: 4.w), // Ajouter de l'espace entre l'image et le texte
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp, // Taille de la police
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2, // Nombre maximum de lignes
                overflow: TextOverflow.ellipsis, // Gestion du texte trop long
              ),
            ),
          ],
        ),
      ),
    );
  }
}
