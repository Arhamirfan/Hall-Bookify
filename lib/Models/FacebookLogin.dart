import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

class Facebooklogin extends ChangeNotifier {
  late String firstname, lastname, email;
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  Future<Null> fblogin() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        final graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=first_name,last_name,email&access_token=${accessToken.token}'));
        //can access name,picture,email,first name,last name
        //to get picture: profile['picture']['data']['url']
        final profile = jsonDecode(graphResponse.body);
        //SetState((){
        firstname = profile['first_name'];
        lastname = profile['last_name'];
        email = profile['email'];
        notifyListeners();
        //});
        print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  Future<Null> fblogOut() async {
    await facebookSignIn.logOut();
    print('Logged out.');
  }
}
