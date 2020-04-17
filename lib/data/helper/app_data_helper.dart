class AppDataHelper {
  static int localeValueIndex = 0;
  static bool userDarkMode = false;
  static int themeColorIndex = 0;
  static int fontIndex = 0;

  static int nextIndex(List list, int currentIndex) {
    if (currentIndex + 1 >= list.length) {
      return 0;
    } else {
      return currentIndex + 1;
    }
  }
}
