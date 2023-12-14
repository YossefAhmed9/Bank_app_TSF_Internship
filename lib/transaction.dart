import 'package:bank/HomePage.dart';
import 'package:bank/cubit/bank_cubit.dart';
import 'package:bank/cubit/transaction_cubit.dart';
import 'package:bank/cubit/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components.dart';

class transaction extends StatelessWidget {
  transaction({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    int? transaction;
    return BlocConsumer<TransactionCubit,TransactionStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TransactionCubit cubit=TransactionCubit();
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Transactions'),
          ),
          body: Column(
            children: [
              Column(
                children: [
                  Text(
                    '${usermodel?.name}',
                    style: TextStyle(fontSize: 25),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: defaultTextFormField(
                        TextInputType.number, textController, (value) {},
                        (value) {
                      transaction = int.parse(value!);
                      print(transaction);
                    }, () {}, 'Enter the amount of money',
                        Icon(Icons.monetization_on_outlined), (value) => null),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: defaultButton(150, 50, Colors.transparent, () {
                        BankCubit.get(context).updateData(value: transaction, id: usermodel!.id);
                        print('هنا اهو');
                        print(usermodel!.id);
                        Navigator.pop(context);
                        //print(textController);
                      }, 'Pay Now', Colors.white)),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
