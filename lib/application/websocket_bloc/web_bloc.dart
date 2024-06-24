import 'package:bloc/bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:webchat_app/application/websocket_bloc/web_event.dart';
import 'package:webchat_app/application/websocket_bloc/web_state.dart';

class WebSocketBloc extends Bloc<WebSocketEvent, WebSocketState> {
  late WebSocketChannel channel;
  List<String> messageList = [];

  WebSocketBloc() : super(WebSocketInitial()) {
     on<ConnectWebSocket>(_onConnectWebSocket);
    on<SendMessage>(_onSendMessage);
  }

   
  

  void _onConnectWebSocket(ConnectWebSocket event, Emitter<WebSocketState> emit) async {
    try {
      final wsUrl = Uri.parse('ws://echo.websocket.org');
      channel = WebSocketChannel.connect(wsUrl);
      emit(WebSocketConnected());

      channel.stream.listen((data) {
        add(ReceiveMessage(data));
      });
    } catch (e) {
      emit(WebSocketError('Connection failed: $e'));
    }
  }

  void _onSendMessage(SendMessage event, Emitter<WebSocketState> emit) {
    if (state is WebSocketConnected) {
      channel.sink.add(event.message);
    }
  }

  @override
  Future<void> close() {
    channel.sink.close();
    return super.close();
  }
}
