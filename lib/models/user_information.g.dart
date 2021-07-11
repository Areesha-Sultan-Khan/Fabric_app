// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_information.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserInformationAdapter extends TypeAdapter<UserInformation> {
  @override
  final int typeId = 2;

  @override
  UserInformation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInformation(
      email: fields[0] as String,
      first_name: fields[1] as String,
      last_name: fields[2] as String,
      address: fields[3] as String,
      city: fields[4] as String,
      country: fields[5] as String,
      postal_code: fields[6] as int,
      phone: fields[7] as int,
      id: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserInformation obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.first_name)
      ..writeByte(2)
      ..write(obj.last_name)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.city)
      ..writeByte(5)
      ..write(obj.country)
      ..writeByte(6)
      ..write(obj.postal_code)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInformationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
