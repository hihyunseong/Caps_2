class AppUtil {
  static String getTimeAgo(DateTime inputDate) {
    DateTime now = DateTime.now().toUtc();
    Duration diff = now.difference(inputDate.toUtc());

    if (diff.inMinutes < 1) {
      return '방금';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}분 전';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}시간 전';
    } else if (diff.inDays < 30) {
      return '${diff.inDays}일 전';
    } else if (diff.inDays < 365) {
      int months = (diff.inDays / 30).floor();
      return '$months개월 전';
    } else {
      int years = (diff.inDays / 365).floor();
      return '$years년 전';
    }
  }
}
