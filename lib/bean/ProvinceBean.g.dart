// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProvinceBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProvinceBean _$ProvinceBeanFromJson(Map<String, dynamic> json) {
  return ProvinceBean(
    province: (json['province'] as List).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$ProvinceBeanToJson(ProvinceBean instance) =>
    <String, dynamic>{
      'province': instance.province,
    };
