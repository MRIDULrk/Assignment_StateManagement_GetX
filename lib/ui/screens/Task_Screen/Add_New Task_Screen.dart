import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/network_Response.dart';
import 'package:task_manager_project/data/networkUtilities/urls.dart';
import 'package:task_manager_project/data/network_caller/network_caller.dart';
import 'package:task_manager_project/ui/widgets/Profile_App_Bar.dart';
import 'package:task_manager_project/ui/widgets/background_widget.dart';
import 'package:task_manager_project/ui/widgets/snackbarMessage.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  final TextEditingController titleTEcontroller = TextEditingController();
  final TextEditingController descriptionTEcontroller = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _inProgressAddTask = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: profileAppBar(context),
      body: BackgroundWidget(

        child:SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleTEcontroller,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Title.';
                      }
                      return null;
                    },


                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: descriptionTEcontroller,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Description.';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton(
                      onPressed: (){

                        if(_formkey.currentState!.validate()){

                          _addNewTask();



                        }

                  }, child: _inProgressAddTask? Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: const [
                      Text('Loading...',),
                      CircularProgressIndicator(color: Colors.white),
                    ],
                  ) : const Text('ADD'),
                  ),




                ],
              ),
            ),
          ),
        ) ,),

    );
  }

  Future<void> _addNewTask() async {

    _inProgressAddTask = true;

    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> requestInput = {

    "title":titleTEcontroller.text.trim(),
    "description":descriptionTEcontroller.text.trim(),
    "status":"New",

    };

    final  NetworkResponse response =
    await NetWorkCaller.postRequest(Urls.createTask,body:requestInput);

    _inProgressAddTask = false;

    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {

      clearTextField();


      if (mounted) {

        showSnackBarMessage(
            context,'New task Added!!');



      }
    } else {

      if(mounted){
        showSnackBarMessage(
            context,'New task Add Failed',true);
      }

    }
  }


  void clearTextField(){

    titleTEcontroller.clear();
    descriptionTEcontroller.clear();

  }

  @override
  void dispose() {
    titleTEcontroller.dispose();
    descriptionTEcontroller.dispose();
    super.dispose();
  }


}
