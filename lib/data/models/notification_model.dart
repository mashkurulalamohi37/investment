enum NotificationCategory {
  investment,
  project,
  payment,
  distribution,
  document,
  security,
  system,
}

class NotificationModel {
  final String id;
  final String title;
  final String titleBn;
  final String body;
  final String bodyBn;
  final NotificationCategory category;
  final DateTime createdAt;
  final bool isRead;
  final String? actionRoute;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.titleBn,
    required this.body,
    required this.bodyBn,
    required this.category,
    required this.createdAt,
    this.isRead = false,
    this.actionRoute,
  });

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      titleBn: titleBn,
      body: body,
      bodyBn: bodyBn,
      category: category,
      createdAt: createdAt,
      isRead: isRead ?? this.isRead,
      actionRoute: actionRoute,
    );
  }
}
