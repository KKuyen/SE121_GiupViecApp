import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/presentation/bloc/get_all_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/get_all_task_state.dart';
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
    return BlocListener<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is TaskLoading) {
          // Show loading dialog
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          // Hide loading dialog
          Navigator.of(context).pop();

          if (state is TaskSuccess) {
            // Navigate to home
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ActivityPage()),
            );
          } else if (state is TaskError) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Danh sách nhiệm vụ'),
        ),
        body: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TaskSuccess) {
              final tasks = state.tasks;
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(task.id as String),
                  );
                },
              );
            } else if (state is TaskError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('No tasks available.'));
            }
          },
        ),
      ),
    );
  }
}
