// ignore_for_file: avoid_print

class Data {
  static late String id = '';
  static Map<String, dynamic> map = {};
  static void setData(String id) {
    id = id;
  }

  static void setMap(Map<String, dynamic> newmap) {
    map = newmap;
    print(map);
  }
}
