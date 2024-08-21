import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/network_Response.dart';
import 'package:task_manager_project/data/models/taskModel.dart';
import 'package:task_manager_project/data/networkUtilities/urls.dart';
import 'package:task_manager_project/data/network_caller/network_caller.dart';
import 'package:task_manager_project/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager_project/ui/widgets/snackbarMessage.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.taskModel,
    required this.onUpdateTask,
  });

  final TaskModel taskModel;
  final VoidCallback onUpdateTask;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _DeleteInProgress = false;
  bool _editInProgress = false;
  String dropDownValue = '';
  List<String> statusList = ['New', 'Completed','Progress','Cancelled'];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        title: Text(widget.taskModel.title ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.description ?? ''),
            Text(
              widget.taskModel.createdDate ?? 'New',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: const Text('New'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                ),
                ButtonBar(
                  children: [
                    Visibility(
                      visible: _DeleteInProgress == false,
                      replacement: const CenterProgressIndicator(),
                      child: IconButton(
                          onPressed: () {
                            _deleteTask();
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.edit),
                      onSelected: (String selectedValue) {
                        dropDownValue = selectedValue;
                        _editItem(dropDownValue);
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return statusList.map((String value) {
                          return PopupMenuItem<String>(
                            value: value,
                            child: ListTile(
                              title: Text(value),
                              trailing: dropDownValue == value
                                  ? const Icon(Icons.done)
                                  : null,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _deleteTask() async {
    _DeleteInProgress = true;

    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetWorkCaller.getRequest(Urls.deleteItem(widget.taskModel.sId!));

    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      widget.onUpdateTask();
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.erroMessage ?? 'Task Counter Failed,Try Again!!');
      }
    }

    _DeleteInProgress = false;

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _editItem(String statusValue) async {
    _editInProgress = true;

    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
    await NetWorkCaller.getRequest(Urls.editItem(widget.taskModel.sId!, statusValue));

    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      widget.onUpdateTask();
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.erroMessage ?? 'Task Counter Failed,Try Again!!');
      }
    }

    _editInProgress = false;

    if (mounted) {
      setState(() {});
    }
  }
}
