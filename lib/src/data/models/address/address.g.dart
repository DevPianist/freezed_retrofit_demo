// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Adress _$_$_AdressFromJson(Map<String, dynamic> json) {
  return _$_Adress(
    json['street'] as String?,
    json['suite'] as String?,
    json['city'] as String?,
    json['zipcode'] as String?,
    json['geo'] == null
        ? null
        : Geo.fromJson(json['geo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_AdressToJson(_$_Adress instance) => <String, dynamic>{
      'street': instance.street,
      'suite': instance.suite,
      'city': instance.city,
      'zipcode': instance.zipcode,
      'geo': instance.geo,
    };
