import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:webchat_app/application/auth_bloc/auth_bloc.dart';
import 'package:webchat_app/application/websocket_bloc/web_bloc.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:webchat_app/domain/user_model/user_model.dart';
import 'package:webchat_app/presentation/loginscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter('path: userBox');

  if (!Hive.isAdapterRegistered(UserBoxAdapter().typeId)) {
    Hive.registerAdapter(UserBoxAdapter());
  }

 final Box<UserBox> uBox = await Hive.openBox<UserBox>('userBox');

  runApp(MyApp(box:uBox));
}

class MyApp extends StatelessWidget {
   

  const MyApp({super.key,required this.box});
  final Box<UserBox>box;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          
          BlocProvider(
            create: (context) => AuthBloc(box),
          
          ),
 
      BlocProvider(
            create: (context) => WebSocketBloc(),
          
          )
        ],
       
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyLoginPage(),
        ),
      ),
    );
  }
}
