// To parse this JSON data, do
//
//     final yesNoModel = yesNoModelFromJson(jsonString);

import 'package:yes_no_app/domain/entities/message.dart';
//> Para poder utilizar yesNoModelFromJson y yesNoModelToJson
//import 'dart:convert';

//> Para este caso no lo precisamos. Instancia la clase a partir de un json
//YesNoModel yesNoModelFromJson(String str) => YesNoModel.fromJsonMap(json.decode(str));

//> Para este caso no lo precisamos. Devuelve un string en formato json 
//> a partir de una instancia de la clase
//String yesNoModelToJson(YesNoModel data) => json.encode(data.toJson());

class YesNoModel {
  final String answer;
  final bool forced;
  final String image;

  YesNoModel({
    required this.answer,
    required this.forced,
    required this.image,
  });

  factory YesNoModel.fromJsonMap(Map<String, dynamic> json) => YesNoModel(
        answer: json["answer"],
        forced: json["forced"],
        image: json["image"],
      );  
  
  Map<String, dynamic> toJson() => {
        "answer": answer,
        "forced": forced,
        "image": image,
      };

  Message toMessageEntity() => Message(
        text: answer == 'yes' ? 'Si' : 'No',
        fromWho: FromWho.her,
        imageUrl: image,
      );
}



// > Como lo habiamos hecho manualmente
// class YesNoModel {
  
//   // > properties
//   String answer;
//   bool forced;
//   String image;

//   // > Constructor por defecto
//   YesNoModel({required this.answer, required this.forced, required this.image});

//   // > Constructor con nombre (se debe poner la palabra ' factory para que devuelvea una instancia de la clase )
//   factory YesNoModel.fromJsonMap(Map<String, dynamic> json) => YesNoModel(
//         answer: json['answer'],
//         forced: json['forced'],
//         image: json['image'],
//       );
// }
