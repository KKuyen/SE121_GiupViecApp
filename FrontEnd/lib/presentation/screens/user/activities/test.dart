import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/presentation/bloc/get_all_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/get_all_task_state.dart';
import 'package:se121_giupviec_app/presentation/screens/navigation/navigation.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/activity.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  void initState() {
    super.initState();
    final taskCubit = BlocProvider.of<TaskCubit>(context).getAllTasks(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return Center(
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Center(
                      child: Container(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator()))),
            );
          } else if (state is TaskSuccess) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return ListTile(
                  title: Text(task.note),
                  subtitle: Text(task.id.toString()),
                );
              },
            );
          } else if (state is TaskError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No tasks found'));
          }
        },
      ),
    );
  }
}
