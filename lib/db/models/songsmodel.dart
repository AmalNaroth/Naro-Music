import 'package:hive_flutter/adapters.dart';
part 'songsmodel.g.dart';

@HiveType(typeId: 1)
class songsmodel{
  @HiveField(0)
   String songName;
   @HiveField(1)
   String artistName;
   @HiveField(2)
    String uri;
    @HiveField(3)
    int id;
    @HiveField(4)
    int duration;
  songsmodel({required this.songName,required this.artistName,required this.uri,required this.id,required this.duration});
}