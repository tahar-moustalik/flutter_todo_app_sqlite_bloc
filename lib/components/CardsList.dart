import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/bloc/tasks_bloc.dart';
import 'package:flutter_mobile_app/components/TaskCard.dart';
import 'package:flutter_mobile_app/models/Task.dart';

class CardsList extends StatelessWidget {
  // init tasks Bloc
  final TasksBloc tasksBloc;

  final AsyncSnapshot<List<Task>> snapshot;

  CardsList({this.snapshot,this.tasksBloc});

  @override
  Widget build(BuildContext context) {
    return getCardsListView(snapshot);
  }

  Widget getCardsListView(AsyncSnapshot<List<Task>> snapshot) {
    if (snapshot.hasData) {
      print("data $snapshot.data");
      return snapshot.data.length != 0
          ? ListView.builder(
              itemCount: snapshot.data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => TaskCard(
                task: snapshot.data[index],
                tasksBloc: this.tasksBloc,
              ),
            )
          : Center(child: Text('No Data'));
    } else {
      return Center(child: CircularProgressIndicator(value: null));
    }
  }
}
