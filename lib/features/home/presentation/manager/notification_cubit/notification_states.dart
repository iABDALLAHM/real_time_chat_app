abstract class NotificationStates {}

final class InitialNotificationState extends NotificationStates {}

// delete notification

final class SuccessDeleteNotificationState extends NotificationStates {}

final class LoadingDeleteNotificationState extends NotificationStates {}

final class FailureDeleteNotificationState extends NotificationStates {}

// mark notification as read

final class SuccessMarkNotificationAsReadState extends NotificationStates {}

final class LoadingMarkNotificationAsReadState extends NotificationStates {}

final class FailureMarkNotificationAsReadState extends NotificationStates {}
