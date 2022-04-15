import 'dart:convert';
import 'dart:io';

class DataExtractor{

  String directory;
  String split;
  DataExtractor({required this.directory,required this.split});

  Future<Map<String, String>> getData() async {
    File file = File(directory);
    if (await file.exists()) {
      Map<String, String> data = {};
      await file
          .openRead()
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .forEach((l) {
        var dataLine = l.split(split);
        data.addAll({dataLine[0].trim(): dataLine[1].trim()});
      });
      return data;
    } else {
      return {};
    }
  }

}