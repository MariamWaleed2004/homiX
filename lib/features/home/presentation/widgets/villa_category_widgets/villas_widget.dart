import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/favorites/presentation/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:homix/features/home/presentation/cubit/property_cubit/property_cubit.dart';
import 'package:homix/features/home/presentation/widgets/villa_category_widgets/best_villas_widget.dart';
import 'package:homix/features/home/presentation/widgets/villa_category_widgets/villas_loading_state_widget.dart';
import 'package:homix/features/home/presentation/widgets/villa_category_widgets/recommend_villas_widget.dart';

class VillasWidget extends StatefulWidget {
  VillasWidget({super.key});

  @override
  State<VillasWidget> createState() => _VillasWidgetState();
}

class _VillasWidgetState extends State<VillasWidget> {
  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      context.read<PropertyCubit>().getProperties();
      context.read<FavoritesCubit>().loadFavorites(user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);

    return BlocConsumer<PropertyCubit, PropertyState>(
      listener: (context, propertystate) {},
      builder: (context, propertyState) {
// ----------------------------------------------- Loading State ----------------------------------------------------

        if (propertyState is PropertyLoading) {
          return VillasLoadingStateWidget();
        }
// ----------------------------------------------- Loaded State ----------------------------------------------------

        else if (propertyState is PropertyLoaded) {
          final bestVillas = propertyState.properties
              .where((villa) => villa.category == "Villa")
              .toList();

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(width * 0.06),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: width * 0.025,
                  spreadRadius: width * 0.005,
                  offset: Offset(0, height * 0.005),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(bottom: height * 0.085),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  ---------------------------- Best Villas widget ----------------------------
                    BestVillasWidget(villa: bestVillas),
                    SizedBox(height: height * 0.0375),
                    // ---------------------------- Recommend for you widget ----------------------------
                    RecommendVillasWidget(villa: bestVillas)
                  ]),
            ),
          );
        } else if (propertyState is PropertyFailure) {
          return Center(child: Text(propertyState.errorMessage));
        }
        return const Center(
          child: Text("Failed"),
        );
      },
    );
  }
}
