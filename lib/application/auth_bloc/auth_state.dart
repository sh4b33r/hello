
import 'package:flutter/material.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String username;

  AuthAuthenticated(this.username);
}

class AuthSignedUp extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}