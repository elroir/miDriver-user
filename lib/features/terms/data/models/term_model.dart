import '../../domain/entities/term.dart';

class TermModel extends Term{
  TermModel({required super.id, required super.description, required super.descriptionExtended, required super.updatedAt});

  factory TermModel.fromJson(Map<String,dynamic> json) => TermModel(
    id: json['id'],
    description: json['description'],
    descriptionExtended: json['description_ext'],
    updatedAt: json['date_updated'] !=null ? DateTime.parse(json['date_updated']) : DateTime.parse(json['date_created'])
  );
}