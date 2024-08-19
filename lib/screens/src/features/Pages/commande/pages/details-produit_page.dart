import 'package:Bolide/data/services/user.dart';
import 'package:Bolide/screens/src/features/Pages/Search/Pages/find_search_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import '../../Home/widgets/bouton_ajouter.dart';
import '../widgets/widgets.dart';

class DetailsProduitsPage extends StatefulWidget {
  final int partId;
  final String imageUrl;
  final String sousCategoryImg;

  final String categoryName;
  final String title;
  final String description;
  final String price;
  final int userId;
  final String sousCategoryName;
  const DetailsProduitsPage({
    Key? key,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.partId,
    required this.userId,
    required String iconUrl,
    required this.title,
    required String categoryImg,
    required String libelle,
    required this.sousCategoryImg,
    required this.categoryName,
    required this.sousCategoryName,
  }) : super(key: key);

  @override
  _DetailsProduitsPageState createState() => _DetailsProduitsPageState();
}

class _DetailsProduitsPageState extends State<DetailsProduitsPage> {
  String iconPath = 'assets/icons/hrt2.png';
  late User user;

  void toggleIcon() async {
    // Vérifiez si l'article est déjà dans les favoris
    final isFavorite = iconPath == 'assets/icons/hrt2.png';
    final url = isFavorite
        ? 'https://bolide.armasoft.ci/bolide_services/index.php/api/favorites/add/${widget.userId}/${widget.partId}'
        : 'https://bolide.armasoft.ci/bolide_services/index.php/api/favorites/remove/${widget.userId}/${widget.partId}';

    try {
      final response = isFavorite
          ? await http.post(Uri.parse(url))
          : await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          // Changez l'icône en fonction de l'état actuel des favoris
          iconPath = isFavorite
              ? 'assets/icons/heart.svg'
              : 'assets/icons/hearted.png';
        });

        // Affichez le Snackbar pour informer l'utilisateur
        final message = isFavorite
            ? "L'article a bien été ajouté aux favoris"
            : "L'article a bien été retiré des favoris";

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        print(
            'Échec de la mise à jour des favoris, code: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de la mise à jour des favoris: $e');
    }
  }

  @override
  @override
  void initState() {
    super.initState();
    try {
      user = GetIt.instance.get<User>();
      print('User ID: ${user.id}');
    } catch (e) {
      print('Error getting user: $e');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FindSearchPage(
                    partId: widget.partId, userId: widget.userId),
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
          'Détails produit',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF7F8F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          Text(
                            widget.title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 0.3.h),
                          Row(
                            children: [
                              Image.network(widget.sousCategoryImg),
                              SizedBox(width: 1.w),
                              Text(
                                widget.sousCategoryName,
                                style: TextStyle(
                                  fontFamily: "Cabin",
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: toggleIcon,
                      child: Image.asset(
                        iconPath,
                        width: 6.w,
                        height: 10.w,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Slider1Page(
                  imageUrl: widget.imageUrl,
                ), // Adjust as needed
              ),
              SizedBox(height: 2.h),
              _buildReservationContainer(context),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReservationContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.price} F',
                style: TextStyle(
                  color: Color(0xFF1A1A1A),
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                  fontFamily: "Cabin",
                ),
              ),
              QuantityWidget(
                  partId: widget.partId,
                  userId: user.id) // Ensure this is defined elsewhere
            ],
          ),
          SizedBox(height: 1.h),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
            height: 1,
          ),
          SizedBox(height: 1.h),
          Text(
            'Description',
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: 'Cabin',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 1.h),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color(0xFF7C7C7C),
                fontFamily: 'Cabin',
                fontWeight: FontWeight.w400,
              ),
              children: [
                const TextSpan(
                  text:
                      "Ces pneus sont parfaits pour une utilisation sur terrains difficiles et c'est avec une puissance de ",
                ),
                TextSpan(
                  text: "... voir plus ",
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // TextSpan(
                //   text: "$description... voir plus",
                // ),
              ],
            ),
          ),
          SizedBox(height: 1.h),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
            height: 1,
          ),
          SizedBox(height: 1.h),
          Text(
            'Caractéristiques',
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: 'Cabin',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 1.5.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCharacteristicRow('Longueur', '120 cm',
                  backgroundColor: Colors.grey[200]),
              SizedBox(height: 0.5.h),
              _buildCharacteristicRow('Largeur', '60 cm'),
              SizedBox(height: 0.5.h),
              _buildCharacteristicRow('Hauteur', '40 cm',
                  backgroundColor: Colors.grey[200]),
              SizedBox(height: 0.5.h),
              _buildCharacteristicRow('Poids', '24 kg'),
              SizedBox(height: 0.5.h),
              _buildCharacteristicRow('Alimentation', 'Essence',
                  backgroundColor: Colors.grey[200]),
              SizedBox(height: 0.5.h),
              _buildCharacteristicRow(
                'Ref.fabriquant',
                '5677',
              ),
            ],
          ),
        ],
      ),
    );
  }
Widget _buildCharacteristicRow(String title, String description,
    {Color? backgroundColor}) {
  return Container(
    color: backgroundColor ?? Colors.transparent,
    width: double.infinity,
    height: 4.h,
    child: Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '  $title',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Cabin',
                color: Colors.black,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              '$description  ',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: 'Cabin',
                color: const Color(0xFF7C7C7C),
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

}
