import 'package:bank/cubit/transaction_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionCubit extends Cubit<TransactionStates> {
  TransactionCubit() : super(TransactionInitState());

  static TransactionCubit get(context) => BlocProvider.of(context);




}