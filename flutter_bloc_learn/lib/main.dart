import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'dart:math' as math show Random;

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const MyHomePage(),
  ));
}

const name = ["Foo", "Boo", "Key"];

extension RandomElement<T> on Iterable<T> {
  T randomElement() => elementAt(math.Random().nextInt(length));
}

class NameCubit extends Cubit<String?> {
  NameCubit() : super(null);
  void pickRandomName() => emit(name.randomElement());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final NameCubit name;
  @override
  void initState() {
    name = NameCubit();
    super.initState();
  }

  @override
  void dispose() {
    name.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<String?>(
          stream: name.stream,
          builder: (context, snapshot) {
            final button = TextButton(
                onPressed: () {
                  name.pickRandomName();
                },
                child: Text("Generate Random number"));
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return button;
              case ConnectionState.waiting:
                return button;
              case ConnectionState.waiting:
                return button;
              case ConnectionState.active:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(snapshot.data!), button],
                  ),
                );
              case ConnectionState.done:
                return SizedBox();
            }
          }),
    );
  }
}
