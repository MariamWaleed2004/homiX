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
                    hintText: 'Find new apartments...',
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
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ApartmentsListWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
