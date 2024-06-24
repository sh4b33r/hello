import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webchat_app/application/websocket_bloc/web_bloc.dart';
import 'package:webchat_app/application/websocket_bloc/web_event.dart';
import 'package:webchat_app/application/websocket_bloc/web_state.dart';

class WebSocketDemo extends StatefulWidget {
  @override
  _WebSocketDemoState createState() => _WebSocketDemoState();
}

class _WebSocketDemoState extends State<WebSocketDemo> {
  final inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<WebSocketBloc>().add(ConnectWebSocket());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: inputController,
                      decoration: InputDecoration(
                        labelText: 'Send Message',
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  kIsWeb
                      ? InkWell(
                          onTap: () {
                            if (inputController.text.isNotEmpty) {
                              context
                                  .read<WebSocketBloc>()
                                  .add(SendMessage(inputController.text));
                              inputController.clear();
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 50,
                            color: Colors.amber,
                            child: Center(child: Text('Send')),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            if (inputController.text.isNotEmpty) {
                              context
                                  .read<WebSocketBloc>()
                                  .add(SendMessage(inputController.text));
                              inputController.clear();
                            }
                          },
                          child: Text('Send'),
                        ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<WebSocketBloc, WebSocketState>(
                builder: (context, state) {
                  if (state is WebSocketMessageReceived) {
                    return ListView.builder(
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Container(
                            padding: const EdgeInsets.all(8.0),
                            color: Colors.teal[50],
                            child: Text(
                              state.messages[index],
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is WebSocketConnected) {
                    return Center(child: Text('Connected. No messages yet.'));
                  } else if (state is WebSocketError) {
                    return Center(child: Text('Connection error: ${state.message}'));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }
}
