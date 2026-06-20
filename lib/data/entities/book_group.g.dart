// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookGroup _$BookGroupFromJson(Map<String, dynamic> json) => BookGroup(
  groupId: (json['groupId'] as num).toInt(),
  groupName: json['groupName'] as String,
  order: (json['order'] as num?)?.toInt() ?? 0,
  show: json['show'] as bool? ?? true,
);

Map<String, dynamic> _$BookGroupToJson(BookGroup instance) => <String, dynamic>{
  'groupId': instance.groupId,
  'groupName': instance.groupName,
  'order': instance.order,
  'show': instance.show,
};
