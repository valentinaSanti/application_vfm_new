// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DistancesDao? _distancesDaoInstance;

  FootStepsDao? _footstepsDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Distance` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `value` REAL, `dateTime` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FootStep` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `value` REAL, `dateTime` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DistancesDao get distancesDao {
    return _distancesDaoInstance ??= _$DistancesDao(database, changeListener);
  }

  @override
  FootStepsDao get footstepsDao {
    return _footstepsDaoInstance ??= _$FootStepsDao(database, changeListener);
  }
}

class _$DistancesDao extends DistancesDao {
  _$DistancesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _distanceInsertionAdapter = InsertionAdapter(
            database,
            'Distance',
            (Distance item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _distanceDeletionAdapter = DeletionAdapter(
            database,
            'Distance',
            ['id'],
            (Distance item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Distance> _distanceInsertionAdapter;

  final DeletionAdapter<Distance> _distanceDeletionAdapter;

  @override
  Future<List<Distance>> findAllDistances() async {
    return _queryAdapter.queryList('SELECT * FROM Distance',
        mapper: (Map<String, Object?> row) => Distance(
            id: row['id'] as int?,
            value: row['value'] as double?,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<List<Distance>> findDistancebyDate(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Distance WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => Distance(id: row['id'] as int?, value: row['value'] as double?, dateTime: _dateTimeConverter.decode(row['dateTime'] as int)),
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<double?>> DataDistance(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT value FROM Distance WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => row.values.first as double,
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<Distance?> findFirstDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Distance ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => Distance(
            id: row['id'] as int?,
            value: row['value'] as double?,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<Distance?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Distance ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => Distance(
            id: row['id'] as int?,
            value: row['value'] as double?,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<void> insertDistance(Distance distances) async {
    await _distanceInsertionAdapter.insert(distances, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteDistance(Distance distances) async {
    await _distanceDeletionAdapter.delete(distances);
  }
}

class _$FootStepsDao extends FootStepsDao {
  _$FootStepsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _footStepInsertionAdapter = InsertionAdapter(
            database,
            'FootStep',
            (FootStep item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _footStepDeletionAdapter = DeletionAdapter(
            database,
            'FootStep',
            ['id'],
            (FootStep item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FootStep> _footStepInsertionAdapter;

  final DeletionAdapter<FootStep> _footStepDeletionAdapter;

  @override
  Future<List<FootStep>> findAllStep() async {
    return _queryAdapter.queryList('SELECT * FROM FootStep',
        mapper: (Map<String, Object?> row) => FootStep(
            row['id'] as int?,
            row['value'] as double?,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<List<FootStep>> findStepbyDate(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM FootStep WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => FootStep(row['id'] as int?, row['value'] as double?, _dateTimeConverter.decode(row['dateTime'] as int)),
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<double?> sumFootStep(DateTime dataTime) async {
    return _queryAdapter.query(
        'SELECT SUM(value) FROM FootStep WHERE dateTime= ?1',
        mapper: (Map<String, Object?> row) => row.values.first as double,
        arguments: [_dateTimeConverter.encode(dataTime)]);
  }

  @override
  Future<FootStep?> findFirstDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM FootStep ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => FootStep(
            row['id'] as int?,
            row['value'] as double?,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<FootStep?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM FootStep ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => FootStep(
            row['id'] as int?,
            row['value'] as double?,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<List<double?>> dataFootStep(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT value FROM  FootStep WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => row.values.first as double,
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<void> insertFootStep(FootStep footStep) async {
    await _footStepInsertionAdapter.insert(footStep, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteFootStep(FootStep footStep) async {
    await _footStepDeletionAdapter.delete(footStep);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
