import 'package:flutter/material.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/search/presentation/widgtes/all_filter_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> filters = [
    'All',
    'Compounds',
    'Locations',
    'Developers',
    'Lanches',
  ];

  String selectedFilter = 'All';

  Widget _getSelectedFilter() {
    switch (selectedFilter) {
      case 'All':
        return AllFilterWidget();
      case 'Compounds':
        return Text("Compounds");
      case 'Locations':
        return Text("Locations");
      case 'Developers':
        return Text("Developers");
      case 'Lanches':
        return Text("Lanches");
      default:
        return Text("No Results Found");
    }
  }

  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ScreenConst.searchScreen);
              },
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
                        horizontal: width * 0.042, vertical: height * 0.017),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.01),
          Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: filters.map((filter) {
                    final isSelected = filter == selectedFilter;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filter;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              filter,
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Container(
                              height: 2,
                              width: 20,
                              color: isSelected
                                  ? Colors.black
                                  : Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                width: width,
                height: 1,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 0.5,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(child: _getSelectedFilter()),
        ],
      ),
    );
  }
}
