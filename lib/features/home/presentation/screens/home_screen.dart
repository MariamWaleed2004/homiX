import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homix/core/const.dart';
import 'package:homix/core/injection_container.dart' as di;
import 'package:homix/features/favorites/presentation/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:homix/features/home/presentation/cubit/property_cubit/property_cubit.dart';
import 'package:homix/features/home/presentation/widgets/apartment_category_widget/apartments_widget.dart';
import 'package:homix/features/home/presentation/widgets/land_category_widget.dart/land_loading_state_widget.dart';
import 'package:homix/features/home/presentation/widgets/land_category_widget.dart/land_widget.dart';
import 'package:homix/features/home/presentation/widgets/real_estate_button.dart';
import 'package:homix/features/home/presentation/widgets/villa_category_widgets/villas_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum RealEstateType {
  apartment,
  villa,
  land,
  office,
  townhouse,
  duplexes,
  studios,
  shop
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  // int selectedInex = 0;
  RealEstateType selectedType = RealEstateType.apartment;

  Widget _getSelectedWidget() {
    switch (selectedType) {
      case RealEstateType.apartment:
        return ApartmentsWidget();
      case RealEstateType.villa:
        return VillasWidget();
      case RealEstateType.land:
        return LandWidget();
      case RealEstateType.office:
        return LandLoadingStateWidget();
      case RealEstateType.townhouse:
        return Text("Townhouse");
      case RealEstateType.duplexes:
        return Text("Duplexes");
      case RealEstateType.studios:
        return Text("Studios");
      case RealEstateType.shop:
        return Text("Shop");
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<PropertyCubit>().getProperties();
  }

  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ScreenConst.searchScreen);
                },
                child: AbsorbPointer(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * 0.08),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(
                          PhosphorIconsRegular.magnifyingGlass,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: width * 0.042,
                            vertical: height * 0.017),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.03),
            Padding(
              padding: EdgeInsets.only(left: width * 0.032),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: width * 0.026,
                    children: [
                      RealEstateButton(
                          icon: Icons.home,
                          label: "Apartment",
                          isSelected: selectedType == RealEstateType.apartment,
                          onTap: () => setState(() {
                                selectedType = RealEstateType.apartment;
                              })),
                      RealEstateButton(
                          icon: Icons.villa,
                          label: "Villas",
                          isSelected: selectedType == RealEstateType.villa,
                          onTap: () => setState(() {
                                selectedType = RealEstateType.villa;
                              })),
                      RealEstateButton(
                          icon: Icons.terrain,
                          label: "Land",
                          isSelected: selectedType == RealEstateType.land,
                          onTap: () => setState(() {
                                selectedType = RealEstateType.land;
                              })),
                      RealEstateButton(
                          icon: Icons.business_center,
                          label: "Office",
                          isSelected: selectedType == RealEstateType.office,
                          onTap: () => setState(() {
                                selectedType = RealEstateType.office;
                              })),
                      RealEstateButton(
                          icon: Icons.apartment,
                          label: "Duplexes",
                          isSelected: selectedType == RealEstateType.duplexes,
                          onTap: () => setState(() {
                                selectedType = RealEstateType.duplexes;
                              })),
                      RealEstateButton(
                          icon: Icons.storefront,
                          label: "Shops",
                          isSelected: selectedType == RealEstateType.shop,
                          onTap: () => setState(() {
                                selectedType = RealEstateType.shop;
                              })),
                    ],
                  )),
            ),
            SizedBox(height: height * 0.02),
            _getSelectedWidget(),
          ],
        ),
      ),
    );
  }
}
