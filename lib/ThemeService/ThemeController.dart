import 'package:get/get.dart';
import '../SharePrefHelper/SharePref.dart';
import '../SharePrefHelper/SharePrefKey.dart';
import 'AppTheme.dart';


class ThemeController extends GetxController{

  bool isDarkMode = false;
  bool isDayMode = false;
  bool isNightMode = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getThemeMode();
  }
  getThemeMode()
  async {
    isDarkMode = await SharedPref.readBool(SharePrefKey.isDarkMode) ?? false;
    Get.changeTheme(
      isDarkMode ? AppTheme.dark : AppTheme.light,
    );
    Get.forceAppUpdate();
    if(isDarkMode)
    {
      isNightMode = true;
      isDayMode = false;
    }else{
      isDayMode = true;
      isNightMode = false;
    }
    update();
  }

  Future<void> toggleTheme() async {
    await SharedPref.saveBool(SharePrefKey.isDarkMode, isDarkMode);
    getThemeMode();
    update();
  }

  void seThemeMode(bool isNight)
  {
    if(isNight)
    {
      isDarkMode= true;
    }else{
      isDarkMode= false;
    }
    update();
    toggleTheme();
  }

}