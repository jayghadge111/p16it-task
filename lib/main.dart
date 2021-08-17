

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p16task/app.dart';

import 'environment/env.dart';

Future<void> main() async {
  Env.setEnvironment(Environment.DEV);

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(P16itTask());
  });
}

class P16itTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: (Env.ENV == "PROD") ? false : true,
      title: 'P16itTask',
      home: App(),
      builder: (BuildContext context, Widget child) {
        final MediaQueryData data = MediaQuery.of(context);
        final constrainedTextScaleFactor = data.textScaleFactor.clamp(1.0, 1.2);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: constrainedTextScaleFactor),
          child: child,
        );
      },
      theme: ThemeData(
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
    );
  }
}
