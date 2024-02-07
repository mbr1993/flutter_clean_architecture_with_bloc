// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsersModelAdapter extends TypeAdapter<UsersModel> {
  @override
  final int typeId = 0;

  @override
  UsersModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsersModel(
      page: fields[0] as int?,
      perPage: fields[1] as int?,
      total: fields[2] as int?,
      totalPages: fields[3] as int?,
      dataUser: (fields[4] as List?)?.cast<DataUser>(),
      support: fields[5] as Support?,
    );
  }

  @override
  void write(BinaryWriter writer, UsersModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.page)
      ..writeByte(1)
      ..write(obj.perPage)
      ..writeByte(2)
      ..write(obj.total)
      ..writeByte(3)
      ..write(obj.totalPages)
      ..writeByte(4)
      ..write(obj.dataUser)
      ..writeByte(5)
      ..write(obj.support);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
