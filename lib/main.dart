import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:handcash_connect_sdk/handcash_connect_sdk.dart';
import 'package:novum/src/blocs/paywall_bloc.dart';
import 'package:novum/src/resources/handcash_provider.dart';
import './src/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HandCashConnect.initialize(appId: '603be87f6132590c2d2253d0');
  HandCashAuthTokenListener().listen((String authToken) async {
    print(authToken);
    await HandCashProvider().setAuthToken(authToken);
    PaywallBloc().onAuthenticationChanged();
  });
  HandCashProvider().getAuthToken().then(print);
  PaywallBloc().listen(print);
  PaywallBloc().onAuthenticationChanged();
  runApp(
    CubitProvider(
      create: (BuildContext context) => PaywallBloc(),
      child: NovumApp(),
    ),
  );
}
