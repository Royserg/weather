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
              borderRadius: BorderRadius.circular(8),
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
              return Column(
                key: const Key('city_suggestions'),
                children: state.result
                    .map(
                      (city) => InkWell(
                        child: SizedBox(
                            width: componentWidth,
                            child: Text('${city.name}, ${city.countryCode}')),
                        onTap: () {
                          debugPrint('city :${city.name}');
                        },
                      ),
                    )
                    .toList(),
              );
            }

            return Container();
          },
        )
      ],
    ));
  }
}
