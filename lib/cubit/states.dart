abstract class BankStates{}

class BankInitState extends BankStates{}
class BankLoadingState extends BankStates{}
class BankDoneState extends BankStates{}
class BankErrorState extends BankStates{
final error;
  BankErrorState(this.error);
}

class BankUpdateLoadingState extends BankStates{}
class BankUpdateDoneState extends BankStates{}
class BankUpdateErrorState extends BankStates{
  final error;
  BankUpdateErrorState(this.error);
}

class AppCreateDatabase extends BankStates{}
class AppInsertInDatabase extends BankStates{}
class AppLoadingInsertInDatabase extends BankStates{}
class AppErrorInsertInDatabase extends BankStates{
  final error;
  AppErrorInsertInDatabase(this.error);
}
class AppGetDataLoading extends BankStates{}
class AppGetDataFromDB extends BankStates{}
class AppUpdateDatabase extends BankStates{}
class AppDeleteFromDatabase extends BankStates{}

class TransactionLoadingState extends BankStates{}
class TransactionDoneState extends BankStates{}
class TransactionErrorState extends BankStates{}