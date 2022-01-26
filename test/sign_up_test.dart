import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenbil_two/screens/auth/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:mockito/mockito.dart';
import 'package:zenbil_two/services/global_method.dart';

//import 'package:zenbil_two/screens/feeds.dart';
/*class FirebaseUser {}

class AuthResult {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseUser extends Mock implements FirebaseUser {}

class MockAuthResult extends Mock implements AuthResult {}*/

//MockFirebaseAuth auth = MockFirebaseAuth();
//BehaviorSubject<MockFirebaseUser> user = BehaviorSubject<MockFirebaseUser>();
//UserRepository(),

void main() {
  test("sign up with email and password", () async {
    SignUpScreen connectComponent = new SignUpScreen();
    final FocusNode _passwordFocusNode = FocusNode();
    final FocusNode _emailFocusNode = FocusNode();
    final FocusNode _phoneNumberFocusNode = FocusNode();
    bool _obscureText = true;
    String _emailAddress = '';
    String _password = '';
    String _fullName = '';
    int _phoneNumber;
    File _pickedImage;
    String url;
    final _formKey = GlobalKey<FormState>();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    GlobalMethods _globalMethods = GlobalMethods();
    bool _isLoading = false;
    @override
    void dispose() {
      _passwordFocusNode.dispose();
      _emailFocusNode.dispose();
      _phoneNumberFocusNode.dispose();
      dispose();
    }

    void _submitForm() async {
      final isValid = _formKey.currentState.validate();
      BuildContext context;
      FocusScope.of(context).unfocus();
      var date = DateTime.now().toString();
      var dateparse = DateTime.parse(date);
      var formattedDate =
          "${dateparse.day}-${dateparse.month}-${dateparse.year}";
      if (isValid) {
        _formKey.currentState.save();
        try {
          if (_pickedImage == null) {
            _globalMethods.authErrorHandle('Please pick an image', context);
          } else {
            final ref = FirebaseStorage.instance
                .ref()
                .child('usersImages')
                .child(_fullName + '.jpg');
            await ref.putFile(_pickedImage);
            url = await ref.getDownloadURL();
            await _auth.createUserWithEmailAndPassword(
                email: _emailAddress.toLowerCase().trim(),
                password: _password.trim());
            final User user = _auth.currentUser;
            final _uid = user.uid;
            user.updateProfile(photoURL: url, displayName: _fullName);
            user.reload();
            await FirebaseFirestore.instance.collection('users').doc(_uid).set({
              'id': _uid,
              'name': _fullName,
              'email': _emailAddress,
              'phoneNumber': _phoneNumber,
              'imageUrl': url,
              'joinedAt': formattedDate,
              'createdAt': Timestamp.now(),
            });
            Navigator.canPop(context) ? Navigator.pop(context) : null;
          }
        } catch (error) {
          _globalMethods.authErrorHandle(error.message, context);
          print('error occured ${error.message}');
        }
      }
    }

    void setState(Null Function() param0) {}

    testWidgets('email and password field cannot be empty!',
        (WidgetTester tester) async {
      SignUpScreen connectComponent = new SignUpScreen();
      var app = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: connectComponent));
      await tester.pumpWidget(app);

      // usename null
      var textField = find.byType(TextField);
      expect(textField, findsOneWidget);
      await tester.enterText(textField, 'name ');
      var button = find.byType(ButtonBar);
      expect(button, findsOneWidget);
      expect(find.text('SignUp'), findsOneWidget);
      await tester.tap(button);
      expect(find.text('name cannot be null'), findsOneWidget);

      // email adress cannot be empty

      var textformField = find.byType(TextField);
      expect(textField, findsOneWidget);
      await tester.enterText(textField, 'email ');
      var Button = find.byType(ButtonBar);
      expect(button, findsOneWidget);
      expect(find.text('SignUp'), findsOneWidget);
      await tester.tap(button);
      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });
  });
}
