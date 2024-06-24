import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webchat_app/application/auth_bloc/auth_bloc.dart';
import 'package:webchat_app/application/auth_bloc/auth_event.dart';
import 'package:webchat_app/presentation/loginscreen.dart';
import 'package:webchat_app/presentation/websocket.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello $username'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {

              context.read<AuthBloc>().add(LogoutEvent());
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) => MyLoginPage()),
                (route) => false,
              );
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text('Welcome to the chat, $username!'),
            ElevatedButton(onPressed: (){

             Navigator.push(context, MaterialPageRoute(builder: (context)=> WebSocketDemo())); 
            }, child: Text('websocket'))
          ],
        ),
      ),
    );
  }
}
