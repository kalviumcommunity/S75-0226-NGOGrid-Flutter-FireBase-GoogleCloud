import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event_model.dart';
import '../models/task_model.dart';
import '../models/comment_model.dart';
import '../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // --- Users ---
  Stream<List<UserModel>> getVolunteers() {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'volunteer')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>)).toList());
  }

  // --- Events ---
  Future<void> createEvent(EventModel event) async {
    await _firestore.collection('events').doc(event.id).set(event.toMap());
  }

  Stream<List<EventModel>> getEvents() {
    return _firestore.collection('events').orderBy('date').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => EventModel.fromMap(doc.data() as Map<String, dynamic>))
              .toList(),
        );
  }

  // --- Tasks ---
  Future<void> createTask(TaskModel task) async {
    await _firestore.collection('tasks').doc(task.id).set(task.toMap());
  }

  Stream<List<TaskModel>> getTasksForEvent(String eventId) {
    return _firestore
        .collection('tasks')
        .where('eventId', isEqualTo: eventId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => TaskModel.fromMap(doc.data() as Map<String, dynamic>)).toList());
  }

  Stream<List<TaskModel>> getTasksForVolunteer(String volunteerId) {
    return _firestore
        .collection('tasks')
        .where('assignedTo', isEqualTo: volunteerId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => TaskModel.fromMap(doc.data() as Map<String, dynamic>)).toList());
  }

  Future<void> updateTaskStatus(String taskId, TaskStatus status) async {
    await _firestore.collection('tasks').doc(taskId).update({
      'status': status.toString().split('.').last,
    });
  }

  Future<void> assignTaskToVolunteer(String taskId, String volunteerId) async {
    await _firestore.collection('tasks').doc(taskId).update({
      'assignedTo': volunteerId,
    });
  }

  // --- Comments ---
  Future<void> addComment(CommentModel comment) async {
    await _firestore.collection('comments').doc(comment.id).set(comment.toMap());
  }

  Stream<List<CommentModel>> getCommentsForTask(String taskId) {
    return _firestore
        .collection('comments')
        .where('taskId', isEqualTo: taskId)
        .orderBy('createdAt')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CommentModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }
}
