import 'package:flutter/material.dart';

import 'src/ui/pages/users/users.dart';

void main() {
  runApp(FreezedRetrofitApp());
}

class FreezedRetrofitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FREEZED-RETROFIT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UsersPage(),
    );
  }
}
