class TaskerInfo {
  final int errCode;
  final String message;
  final Object? tasker;

  final Object? taskerInfo;

  final List<Object>? reviewList;
  final bool? isLove;
  final bool? isBlock;

  TaskerInfo({
    required this.errCode,
    required this.message,
    required this.tasker,
    required this.taskerInfo,
    this.reviewList,
    this.isLove,
    this.isBlock,
  });

  get id => null;
}
