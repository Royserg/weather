import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/city/domain/entities/city.dart';
import 'package:weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/weather/presentation/bloc/weather_event.dart';

class WeatherListItem extends StatefulWidget {
  final CityEntity city;
  const WeatherListItem({Key? key, required this.city}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WeatherListItemState();
}

class _WeatherListItemState extends State<WeatherListItem> {
  @override
  void initState() {
    final city = widget.city;

    context
        .read<WeatherBloc>()
        .add(OnWeatherGet(city.latitude, city.longitude));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(width: 1),
      ),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.city.name,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("15"),
                SizedBox(
                  width: 8,
                ),
                Text("Rain"),
                // Spacer(),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
