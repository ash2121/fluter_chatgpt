import 'package:flutter/material.dart';
import 'package:fluuter_chatgpt/constants/constant.dart';
import 'package:fluuter_chatgpt/providers/chat_provider.dart';
import 'package:fluuter_chatgpt/providers/models_provider.dart';
import 'package:fluuter_chatgpt/screens/chat_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            scaffoldBackgroundColor: scaffoldBgCol,
            primarySwatch: Colors.blue,
            appBarTheme: AppBarTheme(color: cardCol)),
        home: ChatScreen(),
      ),
    );
  }
}
