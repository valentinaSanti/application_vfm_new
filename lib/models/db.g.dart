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

  StepsDao? _stepsDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
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
            'CREATE TABLE IF NOT EXISTS `Step` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `value` REAL NOT NULL, `dateTime` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Distance` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `value` REAL NOT NULL, `dateTime` INTEGER NOT NULL)');

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
  StepsDao get stepsDao {
    return _stepsDaoInstance ??= _$StepsDao(database, changeListener);
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
    return _queryAdapter.queryList('SELECT * FROM distance',
        mapper: (Map<String, Object?> row) => Distance(
            id: row['id'] as int?,
            value: row['value'] as double,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<Distance?> findFirstDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Distance ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => Distance(
            id: row['id'] as int?,
            value: row['value'] as double,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<Distance?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Distance ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => Distance(
            id: row['id'] as int?,
            value: row['value'] as double,
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

class _$StepsDao extends StepsDao {
  _$StepsDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<Step>> findAllStep() async {
    return _queryAdapter.queryList('SELECT * FROM step',
        mapper: (Map<String, Object?> row) => Step(
            row['id'] as int?,
            row['value'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<Step?> findFirstDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Step ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => Step(
            row['id'] as int?,
            row['value'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<Step?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Step ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => Step(
            row['id'] as int?,
            row['value'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
