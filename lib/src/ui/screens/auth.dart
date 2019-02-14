import 'package:flutter/material.dart';
import '../../blocs/auth_bloc.dart';
import '../../resources/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends StatelessWidget {

  final bloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<String>(
          stream: bloc.key,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

            if (snapshot.hasData) {
              authenticated(context);
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
            bloc.getKey();
            return _AuthForm(
              onValidated: (String validKey) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('news_api_key', validKey);
                Navigator.pushReplacementNamed(context, '/home');
              }
            );

          },
        ),
      ),
    );
  }

  void authenticated(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 300));
    Navigator.pushReplacementNamed(context, '/home');
  }

}

class _AuthForm extends StatefulWidget {

  _AuthForm({
    this.onValidated,
  });

  final Function onValidated;
  final _repository = Repository();

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
            'To use Novum the app needs an API key to be able to fetch the latest news for you.',
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
          onPressed: () async {
            final String value = textController.value.text;
            final bool valid = await widget._repository.newsApiProvider.test(value);
            if (valid) {
              widget.onValidated(value);
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('This API key is not valid.'),
                duration: Duration(milliseconds: 4000),
              ));
            }
          },
        ),

      ],
    );
  }

}