enum TaskStatus { pending, inProgress, completed }

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String eventId;
  final String? assignedTo; // UID of volunteer
  final TaskStatus status;
  final DateTime deadline;
  final DateTime createdAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.eventId,
    this.assignedTo,
    required this.status,
    required this.deadline,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'eventId': eventId,
      'assignedTo': assignedTo,
      'status': status.toString().split('.').last,
      'deadline': deadline.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      eventId: map['eventId'] ?? '',
      assignedTo: map['assignedTo'],
      status: _parseStatus(map['status']),
      deadline: DateTime.parse(map['deadline']),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  static TaskStatus _parseStatus(String? status) {
    switch (status) {
      case 'inProgress':
        return TaskStatus.inProgress;
      case 'completed':
        return TaskStatus.completed;
      default:
        return TaskStatus.pending;
    }
  }
}
