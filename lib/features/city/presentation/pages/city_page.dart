import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/city/presentation/bloc/city_bloc.dart';
import 'package:weather/features/city/presentation/bloc/city_event.dart';
import 'package:weather/features/city/presentation/bloc/city_state.dart';

class CityPage extends StatelessWidget {
  const CityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1d1e22),
        title: const Text(
          'City',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter city name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                // context.read<CityBloc>().add(OnCityChanged(value));
                if (value.length > 1) {
                  context.read<CityBloc>().add(OnCitySearch(value));
                }
              },
            ),
            const SizedBox(height: 48),
            BlocBuilder<CityBloc, CityState>(builder: (context, state) {
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
                return const Column(
                  key: Key('city_suggestions'),
                  children: [Text('data')],
                );
              }

              return Container();
            }),
          ],
        ),
      ),
    );
  }
}
