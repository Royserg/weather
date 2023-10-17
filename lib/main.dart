import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/city/presentation/bloc/delete_city/bloc.dart';
import 'package:weather/features/city/presentation/bloc/list/bloc.dart';
import 'package:weather/features/city/presentation/bloc/save_city/bloc.dart';
import 'package:weather/features/city/presentation/bloc/search_city/bloc.dart';
import 'package:weather/features/weather/presentation/pages/weather_page.dart';
import 'package:weather/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<CitySearchBloc>()),
        BlocProvider(create: (_) => locator<CitySaveBloc>()),
        BlocProvider(create: (_) => locator<CityDeleteBloc>()),
        BlocProvider(create: (_) => locator<CityListBloc>()),
      ],
      child: MaterialApp(
        title: 'Weather',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: const WeatherPage(),
      ),
    );
  }
}
