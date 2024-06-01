import 'package:caps_2/friend/provider/friend_provider.dart';
import 'package:caps_2/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'login.dart';
void main() {
  KakaoSdk.init(
    nativeAppKey: "579b96006db2df4884fe622c754f8d52",
    javaScriptAppKey: "8b07cbd2ab7e46d6c6be4cc09830881d",
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MapProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FriendProvider()..getLatestList(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

