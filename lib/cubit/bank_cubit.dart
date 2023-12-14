import 'package:bank/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class BankCubit extends Cubit<BankStates> {
  BankCubit() : super(BankInitState());

  static BankCubit get(context) => BlocProvider.of(context);

  List names = [
    'first person',
    'second person',
    'third person',
    'fourth person',
    'fifth person',
    'sixth person',
    'seventh person',
    'eight person',
    'ninth person',
    'tenth person',
  ];
  List emails = [
    'firstperson@gmail.com',
    'secondperson@gmail.com',
    'thirdperson@gmail.com',
    'fourthperson@gmail.com',
    'fifthperson@gmail.com',
    'sixthperson@gmail.com',
    'seventhperson@gmail.com',
    'eightperson@gmail.com',
    'ninthperson@gmail.com',
    'tenthperson@gmail.com',
  ];
  List ages = [
    56,
    25,
    92,
    36,
    75,
    52,
    43,
    33,
    46,
    49,
  ];
  List<int> account = [
    25000,
    85000,
    75000,
    56000,
    96000,
    43000,
    85000,
    92000,
    100000,
    110000,
  ];

  Database? database;

  void createDatabase() {
    openDatabase(
      'Users.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE Users (id INTEGER PRIMARY KEY, name TEXT, email TEXT, age INTEGER, account INTEGER)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabase());
    });
  }

  updateData({
    required int? value,
    required int id,
  }) async {
    emit(TransactionLoadingState());
    int? currentValue = result[id - 1]['account'];
    print('This is current value $currentValue');
    int? userValue = result[0]['account'] - value;
    int? updatedValue = currentValue! + value!;
    database?.rawUpdate(
      'UPDATE Users SET account = ? WHERE id = ?',
      [updatedValue, id],
    ).then((value) {
      print('This is updated value $updatedValue');
      getDataFromDatabase(database);
    });
    database?.rawUpdate(
      'UPDATE Users SET account = ? WHERE id = ?',
      [userValue, 1],
    ).then((value) {
      print('This is user Value $userValue');
      getDataFromDatabase(database);
      emit(TransactionDoneState());
    }).catchError((error){
      print(error.toString());
      print(error.runtimeType);
    });

  }

  insertToDatabase({
    required name,
    required email,
    required ages,
    required account,
  }) async {
    emit(AppLoadingInsertInDatabase());
    await database?.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT INTO Users(name, email, age, account) VALUES("$name", "$email", "$ages", "$account")',
      )
          .then((value) {
        print('$value inserted successfully');
        getDataFromDatabase(database);
        emit(AppInsertInDatabase());
      }).catchError((error) {
        emit(AppErrorInsertInDatabase(error));
        print('Error When Inserting New Record ${error.toString()}');
        print('Error When Inserting New Record ${error.runtimeType}');
      });
    });
  }

  List result = [];

  void getDataFromDatabase(database) {
    emit(AppGetDataLoading());
    database.rawQuery('SELECT * FROM Users').then((value) {
      result = [];
      result.addAll(value);

      print('THIS IS THE LENGTH: ${result.length}');
      print(value);
      emit(AppGetDataFromDB());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database?.rawDelete('DELETE FROM users WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteFromDatabase());
    });
  }
}
