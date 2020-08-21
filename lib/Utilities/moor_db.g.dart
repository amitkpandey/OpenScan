// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class MasterData extends DataClass implements Insertable<MasterData> {
  final String directoryName;
  final String directoryPath;
  final String created;
  final String lastModified;
  final String imagePath;
  final int idx;
  MasterData(
      {@required this.directoryName,
      @required this.directoryPath,
      @required this.created,
      @required this.lastModified,
      @required this.imagePath,
      this.idx});
  factory MasterData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return MasterData(
      directoryName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}directory_name']),
      directoryPath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}directory_path']),
      created:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}created']),
      lastModified: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}last_modified']),
      imagePath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_path']),
      idx: intType.mapFromDatabaseResponse(data['${effectivePrefix}idx']),
    );
  }
  factory MasterData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return MasterData(
      directoryName: serializer.fromJson<String>(json['directoryName']),
      directoryPath: serializer.fromJson<String>(json['directoryPath']),
      created: serializer.fromJson<String>(json['created']),
      lastModified: serializer.fromJson<String>(json['lastModified']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      idx: serializer.fromJson<int>(json['idx']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'directoryName': serializer.toJson<String>(directoryName),
      'directoryPath': serializer.toJson<String>(directoryPath),
      'created': serializer.toJson<String>(created),
      'lastModified': serializer.toJson<String>(lastModified),
      'imagePath': serializer.toJson<String>(imagePath),
      'idx': serializer.toJson<int>(idx),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<MasterData>>(bool nullToAbsent) {
    return MasterCompanion(
      directoryName: directoryName == null && nullToAbsent
          ? const Value.absent()
          : Value(directoryName),
      directoryPath: directoryPath == null && nullToAbsent
          ? const Value.absent()
          : Value(directoryPath),
      created: created == null && nullToAbsent
          ? const Value.absent()
          : Value(created),
      lastModified: lastModified == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModified),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      idx: idx == null && nullToAbsent ? const Value.absent() : Value(idx),
    ) as T;
  }

  MasterData copyWith(
          {String directoryName,
          String directoryPath,
          String created,
          String lastModified,
          String imagePath,
          int idx}) =>
      MasterData(
        directoryName: directoryName ?? this.directoryName,
        directoryPath: directoryPath ?? this.directoryPath,
        created: created ?? this.created,
        lastModified: lastModified ?? this.lastModified,
        imagePath: imagePath ?? this.imagePath,
        idx: idx ?? this.idx,
      );
  @override
  String toString() {
    return (StringBuffer('MasterData(')
          ..write('directoryName: $directoryName, ')
          ..write('directoryPath: $directoryPath, ')
          ..write('created: $created, ')
          ..write('lastModified: $lastModified, ')
          ..write('imagePath: $imagePath, ')
          ..write('idx: $idx')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      directoryName.hashCode,
      $mrjc(
          directoryPath.hashCode,
          $mrjc(
              created.hashCode,
              $mrjc(lastModified.hashCode,
                  $mrjc(imagePath.hashCode, idx.hashCode))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is MasterData &&
          other.directoryName == directoryName &&
          other.directoryPath == directoryPath &&
          other.created == created &&
          other.lastModified == lastModified &&
          other.imagePath == imagePath &&
          other.idx == idx);
}

class MasterCompanion extends UpdateCompanion<MasterData> {
  final Value<String> directoryName;
  final Value<String> directoryPath;
  final Value<String> created;
  final Value<String> lastModified;
  final Value<String> imagePath;
  final Value<int> idx;
  const MasterCompanion({
    this.directoryName = const Value.absent(),
    this.directoryPath = const Value.absent(),
    this.created = const Value.absent(),
    this.lastModified = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.idx = const Value.absent(),
  });
  MasterCompanion copyWith(
      {Value<String> directoryName,
      Value<String> directoryPath,
      Value<String> created,
      Value<String> lastModified,
      Value<String> imagePath,
      Value<int> idx}) {
    return MasterCompanion(
      directoryName: directoryName ?? this.directoryName,
      directoryPath: directoryPath ?? this.directoryPath,
      created: created ?? this.created,
      lastModified: lastModified ?? this.lastModified,
      imagePath: imagePath ?? this.imagePath,
      idx: idx ?? this.idx,
    );
  }
}

class $MasterTable extends Master with TableInfo<$MasterTable, MasterData> {
  final GeneratedDatabase _db;
  final String _alias;
  $MasterTable(this._db, [this._alias]);
  final VerificationMeta _directoryNameMeta =
      const VerificationMeta('directoryName');
  GeneratedTextColumn _directoryName;
  @override
  GeneratedTextColumn get directoryName =>
      _directoryName ??= _constructDirectoryName();
  GeneratedTextColumn _constructDirectoryName() {
    return GeneratedTextColumn('directory_name', $tableName, false,
        minTextLength: 1, maxTextLength: 200);
  }

  final VerificationMeta _directoryPathMeta =
      const VerificationMeta('directoryPath');
  GeneratedTextColumn _directoryPath;
  @override
  GeneratedTextColumn get directoryPath =>
      _directoryPath ??= _constructDirectoryPath();
  GeneratedTextColumn _constructDirectoryPath() {
    return GeneratedTextColumn('directory_path', $tableName, false,
        minTextLength: 1, maxTextLength: 200);
  }

  final VerificationMeta _createdMeta = const VerificationMeta('created');
  GeneratedTextColumn _created;
  @override
  GeneratedTextColumn get created => _created ??= _constructCreated();
  GeneratedTextColumn _constructCreated() {
    return GeneratedTextColumn('created', $tableName, false,
        minTextLength: 1, maxTextLength: 200);
  }

  final VerificationMeta _lastModifiedMeta =
      const VerificationMeta('lastModified');
  GeneratedTextColumn _lastModified;
  @override
  GeneratedTextColumn get lastModified =>
      _lastModified ??= _constructLastModified();
  GeneratedTextColumn _constructLastModified() {
    return GeneratedTextColumn('last_modified', $tableName, false,
        minTextLength: 1, maxTextLength: 200);
  }

  final VerificationMeta _imagePathMeta = const VerificationMeta('imagePath');
  GeneratedTextColumn _imagePath;
  @override
  GeneratedTextColumn get imagePath => _imagePath ??= _constructImagePath();
  GeneratedTextColumn _constructImagePath() {
    return GeneratedTextColumn('image_path', $tableName, false,
        minTextLength: 1, maxTextLength: 200);
  }

  final VerificationMeta _idxMeta = const VerificationMeta('idx');
  GeneratedIntColumn _idx;
  @override
  GeneratedIntColumn get idx => _idx ??= _constructIdx();
  GeneratedIntColumn _constructIdx() {
    return GeneratedIntColumn(
      'idx',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [directoryName, directoryPath, created, lastModified, imagePath, idx];
  @override
  $MasterTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'master';
  @override
  final String actualTableName = 'master';
  @override
  VerificationContext validateIntegrity(MasterCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.directoryName.present) {
      context.handle(
          _directoryNameMeta,
          directoryName.isAcceptableValue(
              d.directoryName.value, _directoryNameMeta));
    } else if (directoryName.isRequired && isInserting) {
      context.missing(_directoryNameMeta);
    }
    if (d.directoryPath.present) {
      context.handle(
          _directoryPathMeta,
          directoryPath.isAcceptableValue(
              d.directoryPath.value, _directoryPathMeta));
    } else if (directoryPath.isRequired && isInserting) {
      context.missing(_directoryPathMeta);
    }
    if (d.created.present) {
      context.handle(_createdMeta,
          created.isAcceptableValue(d.created.value, _createdMeta));
    } else if (created.isRequired && isInserting) {
      context.missing(_createdMeta);
    }
    if (d.lastModified.present) {
      context.handle(
          _lastModifiedMeta,
          lastModified.isAcceptableValue(
              d.lastModified.value, _lastModifiedMeta));
    } else if (lastModified.isRequired && isInserting) {
      context.missing(_lastModifiedMeta);
    }
    if (d.imagePath.present) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableValue(d.imagePath.value, _imagePathMeta));
    } else if (imagePath.isRequired && isInserting) {
      context.missing(_imagePathMeta);
    }
    if (d.idx.present) {
      context.handle(_idxMeta, idx.isAcceptableValue(d.idx.value, _idxMeta));
    } else if (idx.isRequired && isInserting) {
      context.missing(_idxMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {imagePath};
  @override
  MasterData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MasterData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(MasterCompanion d) {
    final map = <String, Variable>{};
    if (d.directoryName.present) {
      map['directory_name'] =
          Variable<String, StringType>(d.directoryName.value);
    }
    if (d.directoryPath.present) {
      map['directory_path'] =
          Variable<String, StringType>(d.directoryPath.value);
    }
    if (d.created.present) {
      map['created'] = Variable<String, StringType>(d.created.value);
    }
    if (d.lastModified.present) {
      map['last_modified'] = Variable<String, StringType>(d.lastModified.value);
    }
    if (d.imagePath.present) {
      map['image_path'] = Variable<String, StringType>(d.imagePath.value);
    }
    if (d.idx.present) {
      map['idx'] = Variable<int, IntType>(d.idx.value);
    }
    return map;
  }

  @override
  $MasterTable createAlias(String alias) {
    return $MasterTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(const SqlTypeSystem.withDefaults(), e);
  $MasterTable _master;
  $MasterTable get master => _master ??= $MasterTable(this);
  @override
  List<TableInfo> get allTables => [master];
}
