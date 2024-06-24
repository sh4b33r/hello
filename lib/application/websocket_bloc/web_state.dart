import 'package:equatable/equatable.dart';

abstract class WebSocketState extends Equatable {
  const WebSocketState();

  @override
  List<Object> get props => [];
}

class WebSocketInitial extends WebSocketState {}

class WebSocketConnected extends WebSocketState {}
class WebSocketError extends WebSocketState {
   String message;

    WebSocketError([this.message='nothing found']);

}

class WebSocketMessageReceived extends WebSocketState {
  final List<String> messages;

  const WebSocketMessageReceived(this.messages);

  @override
  List<Object> get props => [messages];
}
