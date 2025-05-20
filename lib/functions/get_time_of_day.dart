
String getTimeOfDay() {
  final currentTime = DateTime
      .now()
      .hour;

  if (currentTime < 12) {
    return 'Good Morning';
  } else if (currentTime < 17) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}