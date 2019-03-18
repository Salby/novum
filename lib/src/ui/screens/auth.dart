import 'dart:async';
import 'package:flutter/material.dart';
import '../../blocs/auth_bloc.dart';
import '../../resources/repository.dart';

class Auth extends StatelessWidget {

  final bloc = AuthBloc();
  final _repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<String>(
          stream: bloc.key,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              validate(context, snapshot.data);
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
            bloc.getKey();
            return _AuthForm(
              onTap: (String key) => validate(context, key),
            );

          },
        ),
      ),
    );
  }

  Future<void> validate(BuildContext context, String key) async {
    key = key.trim();
    final bool valid = await _repository.newsApiProvider.test(key);
    if (valid) {
      // Navigate to the home screen if the API key is
      // valid.
      await bloc.setKey(key);
      await Future.delayed(Duration(milliseconds: 300));
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      // Show an error if the API key isn't valid.
      await bloc.setKey('');
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid API key'),
            content: Text('The API key you have provided is not valid. You can get a valid API key from newsapi.org'),
            actions: <Widget>[
              FlatButton(
                textColor: Theme.of(context).accentColor,
                child: Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }
  }

  /// Shows the home screen.
  void authenticated(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 300));
    Navigator.pushReplacementNamed(context, '/home');
  }

}

class _AuthForm extends StatefulWidget {

  _AuthForm({
    this.onTap,
  });

  final Function onTap;

  @override
  _AuthFormState createState() => _AuthFormState();

}

class _AuthFormState extends State<_AuthForm> {

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        Text(
          'Welcome',
          style: Theme.of(context).textTheme.display1.copyWith(
            fontSize: Theme.of(context).textTheme.display2.fontSize,
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.0),
          child: Text(
            'To use Novum you must provide an API key from newsapi.org',
            style: Theme.of(context).textTheme.body1.copyWith(
              fontSize: 16.0,
            ),
          ),
        ),

        SizedBox(height: 36.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.0),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter API key',
            ),
            controller: textController,
          ),
        ),

        SizedBox(height: 56.0),

        RaisedButton(
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
          child: Text('Submit'),
          onPressed: () => widget.onTap(textController.value.text),
        ),

      ],
    );
  }

}