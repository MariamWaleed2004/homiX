import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/home/data/datasources/remote_data_sources/home_remote_data_source_impl.dart';
import 'package:homix/features/home/data/repositories/home_repo_impl.dart';
import 'package:homix/features/home/domain/usecases/get_property_usecase.dart';
import 'package:homix/features/home/presentation/cubit/property_cubit/property_cubit.dart';
import 'package:homix/features/home/presentation/widgets/apartment_category_widget/apartments_list_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PopularApartmentsScreen extends StatefulWidget {
  const PopularApartmentsScreen({super.key});

  @override
  State<PopularApartmentsScreen> createState() =>
      _PopularApartmentsScreenState();
}

class _PopularApartmentsScreenState extends State<PopularApartmentsScreen> {
  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, // 15/375 ≈ 0.04 for typical width
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(width * 0.08), // 30/375 ≈ 0.08
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Find new apartments...',
                    prefixIcon: Icon(
                      PhosphorIconsRegular.magnifyingGlass,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: width * 0.043, // 16/375 ≈ 0.043
                      vertical: height * 0.017, // 14/812 ≈ 0.017
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: ApartmentsListWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
