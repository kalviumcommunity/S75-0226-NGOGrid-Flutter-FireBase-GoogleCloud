import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/user_provider.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';
import '../models/event_model.dart';
import '../models/task_model.dart';
import '../models/comment_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = userProvider.user;

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final size = MediaQuery.of(context).size;
    final isWeb = size.width > 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text("NGOGrid Dashboard"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                user.role == UserRole.admin ? "NGO Admin" : "Volunteer",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () async {
              await authService.logOut();
              userProvider.clearUser();
              if (mounted) {
                Navigator.pushReplacementNamed(context, '/');
              }
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context, user),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: user.role == UserRole.admin
              ? _buildAdminDashboard(user, isWeb)
              : _buildVolunteerDashboard(user, isWeb),
        ),
      ),
      floatingActionButton: user.role == UserRole.admin
          ? FloatingActionButton.extended(
              onPressed: () => _showCreateEventDialog(context, user.uid),
              icon: const Icon(Icons.add),
              label: const Text("NEW EVENT"),
            )
          : null,
    );
  }

  Widget _buildDrawer(BuildContext context, UserModel user) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                user.name[0].toUpperCase(),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_outlined),
            title: const Text("Overview"),
            selected: true,
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.event_outlined),
            title: const Text("All Events"),
            onTap: () {},
          ),
          if (user.role == UserRole.admin)
            ListTile(
              leading: const Icon(Icons.people_outline),
              title: const Text("Volunteers"),
              onTap: () {},
            ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text("Settings"),
            onTap: () {},
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildAdminDashboard(UserModel user, bool isWeb) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            "Active Campaigns",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Expanded(
          child: StreamBuilder<List<EventModel>>(
            stream: _firestoreService.getEvents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return _buildEmptyState("No events yet. Start by creating one!");
              }

              final events = snapshot.data!;
              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isWeb ? 3 : 1,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  mainAxisExtent: 200,
                ),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return _buildEventCard(event);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard(EventModel event) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _showEventTasks(context, event),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.event, color: Colors.green, size: 20),
                  ),
                  const Spacer(),
                  const Icon(Icons.more_vert, size: 20, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                event.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                event.location,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 14, color: Colors.grey[400]),
                  const SizedBox(width: 4),
                  Text(
                    event.date.toString().split(' ')[0],
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVolunteerDashboard(UserModel user, bool isWeb) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "My Assigned Tasks",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          StreamBuilder<List<TaskModel>>(
            stream: _firestoreService.getTasksForVolunteer(user.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: _buildEmptyState("No tasks assigned to you yet."),
                );
              }

              final tasks = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return _buildTaskListItem(task);
                },
              );
            },
          ),
          const Divider(height: 48, thickness: 1, indent: 24, endIndent: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Text(
              "Active Campaigns",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          StreamBuilder<List<EventModel>>(
            stream: _firestoreService.getEvents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: _buildEmptyState("No events available."),
                );
              }

              final events = snapshot.data!;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isWeb ? 3 : 1,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  mainAxisExtent: 200,
                ),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return _buildEventCard(event);
                },
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildTaskListItem(TaskModel task) {
    final bool isCompleted = task.status == TaskStatus.completed;
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: isCompleted ? 0 : 1,
      color: isCompleted ? Colors.green.shade50 : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isCompleted ? BorderSide(color: Colors.green.shade200) : BorderSide.none,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: _buildStatusIcon(task.status),
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: isCompleted ? TextDecoration.lineThrough : null,
            color: isCompleted ? Colors.green.shade700 : null,
          ),
        ),
        subtitle: Text(task.description, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _showTaskDetails(context, task),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(message, style: TextStyle(color: Colors.grey[500])),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return const Icon(Icons.circle_outlined, color: Colors.orange);
      case TaskStatus.inProgress:
        return const Icon(Icons.timelapse_rounded, color: Colors.blue);
      case TaskStatus.completed:
        return const Icon(Icons.check_circle, color: Colors.green);
    }
  }

  void _showCreateEventDialog(BuildContext context, String adminId) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final locController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Create New Event"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: "Event Title")),
            const SizedBox(height: 12),
            TextField(controller: descController, decoration: const InputDecoration(labelText: "Description")),
            const SizedBox(height: 12),
            TextField(controller: locController, decoration: const InputDecoration(labelText: "Location")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL")),
          ElevatedButton(
            onPressed: () async {
              if (titleController.text.isNotEmpty) {
                final event = EventModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: titleController.text,
                  description: descController.text,
                  date: DateTime.now().add(const Duration(days: 7)),
                  location: locController.text,
                  createdBy: adminId,
                  createdAt: DateTime.now(),
                );
                await _firestoreService.createEvent(event);
                if (mounted) Navigator.pop(context);
              }
            },
            child: const Text("CREATE EVENT"),
          ),
        ],
      ),
    );
  }

  void _showEventTasks(BuildContext context, EventModel event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.title, style: Theme.of(context).textTheme.headlineSmall),
                    Text(event.location, style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
                const Spacer(),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
              ],
            ),
            const Divider(height: 32),
            Expanded(
              child: StreamBuilder<List<TaskModel>>(
                stream: _firestoreService.getTasksForEvent(event.id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                  final tasks = snapshot.data!;
                  if (tasks.isEmpty) return _buildEmptyState("No tasks for this event yet.");
                  
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return _buildTaskListItem(task);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            if (Provider.of<UserProvider>(context, listen: false).user?.role == UserRole.admin)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _showCreateTaskDialog(context, event.id),
                  icon: const Icon(Icons.add_task),
                  label: const Text("ADD NEW TASK"),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showCreateTaskDialog(BuildContext context, String eventId) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    String? selectedVolunteerId;
    DateTime selectedDeadline = DateTime.now().add(const Duration(days: 2));

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text("New Task Details"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Task Title",
                    hintText: "Enter task name",
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(
                    labelText: "Short Description",
                    hintText: "What needs to be done?",
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                const Text(
                  "ASSIGN TO VOLUNTEER",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                StreamBuilder<List<UserModel>>(
                  stream: _firestoreService.getVolunteers(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const LinearProgressIndicator();
                    final volunteers = snapshot.data!;
                    if (volunteers.isEmpty) return const Text("No volunteers found");

                    return DropdownButtonFormField<String>(
                      value: selectedVolunteerId,
                      hint: const Text("Select a volunteer"),
                      isExpanded: true,
                      items: volunteers.map((v) {
                        return DropdownMenuItem(
                          value: v.uid,
                          child: Text(v.name),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => selectedVolunteerId = val),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                const Text(
                  "SET DEADLINE",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDeadline,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) {
                      setState(() => selectedDeadline = picked);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 18),
                        const SizedBox(width: 12),
                        Text(
                          "${selectedDeadline.year}-${selectedDeadline.month.toString().padLeft(2, '0')}-${selectedDeadline.day.toString().padLeft(2, '0')}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("CANCEL"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty && selectedVolunteerId != null) {
                  final task = TaskModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleController.text,
                    description: descController.text,
                    eventId: eventId,
                    status: TaskStatus.pending,
                    assignedTo: selectedVolunteerId,
                    deadline: selectedDeadline,
                    createdAt: DateTime.now(),
                  );
                  await _firestoreService.createTask(task);
                  if (mounted) Navigator.pop(context);
                } else if (selectedVolunteerId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a volunteer")),
                  );
                }
              },
              child: const Text("SAVE TASK"),
            ),
          ],
        ),
      ),
    );
  }

  void _showTaskDetails(BuildContext context, TaskModel task) {
    final currentUser = Provider.of<UserProvider>(context, listen: false).user!;
    final bool isAdmin = currentUser.role == UserRole.admin;
    final bool isAssignedToMe = task.assignedTo == currentUser.uid;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          height: MediaQuery.of(context).size.height * 0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildStatusIcon(task.status),
                ],
              ),
              const SizedBox(height: 8),
              Text(task.description, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 24),

              if (isAdmin) ...[
                const Text(
                  "ASSIGN TO VOLUNTEER",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, letterSpacing: 1, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                StreamBuilder<List<UserModel>>(
                  stream: _firestoreService.getVolunteers(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const LinearProgressIndicator();
                    final volunteers = snapshot.data!;
                    return DropdownButtonFormField<String>(
                      value: task.assignedTo,
                      hint: const Text("Select a volunteer"),
                      isExpanded: true,
                      items: volunteers.map((v) {
                        return DropdownMenuItem(value: v.uid, child: Text(v.name));
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          _firestoreService.assignTaskToVolunteer(task.id, val);
                          Navigator.pop(context);
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                const Text(
                  "ADMIN STATUS CONTROL",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, letterSpacing: 1, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _statusChip(task, TaskStatus.pending, "Pending"),
                      const SizedBox(width: 8),
                      _statusChip(task, TaskStatus.inProgress, "In Progress"),
                      const SizedBox(width: 8),
                      _statusChip(task, TaskStatus.completed, "Completed"),
                    ],
                  ),
                ),
              ] else if (isAssignedToMe && task.status != TaskStatus.completed) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      _firestoreService.updateTaskStatus(task.id, TaskStatus.completed);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text("MARK AS COMPLETED", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 24),
              ],

              const Divider(height: 48),
              const Text(
                "TASK UPDATES & COMMENTS",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, letterSpacing: 1, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              Expanded(child: _buildCommentsSection(task.id)),
              _buildCommentInput(task.id),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusChip(TaskModel task, TaskStatus status, String label) {
    bool isSelected = task.status == status;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          _firestoreService.updateTaskStatus(task.id, status);
          Navigator.pop(context);
        }
      },
    );
  }

  Widget _buildCommentsSection(String taskId) {
    return StreamBuilder<List<dynamic>>(
      stream: _firestoreService.getCommentsForTask(taskId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final comments = snapshot.data!;
        if (comments.isEmpty) return Center(child: Text("No updates yet", style: TextStyle(color: Colors.grey[400], fontSize: 12)));
        
        return ListView.builder(
          itemCount: comments.length,
          itemBuilder: (context, index) {
            final comment = comments[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(radius: 14, child: Text(comment.authorName[0])),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(comment.authorName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        Text(comment.text, style: const TextStyle(fontSize: 14)),
                        Text(
                          comment.createdAt.toString().split(' ')[1].substring(0, 5),
                          style: TextStyle(fontSize: 10, color: Colors.grey[400]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCommentInput(String taskId) {
    final commentController = TextEditingController();
    final user = Provider.of<UserProvider>(context, listen: false).user!;

    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: commentController,
              decoration: InputDecoration(
                hintText: "Post an update...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send_rounded, color: Color(0xFF2E7D32)),
                  onPressed: () async {
                    if (commentController.text.isNotEmpty) {
                      await _firestoreService.addComment(CommentModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        taskId: taskId,
                        authorId: user.uid,
                        authorName: user.name,
                        text: commentController.text,
                        createdAt: DateTime.now(),
                      ));
                      commentController.clear();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
