import 'package:isar/isar.dart';

part 'pyramid_brick.g.dart';

@Collection()
class PyramidBrick {
  Id id = Isar.autoIncrement;
  String title;
  DateTime createdAt = DateTime.now();

  PyramidBrick({required this.title});
}
