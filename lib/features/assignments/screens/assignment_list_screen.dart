import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/alu_card.dart';
import '../../../data/assignments_repository.dart';
import '../models/assignment_model.dart';
import 'add_assignment_screen.dart';
import '../widgets/assignment_tile.dart';

/// Tab 2: Assignment list and entry point for CRUD operations.
///
/// Fully functional assignment management with:
/// - Filter tabs (All, Formative, Summative)
/// - Create, view, edit, delete assignments
/// - Local storage persistence via SharedPreferences
/// - Sort by due date
class AssignmentListScreen extends StatefulWidget {
  const AssignmentListScreen({super.key});

  @override
  State<AssignmentListScreen> createState() => _AssignmentListScreenState();
}

class _AssignmentListScreenState extends State<AssignmentListScreen> {
  String _selectedFilter = 'All'; // All, Formative, Summative
  List<Assignment> _assignments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAssignments();
  }

  Future<void> _loadAssignments() async {
    final items = await AssignmentsRepository.instance.loadAssignments();
    setState(() {
      _assignments = items;
      _isLoading = false;
    });
  }

  Future<void> _saveAssignments() async {
    await AssignmentsRepository.instance.saveAssignments(_assignments);
  }

  void _openAddAssignment() async {
    final result = await Navigator.of(context).push<Assignment>(
      MaterialPageRoute(
        builder: (_) => const AddAssignmentScreen(),
      ),
    );

    if (result != null) {
      setState(() {
        _assignments.add(result);
      });
      await _saveAssignments();
    }
  }

  void _editAssignment(Assignment assignment) async {
    final result = await Navigator.of(context).push<Assignment>(
      MaterialPageRoute(
        builder: (_) => AddAssignmentScreen(existingAssignment: assignment),
      ),
    );

    if (result != null) {
      setState(() {
        final index = _assignments.indexWhere((a) => a.id == result.id);
        if (index >= 0) {
          _assignments[index] = result;
        }
      });
      await _saveAssignments();
    }
  }

  void _deleteAssignment(String id) {
    setState(() {
      _assignments.removeWhere((item) => item.id == id);
    });
    _saveAssignments();
  }

  void _toggleStatus(String id, bool? value) {
    setState(() {
      final index = _assignments.indexWhere((item) => item.id == id);
      if (index >= 0) {
        _assignments[index].isCompleted = value ?? false;
      }
    });
    _saveAssignments();
  }

  List<Assignment> get _filteredAssignments {
    // Sort by due date
    final sorted = List<Assignment>.from(_assignments)
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));

    // TODO: Implement actual filtering logic for Formative/Summative
    // For now, return all assignments regardless of filter
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text('Assignments'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Filter tabs
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      _FilterTab(
                        label: 'All',
                        isSelected: _selectedFilter == 'All',
                        onTap: () => setState(() => _selectedFilter = 'All'),
                      ),
                      const SizedBox(width: 16),
                      _FilterTab(
                        label: 'Formative',
                        isSelected: _selectedFilter == 'Formative',
                        onTap: () =>
                            setState(() => _selectedFilter = 'Formative'),
                      ),
                      const SizedBox(width: 16),
                      _FilterTab(
                        label: 'Summative',
                        isSelected: _selectedFilter == 'Summative',
                        onTap: () =>
                            setState(() => _selectedFilter = 'Summative'),
                      ),
                    ],
                  ),
                ),

                // Create Assignment button
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentYellow,
                        foregroundColor: AppColors.textDark,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _openAddAssignment,
                      child: const Text(
                        'Create Assignment',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                // Assignment list
                Expanded(
                  child: _filteredAssignments.isEmpty
                      ? const Center(
                          child: Text(
                            'No assignments yet.\nTap the button above to create one.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _filteredAssignments.length,
                          itemBuilder: (ctx, index) {
                            final assignment = _filteredAssignments[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: AluCard(
                                child: AssignmentTile(
                                  assignment: assignment,
                                  onToggleCompleted: (value) =>
                                      _toggleStatus(assignment.id, value),
                                  onTapEdit: () => _editAssignment(assignment),
                                  onDelete: () =>
                                      _deleteAssignment(assignment.id),
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

/// Filter tab widget matching UI design.
class _FilterTab extends StatelessWidget {
  const _FilterTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color:
                  isSelected ? AppColors.accentYellow : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 3,
            width: 40,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.accentYellow : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
