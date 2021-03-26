import 'package:freezed_annotation/freezed_annotation.dart';

import '../models.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address {
  factory Address(
    String? street,
    String? suite,
    String? city,
    String? zipcode,
    Geo? geo,
  ) = _Adress;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}
