import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  List<Message> messageList = [
    Message(text: 'Hola amor', fromWho: FromWho.me),
    Message(text: 'Ya regresaste del tabajo?', fromWho: FromWho.me),
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;
    
    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);

    // > Se debe llamar cada vez que se realiza un cambio para avisarle a los listeners que algo cambió
    notifyListeners();
  }
  
}
