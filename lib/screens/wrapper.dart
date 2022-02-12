import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:team_coffee/models/user.dart';
import 'package:team_coffee/screens/authenticate/authenticate.dart';
import 'package:team_coffee/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    print(user);

    //Return either Home or Authenticate widget
    if (user == null) {
      return const Authenticate();
    } else {
      return const Home();
    }
  }
}
