import 'dart:convert';

import '../features/assignments/models/assignment_model.dart';
import 'local_storage_service.dart';

/// Repository responsible for loading and saving [Assignment]s.
///
/// This is a very small abstraction on top of [LocalStorageService] so that
/// multiple features (dashboard, risk status, assignments tab) can share
/// the same source of truth.
class AssignmentsRepository {
  AssignmentsRepository._();

  static final AssignmentsRepository instance = AssignmentsRepository._();

  Future<List<Assignment>> loadAssignments() async {
    final storage = await LocalStorageService.init();
    final jsonString = storage.getAssignmentsJson();
    if (jsonString == null || jsonString.isEmpty) {
      return <Assignment>[];
    }

    try {
      final decoded = jsonDecode(jsonString) as List<dynamic>;
      return decoded
          .map((item) => Assignment.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      // If parsing fails for any reason, return an empty list rather than crash.
      return <Assignment>[];
    }
  }

  Future<void> saveAssignments(List<Assignment> assignments) async {
    final storage = await LocalStorageService.init();
    final encoded =
        jsonEncode(assignments.map((assignment) => assignment.toJson()).toList());
    await storage.setAssignmentsJson(encoded);
  }

  Future<void> upsertAssignment(Assignment assignment) async {
    final current = await loadAssignments();
    final existingIndex =
        current.indexWhere((element) => element.id == assignment.id);
    if (existingIndex >= 0) {
      current[existingIndex] = assignment;
    } else {
      current.add(assignment);
    }
    await saveAssignments(current);
  }

  Future<void> deleteAssignment(String id) async {
    final current = await loadAssignments();
    current.removeWhere((element) => element.id == id);
    await saveAssignments(current);
  }

  /// Returns the completion ratio (0–1) for all assignments currently stored.
  Future<double> completionRatio() async {
    final current = await loadAssignments();
    if (current.isEmpty) return 0;
    final completed =
        current.where((assignment) => assignment.isCompleted).length;
    return completed / current.length;
  }

  /// Returns assignments that are due between [from] (inclusive) and [to] (exclusive).
  Future<List<Assignment>> assignmentsDueBetween(
    DateTime from,
    DateTime to,
  ) async {
    final current = await loadAssignments();
    final filtered = current.where(
      (a) =>
          !a.dueDate.isBefore(from) &&
          a.dueDate.isBefore(to) &&
          !a.isCompleted,
    );
    final result = List<Assignment>.from(filtered);
    result.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return result;
  }
}

