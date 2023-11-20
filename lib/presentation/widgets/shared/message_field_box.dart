import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  /* Comentario sobre: onValue (ValueChanged)
    > Este onValue es una variable que contendrá una funcion de callback que se le pasa a MessageFieldBox,
    > para que éste dado el punto en el que lo requiera llame a dicha funcion
    > NOTAR que la funcion al pasarse por parametro viene definida desde afuera, desde donde se llame al MessageFieldBox
    > Todas las funciones como 'onFieldSubmitted', 'onChanged' son del tipo 'ValueChanged', estas reportan que un valor cambió
  */
  final ValueChanged<String> onValue;

  const MessageFieldBox({super.key, required this.onValue});

  @override
  Widget build(BuildContext context) {
    
    final colors = Theme.of(context).colorScheme;

    /* Comentario sobre: TextEditingController
      > El widget TextEditingController (un widget controlador, por eso controller) sirve para el comportameiento de la caja de texto
      > Me va a permitir cosas como borrar la caja de texto, obtener el valor que escrito dentro de ella, etc...
    */
    final textController = TextEditingController();

    final focusNode = FocusNode();

    final outlineInputBorder = UnderlineInputBorder(
        borderSide: BorderSide(color: colors.primary),
        borderRadius: BorderRadius.circular(20));

    final inputDecoration = InputDecoration(
      hintText: 'End your message with a ?',
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true,
      suffixIcon: IconButton(
        icon: const Icon(Icons.send),
        onPressed: () {
          final textValue = textController.value.text;
          // > llamada a la funcion de callback que enviará el mensaje
          onValue(textValue); 
          textController.clear();
          //focusNode.requestFocus();
          //print('Hice un onPressed');
        },
      ),
    );

    return TextFormField(
      onTapOutside: (event) {
        if (!focusNode.hasFocus) {
          //print('No tengo el foco :(');
        } else {
          focusNode.unfocus();
          //print('Tengo el foco e hice un unfocus');
        }
      },
      focusNode: focusNode,
      controller: textController,
      decoration: inputDecoration,
      onFieldSubmitted: (value) {
        //print('Hice un submit valor: $value');
        // > llamada a la funcion de callback que enviará el mensaje
        onValue(value);
        textController.clear();
        focusNode.requestFocus();
      },
    );
  }
}
