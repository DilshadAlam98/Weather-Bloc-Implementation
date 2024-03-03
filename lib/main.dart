import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/feature/weather/bloc/weather_bloc.dart';
import 'package:flutter_bloc_demo/feature/weather/repository/repository.dart';
import 'package:flutter_bloc_demo/feature/weather/repository/repository_provider.dart';
import 'package:flutter_bloc_demo/feature/weather/screens/home_screen.dart';
import 'package:weather/weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherBloc(
        RepoProvider(
          wf: WeatherFactory('2cc3a3443cb42e94fe1f06b7131e8c7a'),
        ),
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: const HomeScreen(),
      ),
    );
  }
}
