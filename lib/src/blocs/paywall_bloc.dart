import 'package:handcash_connect_sdk/handcash_connect_sdk.dart';
import 'package:novum/src/models/article_model.dart';
import 'package:novum/src/resources/handcash_provider.dart';
import 'package:cubit/cubit.dart';

class PaywallState {
  final ArticleModel article;

  PaywallState({this.article});
}

class PaywallStateInitial extends PaywallState {
  PaywallStateInitial({ArticleModel article}) : super(article: article);
}

class PaywallStateUnauthenticated extends PaywallState {
  PaywallStateUnauthenticated({ArticleModel article}) : super(article: article);
}

class PaywallStatePayToUnlock extends PaywallState {
  PaywallStatePayToUnlock({ArticleModel article}) : super(article: article);
}

class PaywallStateUnlocking extends PaywallState {
  PaywallStateUnlocking({ArticleModel article}) : super(article: article);
}

class PaywallStateUnlocked extends PaywallState {
  PaywallStateUnlocked({ArticleModel article}) : super(article: article);
}

class PaywallBloc extends Cubit<PaywallState> {
  final HandCashProvider _handCashProvider = HandCashProvider();
  ArticleModel _currentArticle;

  static final PaywallBloc _singleton = PaywallBloc._internal();

  factory PaywallBloc() {
    return _singleton;
  }

  PaywallBloc._internal() : super(PaywallStateInitial());

  loadArticle(ArticleModel article) async {
    _currentArticle = article;
    emit(PaywallStateInitial(article: _currentArticle));
    final bool isAuthenticated =
        await _handCashProvider.getAuthToken().then((value) => value != null).catchError((_) => false);
    if (isAuthenticated) {
      emit(PaywallStatePayToUnlock(article: _currentArticle));
    } else {
      emit(PaywallStateUnauthenticated(article: _currentArticle));
    }
  }

  onAuthenticationChanged() async {
    final bool isAuthenticated =
        await _handCashProvider.getAuthToken().then((value) => value != null).catchError((_) => false);
    if (isAuthenticated) {
      emit(PaywallStatePayToUnlock(article: _currentArticle));
    } else {
      emit(PaywallStateUnauthenticated(article: _currentArticle));
    }
  }

  payToUnlock() async {
    emit(PaywallStateUnlocking(article: _currentArticle));
    final String authToken = await _handCashProvider.getAuthToken();
    final account = HandCashConnect.getAccountFromAuthToken(authToken);
    final paymentResult =
        await account.wallet.pay(PaymentParameters(appAction: 'readArticle', description: 'Read article', receivers: [
      PaymentRequestItem(currencyCode: 'USD', sendAmount: 0.05, destination: 'elpais'),
    ]));
    print(paymentResult);
    emit(PaywallStateUnlocked(article: _currentArticle));
  }
}
