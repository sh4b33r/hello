import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:webchat_app/application/auth_bloc/auth_event.dart';
import 'package:webchat_app/application/auth_bloc/auth_state.dart';
import 'package:webchat_app/domain/user_model/user_model.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Box<UserBox> userBox;

  AuthBloc(this.userBox) : super(AuthInitial()) {
    on<SignUpEvent>(_onSignUp);
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    
  }

  void _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    final user = UserBox(event.username, event.password);
    await userBox.put(event.username, user);
    emit(AuthSignedUp());
  }

  void _onLogin(LoginEvent event, Emitter<AuthState> emit) {
    final user = userBox.get(event.username);
  
    if (user!=null &&  user.password.isNotEmpty && user.username.isNotEmpty   && user.password == event.password) {
      emit(AuthAuthenticated(user.username));
      log('susccess');
    } else {
      emit(AuthError("Invalid username or password"));
    }
  }

  void _onLogout(LogoutEvent event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }

}