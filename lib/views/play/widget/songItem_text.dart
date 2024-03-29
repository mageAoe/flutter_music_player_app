import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/views/play/play_controller.dart';
import 'package:flutter_music_player_app/utlis/song_util.dart';
import 'package:provider/provider.dart';
import 'package:flutter_music_player_app/model/playlist_track_all_model.dart';


class SongItemText extends StatefulWidget {
  final List songList;
  final int index;
  final Function onItemTap;
  const SongItemText(this.songList, this.index, {super.key, required this.onItemTap});

  @override
  _SongItemTextState createState() => _SongItemTextState();
}

class _SongItemTextState extends State<SongItemText> {
  bool selected = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MusicController musicController =
        Provider.of<MusicController>(context, listen: false);
    Songs song = widget.songList[widget.index];
    Color itemColor = Colors.black54;
    if (widget.index == musicController.getCurrentIndex()) {
      itemColor = Colors.pink;
    }
    return InkWell(
      onTap: () {
        musicController.playIndex(widget.index);
        widget.onItemTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(children: <TextSpan>[
            TextSpan(
              text: song.name,
              style: TextStyle(fontSize: 15.0, color: itemColor),
            ),
            TextSpan(
                text: ' - ${SongUtil.getArtistNames(song)}',
                style: TextStyle(fontSize: 13.0, color: itemColor))
          ])),
    ));
  }
}
