import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/home/presentation/cubit/property_cubit/property_cubit.dart';
import 'package:homix/features/home/presentation/widgets/apartments_widget.dart';
import 'package:homix/features/home/presentation/widgets/real_estate_button.dart';
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
  int selectedIndex = 0;
  RealEstateType selectedType = RealEstateType.apartment;

  TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];

  Widget _getSelectedWidget() {
    switch (selectedType) {
      case RealEstateType.apartment:
        return ApartmentsWidget();
      case RealEstateType.villa:
        return Text("Villa");
      case RealEstateType.land:
        return Text("Land");
      case RealEstateType.office:
        return Text("Office");
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 80,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(
                        PhosphorIconsRegular.magnifyingGlass,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 10,
                      children: [
                        RealEstateButton(
                            icon: Icons.home,
                            label: "Apartment",
                            isSelected:
                                selectedType == RealEstateType.apartment,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: _getSelectedWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
