import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/city/presentation/bloc/city_bloc.dart';
import 'package:weather/features/city/presentation/bloc/city_event.dart';
import 'package:weather/features/city/presentation/bloc/city_state.dart';

class CitySearchComponent extends StatelessWidget {
  const CitySearchComponent({super.key});

  final componentWidth = 350.0;

  @override
  Widget build(BuildContext context) {
    return (Column(
      children: [
        TextField(
          decoration: InputDecoration(
            constraints: BoxConstraints(maxWidth: componentWidth),
            hintText: 'Enter city name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 10,
              ),
            ),
          ),
          onChanged: (value) {
            context.read<CityBloc>().add(OnCitySearch(value));
          },
        ),
        BlocBuilder<CityBloc, CityState>(
          builder: (context, state) {
            if (state is CitiesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CitiesLoadFailure) {
              return Center(
                child: Text('error: ${state.message}'),
              );
            }

            if (state is CitiesLoaded) {
              var citiesCount = state.result.length;

              return Container(
                width: componentWidth,
                height: citiesCount * 50,
                decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  border: Border(
                    bottom: BorderSide(width: 2),
                    left: BorderSide(),
                    right: BorderSide(),
                    top: BorderSide(width: 0),
                  ),
                ),
                key: const Key('city_suggestions'),
                child: ListView.separated(
                  itemCount: citiesCount,
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 0.5,
                    height: 0,
                    indent: 10.0,
                    endIndent: 10.0,
                  ),
                  itemBuilder: (context, index) {
                    var city = state.result[index];
                    return ListTile(
                      title: Text('${city.name}, ${city.countryCode}'),
                      onTap: () {
                        debugPrint('city :${city.name}');
                      },
                    );
                  },
                ),
              );
            }

            return Container();
          },
        )
      ],
    ));
  }
}
