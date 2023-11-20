import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  
  // > Definimos el scrollcontroller que se va a usar el en listview que muestra los mensajes
  final ScrollController chatScrollController = ScrollController();

  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [
    Message(text: 'Hola amor', fromWho: FromWho.me),
    Message(text: 'Ya regresaste del tabajo?', fromWho: FromWho.me),
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.me);
    // > Agrego mi mensaje
    messageList.add(newMessage);

    // > Si mi mensaje termina con ? entonces genero un mensaje de ella
    if (text.endsWith('?')) {
      herReply();
    }

    // > Se debe llamar cada vez que se realiza un cambio para avisarle a los listeners que algo cambió
    notifyListeners();
    moveScreollToBottom();
  }

  Future<void> herReply() async {
    final herMessage = await getYesNoAnswer.getAnswer();
    messageList.add(herMessage);
    
    /* Comentario sobre porque se repite notifyListeners y moveScreollToBottom si despues de salir de la funcion los vuelve a llamar
     > Si bien la funcion 'sendMesasge' tiene al final 'notifyListeners' y 'moveScreollToBottom' 
     > aca (en la funcion 'herReply()') tambien hay que hacerlo por la siguiente razon:
     > Se podria poner un await en el 'herReply()' donde se llama en el sendMessage y eliminar 'notifyListeners' y 'moveScreollToBottom' 
     > de esta funcion, pero el efecto seria que hasta no termina con el mensaje de ella no avisaria a los listeners ni moveria el scroll
     > de manera que, al enviar un mensaje no lo veriamos hasta no tener la respuesta de ella. De esta manera hacemos que la funcion siga de largo
     > haga el notifyListeners y moveScreollToBottom del sendMessage (que los va a hacer primero antes de que la respuesta de ella llegue) 
     > para ver nuestro mensaje y depues cuando ella termina vuelve a notificar lo cambios el notifyListeners y moveScreollToBottom 
     > pero que estan dentro de la funcion 'herReply()'
    */
    notifyListeners();
    moveScreollToBottom();
  }

  void moveScreollToBottom() {
    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }
}
