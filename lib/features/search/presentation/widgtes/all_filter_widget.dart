import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homix/features/search/presentation/cubit/search_cubit/search_cubit.dart';

class AllFilterWidget extends StatefulWidget {
  const AllFilterWidget({super.key});

  @override
  State<AllFilterWidget> createState() => _AllFilterWidgetState();
}

class _AllFilterWidgetState extends State<AllFilterWidget> {
  @override
  void initState() {
    super.initState();
    context.read<SearchCubit>().searchProperties('');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, searchState) {},
      builder: (context, searchState) {
        if (searchState is SearchLoading) {
          return Container(child: Text('Loading'));
        } else if (searchState is SearchLoaded) {
          return Column(children: [
            ...searchState.results.map((result) => Row(
                  children: [
                    Text("${result.location} location"),
                    Text(result.title),
                  ],
                 )
               ),
             ]
           );
        } else if (searchState is SearchFailure) {
          return Container();
        }
        return Text("No Results Found");
      },
    );
  }
}
