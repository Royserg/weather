import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/weather/presentation/bloc/weather_event.dart';

class WeatherListItem extends StatefulWidget {
  final String cityName;
  const WeatherListItem({Key? key, required this.cityName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WeatherListItemState();
}

class _WeatherListItemState extends State<WeatherListItem> {
  @override
  void initState() {
    final cityName = widget.cityName;
    context.read<WeatherBloc>().add(OnWeatherGet(cityName));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(width: 2),
      ),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.cityName,
                  style: const TextStyle(fontSize: 18),
                ),
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
