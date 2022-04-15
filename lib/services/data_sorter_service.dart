import 'package:color_gen/services/data_extractor.dart';

class DataSorterService {
  Map<String, List<String>> lstColorUsers = {};
  Map<String, String> lstUsers = {};

  Future<Map<String, String>> getUsers() async {
    DataExtractor extractor =
        DataExtractor(directory: 'assets/data/users.txt', split: "	");
    return await extractor.getData();
  }

  Future<Map<String, String>> getFavouriteColors() async {
    DataExtractor extractor =
        DataExtractor(directory: 'assets/data/favourites.txt', split: " ");
    return await extractor.getData();
  }

  Future<Map<String, int>> countFavouriteColors() async {
    lstUsers = await getUsers();
    Map<String, String> colors = await getFavouriteColors();
    Map<String, int> counts = {};

    colors.forEach((k, v) {
      if (counts.containsKey(v)) {
        counts[v] = counts[v]! + 1;
        lstColorUsers[v]!.add(lstUsers[k]!);
      } else {
        counts.addAll({v: 1});
        List<String> lst = [];
        lst.add(lstUsers[k]!);
        lstColorUsers.addAll({v: lst});
      }
    });

    var mapCount = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    counts
      ..clear()
      ..addEntries(mapCount);
    return counts;
  }
}
