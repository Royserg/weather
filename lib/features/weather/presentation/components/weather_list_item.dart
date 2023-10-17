import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather/core/utils/wmo_weather_code_converter.dart';
import 'package:weather/features/city/domain/entities/city.dart';
import 'package:weather/features/city/presentation/bloc/delete_city/bloc.dart';
import 'package:weather/features/city/presentation/bloc/delete_city/event.dart';
import 'package:weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/weather/presentation/bloc/weather_event.dart';
import 'package:weather/features/weather/presentation/bloc/weather_state.dart';
import 'package:weather/injection_container.dart';

class WeatherListItem extends StatefulWidget {
  final CityEntity city;

  const WeatherListItem({Key? key, required this.city}) : super(key: key);

  @override
  State<WeatherListItem> createState() => _WeatherListItemState();
}

class _WeatherListItemState extends State<WeatherListItem> {
  Offset? _tapOffset;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBloc>(
      create: (context) {
        return WeatherBloc(locator())
          ..add(OnWeatherGet(widget.city.latitude, widget.city.longitude));
      },
      child: GestureDetector(
        // TODO: for mobile - add long press handling
        onSecondaryTapUp: (details) {
          _tapOffset = details.globalPosition;
        },
        onSecondaryTap: () {
          if (_tapOffset != null) {
            _showContextMenu(context);
          }
        },
        child: Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(width: 1),
          ),
          elevation: 1,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.city.name,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Expanded(child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherEmpty) {
                      return const Text("No data");
                    }

                    if (state is WeatherLoading) {
                      return const Skeletonizer(
                        child: Row(
                          children: [
                            Text('temp'),
                            Text('description'),
                          ],
                        ),
                      );
                    }

                    if (state is WeatherLoadFailure) {
                      return const Text("Failed to load weather");
                    }

                    if (state is WeatherLoaded) {
                      final weather = state.result;
                      final temp = weather.current.temperature2m.toString();
                      final unit = weather.currentUnits.temperature2m;

                      return Row(
                        children: [
                          Text(
                            '$temp $unit',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Divider(
                            indent: 8,
                            endIndent: 8,
                            color: Colors.black,
                          ),
                          Text(
                            WmoWeatherCodeConverter.convert(
                                weather.current.weathercode),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      );
                    }

                    return const Text("0");
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // -- Context menu
  Future<dynamic> _showContextMenu(BuildContext context) {
    return showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        _tapOffset!.dx,
        _tapOffset!.dy,
        MediaQuery.of(context).size.width - _tapOffset!.dx,
        MediaQuery.of(context).size.height - _tapOffset!.dy,
      ),
      items: [
        PopupMenuItem(
          onTap: () {
            context.read<CityDeleteBloc>().add(OnCityDelete(widget.city.id));
          },
          child: const Row(
            children: [
              Icon(Icons.delete),
              SizedBox(width: 8),
              Text('Delete'),
            ],
          ),
        )
      ],
    );
  }
}
