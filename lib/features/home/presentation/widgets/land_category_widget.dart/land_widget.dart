import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/home/presentation/cubit/property_cubit/property_cubit.dart';
import 'package:homix/features/home/presentation/widgets/land_category_widget.dart/land_loading_state_widget.dart';
import 'package:homix/features/home/presentation/widgets/land_category_widget.dart/lands_categories_widget.dart';
import 'package:homix/features/home/presentation/widgets/land_category_widget.dart/nearby_lands_widget.dart';

class LandWidget extends StatelessWidget {
  const LandWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    return BlocConsumer<PropertyCubit, PropertyState>(
      listener: (context, propertyState) {},
      builder: (context, propertyState) {
        // ----------------------------------------------- Loading State ----------------------------------------------------
        if (propertyState is PropertyLoading)
          {return LandLoadingStateWidget();}

        // ----------------------------------------------- Loaded State ----------------------------------------------------

        else if (propertyState is PropertyLoaded) {
          final nearbyLands = propertyState.properties
              .where((land) => land.category == "land")
              .toList();
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                right: width * 0.028,
                left: width * 0.028,
                bottom: height * 0.09,
              ),
              child: Column(
                children: [
                  LandsCategoriesWidget(),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  NearbyLandsWidget(
                    land: nearbyLands,
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(
          child: Text("Failed"),
        );
      },
    );
  }
}
