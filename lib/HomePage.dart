import 'package:bank/components.dart';
import 'package:bank/cubit/bank_cubit.dart';
import 'package:bank/cubit/states.dart';
import 'package:bank/transaction.dart';
import 'package:bank/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BankCubit, BankStates>(
      listener: (context, state) {},
      builder: (context, state) {
        BankCubit cubit = BankCubit.get(context);
        return Scaffold(
          //bottomSheet: BottomSheet(onClosing: onClosing, builder: builder),
          appBar: AppBar(
            title: Text(
              'Bank App',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemCount: cubit.result.length,
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.black45),
                            width: double.infinity,
                            height: 1.5,
                          ),
                        );
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            usermodel = UserModel.fromJson(cubit.result, index);
                            navigateTo(context, transaction());
                          },
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: 15, top: 10, bottom: 10, left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'name:${UserModel.fromJson(cubit.result, index).name}',
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        'age:${UserModel.fromJson(cubit.result, index).age}',
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'email:${UserModel.fromJson(cubit.result, index).email} ',
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        'account:${UserModel.fromJson(cubit.result, index).account}',
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

UserModel? usermodel;
