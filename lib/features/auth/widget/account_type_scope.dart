import 'package:coach_finder/common/data/account_type.dart';
import 'package:flutter/material.dart';

abstract class AccountTypeController {
  void setAccountType(AccountType accountType);

  AccountType get accountType;

  bool get isCoach;

  bool get isClient;
}

class AccountTypeScope extends StatefulWidget {
  final Widget child;

  const AccountTypeScope({
    required this.child,
    super.key,
  });

  static AccountTypeController of(BuildContext context) {
    final _AccountTypeInh? result =
    context.dependOnInheritedWidgetOfExactType<_AccountTypeInh>();
    assert(result != null, 'No AccountTypeScope found in context');
    return result!.controller;
  }

  @override
  State<AccountTypeScope> createState() => _AccountTypeScopeState();
}

class _AccountTypeScopeState extends State<AccountTypeScope>
    implements AccountTypeController {
  AccountType _accountType = AccountType.client;

  @override
  Widget build(BuildContext context) {
    return _AccountTypeInh(
      controller: this,
      accountType: accountType,
      child: widget.child,
    );
  }

  @override
  AccountType get accountType => _accountType;

  @override
  void setAccountType(AccountType accountType) {
    setState(() {
      _accountType = accountType;
    });
  }

  @override
  bool get isClient => _accountType == AccountType.client;

  @override
  bool get isCoach => !isClient;
}

class _AccountTypeInh extends InheritedWidget {
  final AccountTypeController controller;
  final AccountType _accountType;

  const _AccountTypeInh({
    required this.controller,
    required AccountType accountType,
    required Widget child,
  })  : _accountType = accountType,
        super(child: child);

  @override
  bool updateShouldNotify(_AccountTypeInh old) {
    return _accountType != old._accountType;
  }
}