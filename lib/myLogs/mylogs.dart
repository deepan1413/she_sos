class MyLog {
  static const String _reset = "\x1B[0m";

  static const String _red = "\x1B[31m";
  static const String _green = "\x1B[32m";
  static const String _yellow = "\x1B[33m";
  static const String _white = "\x1B[37m";
  static const String _purple = "\x1B[35m";
  static const String _cyan = "\x1B[36m";

  static void error(String msg) {
    print("$_red[ERROR] $msg$_reset");
  }

  static void success(String msg) {
    print("$_green[SUCCESS] $msg$_reset");
  }

  static void warning(String msg) {
    print("$_yellow[WARNING] $msg$_reset");
  }

  static void info(String msg) {
    print("$_white[INFO] $msg$_reset");
  }

  static void debug(String msg) {
    print("$_purple[DEBUG] $msg$_reset");
  }

  static void highlight(String msg) {
    print("$_cyan[HIGHLIGHT] $msg$_reset");
  }
}
