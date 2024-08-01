import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:le_bolide/data/models/api_services.dart';
import 'package:le_bolide/data/services/user.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/Pay/Pages/checkout1_page.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'checkout3_page.dart';

class Pay2Page extends StatefulWidget {
  final int partId;
  final int userId;
  final String deliveryAddress;
  final List<dynamic> cartItems;

  Pay2Page({
    Key? key,
    required this.partId,
    required this.userId,
    required this.cartItems,
    required List<Map<String, String>> orderDetails,
    required this.deliveryAddress,
  }) : super(key: key);

  @override
  _Pay2PageState createState() => _Pay2PageState();
}

class _Pay2PageState extends State<Pay2Page> {
  late User user;
  late Future<List<dynamic>> paymentMethodsFuture;
  int? selectedPaymentMethodId;

  @override
  void initState() {
    super.initState();
    print('Initialisation de Pay2Page');
    try {
      user = GetIt.instance.get<User>();
      print('Utilisateur récupéré: ${user.id}');
      paymentMethodsFuture = fetchPaymentMethods();
    } catch (e) {
      print('Erreur lors de la récupération de l\'utilisateur: $e');
    }
  }

  Future<List<dynamic>> fetchPaymentMethods() async {
    print('Début de fetchPaymentMethods');
    const String apiUrl =
        'https://bolide.armasoft.ci/bolide_services/index.php/api/payments';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      print('Réponse de l\'API reçue. Statut: ${response.statusCode}');

      if (response.statusCode == 200) {
        print(user.id);
        final jsonResponse = jsonDecode(response.body);
        print('Données de l\'API: $jsonResponse');
        final paymentMethods = jsonResponse['Liste des methodes de paiements'];
        print('Méthodes de paiement récupérées: $paymentMethods');
        return paymentMethods;
      } else {
        throw Exception('Échec du chargement des méthodes de paiement');
      }
    } catch (e) {
      print('Exception dans fetchPaymentMethods: $e');
      throw Exception('Échec du chargement des méthodes de paiement');
    }
  }

  Future<void> createOrder({
    required int paymentMethodId,
    required String deliveryAddress,
  }) async {
    print('Début de createOrder');
    print(
        'PaymentMethodId: $paymentMethodId, DeliveryAddress: $deliveryAddress');

    if (widget.cartItems.isEmpty) {
      print('Le panier est vide');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Le panier est vide. Veuillez ajouter des articles avant de procéder.'),
        ),
      );
      return;
    }

    const String apiUrl =
        'https://bolide.armasoft.ci/bolide_services/index.php/api/orders/add';

    // Construire le corps de la requête
    final Map<String, dynamic> body = {
      'user_id':
          user.id, // Récupérer l'ID de l'utilisateur depuis l'instance `User`
      'payment_method_id':
          paymentMethodId, // ID de la méthode de paiement sélectionnée
      'delivery_address': "Abidjan", // Adresse de livraison
      'cart_items': widget.cartItems, // Articles du panier
    };

    print('Corps de la requête: $body  ');

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      print('Réponse de l\'API reçue. Statut: ${response.statusCode}');
      print('Corps de la réponse: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        print('Commande créée avec succès: $jsonResponse');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Pay3Page(
              orderDetails: jsonResponse,
              partId: widget.partId,
              userid: widget.userId,
              cartItems: widget.cartItems,
              userId: widget.userId,
            ),
          ),
        );
      } else {
        print('Erreur: ${response.statusCode}');
        print('Message d\'erreur: ${response.body}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Impossible de créer la commande. Code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Exception dans createOrder: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Une erreur est survenue lors de la création de la commande.')),
      );
    }
  }

  void _handlePayment(int paymentMethodId) {
    print('Méthode de paiement sélectionnée: $paymentMethodId');
    setState(() {
      selectedPaymentMethodId = paymentMethodId;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Début de la méthode build');
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            print('Retour à Pay1Page');
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    Pay1Page(
                  partId: widget.partId,
                  userId: widget.userId,
                  cartItems: const [],
                  deliveryAddress: widget.deliveryAddress,
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(-1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  final tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  final offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );
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
        future: paymentMethodsFuture,
        builder: (context, snapshot) {
          print('État de la connexion: ${snapshot.connectionState}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Erreur dans FutureBuilder: ${snapshot.error}');
            return const Center(
                child: Text('Échec du chargement des méthodes de paiement'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print('Aucune donnée ou liste vide');
            return const Center(
                child: Text('Aucune méthode de paiement disponible'));
          } else {
            final paymentMethods = snapshot.data!;
            print('Méthodes de paiement chargées: $paymentMethods');
            return Container(
              color: Color(0xFFF7F8F9),
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
                        SizedBox(width: 40.w),
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
                  SizedBox(height: 1.h),
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
                        fontFamily: 'Poppins'),
                  ),
                  SizedBox(height: 2.h),
                  Expanded(
                    child: ListView.builder(
                      itemCount: paymentMethods.length,
                      itemBuilder: (context, index) {
                        final paymentMethod = paymentMethods[index];
                        print(
                            'Construction de la méthode de paiement: $paymentMethod');
                        final isSelected = selectedPaymentMethodId ==
                            int.parse(paymentMethod['id']);
                        return PaymentOptionRow(
                          imagePath: paymentMethod['logo'] ??
                              'assets/icons/default.png',
                          label: paymentMethod['libelle'] ??
                              'Méthode de paiement inconnue',
                          isSelected: isSelected,
                          onTap: () {
                            _handlePayment(int.parse(paymentMethod['id']));
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (selectedPaymentMethodId == null) {
                          print('Aucune méthode de paiement sélectionnée');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Veuillez sélectionner un moyen de paiement.'),
                            ),
                          );
                          return;
                        }
                        print('Création de la commande');
                        await createOrder(
                          paymentMethodId: selectedPaymentMethodId!,
                          deliveryAddress: widget.deliveryAddress,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1.w)),
                        backgroundColor: const Color(0xFF1A1A1A),
                        padding: EdgeInsets.symmetric(
                            vertical: 1.5.h, horizontal: 10.h),
                      ),
                      child: Text(
                        'Continuer',
                        style: TextStyle(
                          fontFamily: "Cabin",
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildStep(String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class PaymentOptionRow extends StatelessWidget {
  final String imagePath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentOptionRow({
    Key? key,
    required this.imagePath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Construction de PaymentOptionRow: $label');
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 20.w,
        color: isSelected ? Colors.green.withOpacity(0.1) : Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        margin: EdgeInsets.symmetric(vertical: 1.h),
        child: Row(
          children: [
            Image.network(
              imagePath,
              height: 10.w,
            ),
            SizedBox(width: 2.w),
            Text(
              label,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Cabin',
                  fontWeight: FontWeight.w500),
            ),
            Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }
}
