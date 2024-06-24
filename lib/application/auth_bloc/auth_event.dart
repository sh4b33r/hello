import 'package:flutter/material.dart';

@immutable
abstract class AuthEvent{}

class SignUpEvent extends AuthEvent {
  final String username;
  final String password;

  SignUpEvent(this.username, this.password);
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent(this.username, this.password);
}
class LoginInvalidEvent extends AuthEvent{}

class LogoutEvent extends AuthEvent {}