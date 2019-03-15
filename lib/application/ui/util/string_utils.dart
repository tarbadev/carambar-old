class StringUtils {
  static String capitalize(String s) {
    if (s == null) {
      return null;
    }

    return s[0].toUpperCase() + s.substring(1);
  }
}