import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import '../models/assignment.dart';
import '../utils/constants.dart';

class AssignmentsScreen extends StatefulWidget {
  const AssignmentsScreen({super.key});

  @override
  _AssignmentsScreenState createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> with SingleTickerProviderStateMixin {
  
  final List<Assignment> _assignments = [
    Assignment(
      id: '1',
      title: 'Assignment 1',
      courseName: 'Mobile Dev',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      priority: 'High',
    ),
    Assignment(
      id: '2',
      title: 'Group Project',
      courseName: 'Leadership',
      dueDate: DateTime.now().add(const Duration(days: 5)),
      priority: 'Medium',
    ),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); 
  }

  
  void _saveAssignment(String? id, String title, String course, DateTime date, String priority) {
    if (title.isEmpty) return;

    setState(() {
      if (id == null) {
        
        _assignments.add(Assignment(
          id: DateTime.now().toString(),
          title: title,
          courseName: course,
          dueDate: date,
          priority: priority,
        ));
      } else {
        
        final index = _assignments.indexWhere((a) => a.id == id);
        if (index >= 0) {
          _assignments[index] = Assignment(
            id: id,
            title: title,
            courseName: course,
            dueDate: date,
            priority: priority,
            isCompleted: _assignments[index].isCompleted,
          );
        }
      }
    });
  }

  
  void _deleteAssignment(String id) {
    setState(() {
      _assignments.removeWhere((item) => item.id == id);
    });
  }

  
  void _toggleStatus(String id) {
    setState(() {
      final index = _assignments.indexWhere((item) => item.id == id);
      if (index >= 0) {
        _assignments[index].isCompleted = !_assignments[index].isCompleted;
      }
    });
  }

  
  void _showAssignmentModal(BuildContext ctx, {Assignment? existingAssignment}) {
    final titleController = TextEditingController(text: existingAssignment?.title ?? '');
    final courseController = TextEditingController(text: existingAssignment?.courseName ?? '');
    DateTime selectedDate = existingAssignment?.dueDate ?? DateTime.now();
    String selectedPriority = existingAssignment?.priority ?? 'Medium';

    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: AppColors.cardNavy,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                top: 20, left: 20, right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    existingAssignment == null ? "New Assignment" : "Edit Assignment",
                    style: TextStyle(color: AppColors.accentYellow, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  
                  TextField(
                    controller: titleController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Assignment Title',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                    ),
                  ),
                  
                  TextField(
                    controller: courseController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Course Name',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  
                  DropdownButton<String>(
                    value: selectedPriority,
                    dropdownColor: AppColors.cardNavy,
                    style: const TextStyle(color: Colors.white),
                    items: ['High', 'Medium', 'Low'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setModalState(() {
                        selectedPriority = newValue!;
                      });
                    },
                  ),

                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Due: ${DateFormat('MMM dd').format(selectedDate)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      TextButton.icon(
                        icon: Icon(Icons.calendar_today, color: AppColors.accentYellow),
                        label: Text('Change Date', style: TextStyle(color: AppColors.accentYellow)),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030),
                          ).then((picked) {
                            if (picked == null) return;
                            setModalState(() {
                              selectedDate = picked;
                            });
                          });
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.accentYellow),
                      child: Text('Save Assignment', style: TextStyle(color: AppColors.primaryNavy, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        _saveAssignment(
                          existingAssignment?.id, 
                          titleController.text,
                          courseController.text,
                          selectedDate,
                          selectedPriority
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryNavy,
      appBar: AppBar(
        title: const Text("Assignments", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.primaryNavy,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.accentYellow,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          tabs: const [
            Tab(text: "All"),
            Tab(text: "Formative"),
            Tab(text: "Summative"),
          ],
        ),
      ),
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentYellow,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => _showAssignmentModal(context),
                child: Text("Create Group Assignment", style: TextStyle(color: AppColors.primaryNavy, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ),

          
          Expanded(
            child: ListView.builder(
              itemCount: _assignments.length,
              itemBuilder: (ctx, index) {
                final task = _assignments[index];
                return Card(
                  color: Colors.white, 
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    
                    leading: Checkbox(
                      value: task.isCompleted,
                      activeColor: AppColors.primaryNavy,
                      checkColor: Colors.white,
                      onChanged: (_) => _toggleStatus(task.id),
                    ),
                    
                    title: Text(
                      task.title,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text("Due ${DateFormat('MMM dd').format(task.dueDate)}", style: const TextStyle(color: Colors.black54)),
                        const SizedBox(height: 4),
                        
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.accentYellow.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            task.priority,
                            style: TextStyle(color: AppColors.primaryNavy, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.grey),
                          onPressed: () => _showAssignmentModal(context, existingAssignment: task),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => _deleteAssignment(task.id),
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
      
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primaryNavy,
        selectedItemColor: AppColors.accentYellow,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Statements'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Quizzes'),
          BottomNavigationBarItem(icon: Icon(Icons.pending_actions), label: 'Pending'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}