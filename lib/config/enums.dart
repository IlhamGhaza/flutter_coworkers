enum AppRoute {
  getStarted,
  signUp,
  signIn,
  dashboard,
  listWorker,
  workerProfile,
  booking,
  checkout,
  successBooking,
  notifications,
  userprofile,
}

extension AppRouteX on AppRoute {
  String get path => '/${name}';
}
