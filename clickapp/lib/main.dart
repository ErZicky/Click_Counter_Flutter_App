import 'package:clickapp/logic/CounterViewModel.dart';
import 'package:clickapp/logic/countersStorage.dart';
import 'package:flutter/material.dart';
import 'package:clickapp/view/home_screen.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:provider/provider.dart';

void main() {
 runApp(
    MultiProvider(
      providers: [
        Provider<CountersStorage>(
          create: (_) => CountersStorage(),
        ),
        ChangeNotifierProvider<CounterViewModel>(
          create: (context) => CounterViewModel(
            Provider.of<CountersStorage>(context, listen: false),
          ),
        ),
      ],
      child: const clickApp(),
    ),
  );
}


class clickApp extends StatelessWidget {
  const clickApp({super.key});
  @override
  Widget build(BuildContext context) {


      return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic;
          darkColorScheme = darkDynamic;
        } else {
          // Fallback se colori dinamici non disponibili
          lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.light,
          );
        }



    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clicker App',
      theme: ThemeData(
            colorScheme: lightColorScheme,
            useMaterial3: true,
          ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        useMaterial3: true
      ),
        themeMode: ThemeMode.system, // Usa il tema del sistema
      home: const HomeScreen(),
    );
  },
      );
  }
  
}