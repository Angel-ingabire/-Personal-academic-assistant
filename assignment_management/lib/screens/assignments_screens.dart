import 'package:flutter/material.dart';
import '../models/assignment.dart';
import '../utils/constants.dart'; 

class AssignmentsScreen extends StatefulWidget {
  @override
  _AssignmentsScreenState createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  
  List<Assignment> _assignments = [
    Assignment(
      id: '1', 
      title: 'Python Project', 
      courseName: 'Programming 1', 
      dueDate: DateTime.now().add(Duration(days: 2))
    ),
    Assignment(
      id: '2', 
      title: 'Linear Algebra Quiz', 
      courseName: 'Math', 
      dueDate: DateTime.now().add(Duration(days: 1))
    ),
    Assignment(
      id: '3', 
      title: 'Leadership Essay', 
      courseName: 'Leadership', 
      dueDate: DateTime.now().add(Duration(days: 5))
    ),
  ];

  
  void _addNewAssignment(String title, String course) {
    if (title.isEmpty || course.isEmpty) {
      return; 
    }
    
    setState(() {
      _assignments.add(Assignment(
        id: DateTime.now().toString(),
        title: title,
        courseName: course,
        dueDate: DateTime.now(),
      ));
    });
  }

  
  void _deleteAssignment(String id) {
    setState(() {
      _assignments.removeWhere((item) => item.id == id);
    });
  }

  
  void _startAddNewAssignment(BuildContext ctx) {
    final titleController = TextEditingController();
    final courseController = TextEditingController();

    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true, 
      backgroundColor: AppColors.cardNavy, 
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20, 
            left: 20, 
            right: 20, 
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "New Assignment", 
                style: TextStyle(
                  color: AppColors.accentYellow, 
                  fontSize: 20, 
                  fontWeight: FontWeight.bold
                )
              ),
              SizedBox(height: 10),
              TextField(
                controller: titleController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Assignment Title',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                ),
              ),
              TextField(
                controller: courseController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Course Name',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentYellow, 
                  foregroundColor: AppColors.primaryNavy,
                ),
                child: Text('Save Assignment', style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  _addNewAssignment(titleController.text, courseController.text);
                  Navigator.of(ctx).pop(); 
                },
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryNavy, 
      appBar: AppBar(
        title: Text("Assignments", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryNavy,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // THE YELLOW BUTTON
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentYellow,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () => _startAddNewAssignment(context),
                child: Text(
                  "Add New Assignment", 
                  style: TextStyle(
                    color: AppColors.primaryNavy, 
                    fontWeight: FontWeight.bold, 
                    fontSize: 16
                  )
                ),
              ),
            ),
          ),
          
          // THE LIST OF CARDS
          Expanded(
            child: ListView.builder(
              itemCount: _assignments.length,
              itemBuilder: (ctx, index) {
                final task = _assignments[index];
                return Card(
                  color: AppColors.cardNavy, 
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: Icon(Icons.assignment, color: Colors.white70),
                    title: Text(
                      task.title, 
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                    ),
                    subtitle: Text(
                      "${task.courseName} • Due soon", 
                      style: TextStyle(color: Colors.white54)
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => _deleteAssignment(task.id),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}