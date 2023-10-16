import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/city/presentation/bloc/list/bloc.dart';
import 'package:weather/features/city/presentation/bloc/list/event.dart';
import 'package:weather/features/city/presentation/bloc/list/state.dart';
import 'package:weather/features/city/presentation/bloc/save_city/bloc.dart';
import 'package:weather/features/city/presentation/bloc/save_city/event.dart';
import 'package:weather/features/city/presentation/components/city_search.dart';
import 'package:weather/features/weather/presentation/components/weather_list_item.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  final cityListWidth = 420.0;

  @override
  Widget build(BuildContext context) {
    context.read<CityListBloc>().add(const OnCityListGet());
    context.read<CitySaveBloc>().on((event, emit) {
      if (event is OnCitySave) {
        context.read<CityListBloc>().add(const OnCityListGet());
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1d1e22),
        title: const Text(
          'WeatherCheck',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const CitySearchComponent(),
              const SizedBox(height: 48),
              SizedBox(
                width: cityListWidth,
                child: BlocBuilder<CityListBloc, CityListState>(
                    builder: (context, state) {
                  if (state is CityListEmpty) {
                    return const Center(
                      child: Text('No cities added yet.'),
                    );
                  }

                  if (state is CityListLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is CityListLoadFailure) {
                    return Center(
                      child: Text(state.message),
                    );
                  }

                  if (state is CityListLoaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.result.length,
                      itemBuilder: (context, index) {
                        final city = state.result[index];
                        return WeatherListItem(cityName: city.name);
                      },
                    );
                  }

                  return Container();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
