// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'features/user/domain/entities/user.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 876724216271185595),
      name: 'User',
      lastPropertyId: const IdUid(8, 7989531175013358560),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3981835727001539185),
            name: 'id',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 2967068233213927116),
            name: 'uid',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8480219527220067503),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 229921395162649685),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 1646890500361687384),
            name: 'address',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 528932034271143220),
            name: 'phoneNumber',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 560889973709126566),
            name: 'lastName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 7989531175013358560),
            name: 'imageUrl',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Shortcut for [Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [Store.new] for an explanation of all parameters.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// Returns the ObjectBox model definition for this project for use with
/// [Store.new].
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 876724216271185595),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    User: EntityDefinition<User>(
        model: _entities[0],
        toOneRelations: (User object) => [],
        toManyRelations: (User object) => {},
        getId: (User object) => object.id,
        setId: (User object, int id) {
          object.id = id;
        },
        objectToFB: (User object, fb.Builder fbb) {
          final uidOffset = fbb.writeString(object.uid);
          final nameOffset = fbb.writeString(object.name);
          final emailOffset = fbb.writeString(object.email);
          final addressOffset = fbb.writeString(object.address);
          final lastNameOffset = fbb.writeString(object.lastName);
          final imageUrlOffset = fbb.writeString(object.imageUrl);
          fbb.startTable(9);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, uidOffset);
          fbb.addOffset(2, nameOffset);
          fbb.addOffset(3, emailOffset);
          fbb.addOffset(4, addressOffset);
          fbb.addInt64(5, object.phoneNumber);
          fbb.addOffset(6, lastNameOffset);
          fbb.addOffset(7, imageUrlOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final uidParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final lastNameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 16, '');
          final emailParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 10, '');
          final addressParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 12, '');
          final imageUrlParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 18, '');
          final phoneNumberParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0);
          final object = User(
              id: idParam,
              uid: uidParam,
              name: nameParam,
              lastName: lastNameParam,
              email: emailParam,
              address: addressParam,
              imageUrl: imageUrlParam,
              phoneNumber: phoneNumberParam);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [User] entity fields to define ObjectBox queries.
class User_ {
  /// see [User.id]
  static final id = QueryIntegerProperty<User>(_entities[0].properties[0]);

  /// see [User.uid]
  static final uid = QueryStringProperty<User>(_entities[0].properties[1]);

  /// see [User.name]
  static final name = QueryStringProperty<User>(_entities[0].properties[2]);

  /// see [User.email]
  static final email = QueryStringProperty<User>(_entities[0].properties[3]);

  /// see [User.address]
  static final address = QueryStringProperty<User>(_entities[0].properties[4]);

  /// see [User.phoneNumber]
  static final phoneNumber =
      QueryIntegerProperty<User>(_entities[0].properties[5]);

  /// see [User.lastName]
  static final lastName = QueryStringProperty<User>(_entities[0].properties[6]);

  /// see [User.imageUrl]
  static final imageUrl = QueryStringProperty<User>(_entities[0].properties[7]);
}
