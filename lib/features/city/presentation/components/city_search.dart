import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/city/presentation/bloc/save_city/bloc.dart';
import 'package:weather/features/city/presentation/bloc/save_city/event.dart';
import 'package:weather/features/city/presentation/bloc/search_city/bloc.dart';
import 'package:weather/features/city/presentation/bloc/search_city/event.dart';
import 'package:weather/features/city/presentation/bloc/search_city/state.dart';

class CitySearchComponent extends StatefulWidget {
  const CitySearchComponent({super.key});

  @override
  State<StatefulWidget> createState() => _CitySearchComponentState();
}

class _CitySearchComponentState extends State<CitySearchComponent> {
  final textFieldController = TextEditingController();
  final componentWidth = 350.0;

  @override
  void initState() {
    super.initState();

    // Note: triggers rebuild when text field changes (suffix icon conditionally appears)
    textFieldController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void handleTextFieldChange(String value) {
      context.read<CitySearchBloc>().add(OnCitySearch(value));
    }

    void clearTextField() {
      textFieldController.clear();
      handleTextFieldChange('');
    }

    return (Column(
      children: [
        TextField(
          controller: textFieldController,
          decoration: InputDecoration(
            suffixIcon: textFieldController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      clearTextField();
                    },
                  )
                : null,
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
          onChanged: handleTextFieldChange,
        ),
        BlocBuilder<CitySearchBloc, CitySearchState>(
          builder: (context, state) {
            if (state is CitySuggestionsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CitySuggestionsLoadFailure) {
              return Center(
                child: Text('error: ${state.message}'),
              );
            }

            if (state is CitySuggestionsLoaded) {
              var citiesCount = state.result.length;

              return Container(
                width: componentWidth,
                height: citiesCount * 50,
                decoration: const BoxDecoration(
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
                        // Clear input field
                        clearTextField();

                        // Save city
                        context.read<CitySaveBloc>().add(OnCitySave(city));
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
