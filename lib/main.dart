import 'package:flutter/material.dart';
import 'package:spacex/bloc/spacex_bloc.dart';
import 'package:spacex/data/spacex_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceX Latest Launch',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(create: (context) => SpacexBloc(SpacexRepository()),
      child: const HomePage(),),
    );
  }
}
