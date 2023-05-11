// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStore, Store {
  late final _$isLoginAtom = Atom(name: '_AppStore.isLogin', context: context);

  @override
  bool get isLogin {
    _$isLoginAtom.reportRead();
    return super.isLogin;
  }

  @override
  set isLogin(bool value) {
    _$isLoginAtom.reportWrite(value, super.isLogin, () {
      super.isLogin = value;
    });
  }

  late final _$tokenAtom = Atom(name: '_AppStore.token', context: context);

  @override
  String get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  late final _$nameAtom = Atom(name: '_AppStore.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$emailAtom = Atom(name: '_AppStore.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$phoneAtom = Atom(name: '_AppStore.phone', context: context);

  @override
  String get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  late final _$getUserAsyncAction =
      AsyncAction('_AppStore.getUser', context: context);

  @override
  Future<dynamic> getUser() {
    return _$getUserAsyncAction.run(() => super.getUser());
  }

  late final _$_AppStoreActionController =
      ActionController(name: '_AppStore', context: context);

  @override
  void setUser(String _token, String _name, String _email, String _phone) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setUser');
    try {
      return super.setUser(_token, _name, _email, _phone);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLogin: ${isLogin},
token: ${token},
name: ${name},
email: ${email},
phone: ${phone}
    ''';
  }
}
