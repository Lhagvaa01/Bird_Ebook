// ignore_for_file: prefer_typing_uninitialized_variables, override_on_non_overriding_member, unnecessary_brace_in_string_interps, sort_child_properties_last, prefer_const_constructors

import 'package:azlistview/azlistview.dart';
import 'package:bird_ebook/Pages/about/about.dart';
import 'package:bird_ebook/constant.dart';
import 'package:flutter/material.dart';

import '../../Models/BirdDatas.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:audioplayers/audioplayers.dart';

class CountryList implements ISuspensionBean {
  final String title;
  final String tag;

  CountryList({
    required this.title,
    required this.tag,
  });

  @override
  String getSuspensionTag() => tag;

  bool _isShowSuspension = true; // Member variable removed

  @override
  bool get isShowSuspension => _isShowSuspension;

  @override
  set isShowSuspension(bool value) => _isShowSuspension = value;
}

class AlphabetListScrollView extends StatefulWidget {
  final List<String> items;
  final List<BirdDatas>? birdDataList;

  const AlphabetListScrollView(
      {super.key, required this.items, required this.birdDataList});

  @override
  State<AlphabetListScrollView> createState() => _AlphabetListScrollViewState();
}

class _AlphabetListScrollViewState extends State<AlphabetListScrollView> {
  List<CountryList> items = [];
  List<BirdDatas> items2 = [];
  @override
  void initState() {
    super.initState();
    initList(widget.items);
    initList2(widget.birdDataList!);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.stop();
  }

  void initList(List<String> items) {
    this.items =
        items.map((item) => CountryList(title: item, tag: item[0])).toList();
  }

  void initList2(List<BirdDatas> birdDataList) {
    this.items2 = birdDataList.toList();
  }

  AudioPlayer player = AudioPlayer();
  bool isPlay = false;

  Future<void> playAudioUrl(String url) async {
    await player.play(UrlSource(url));
  }

  @override
  Widget build(BuildContext context) => AzListView(
      data: items,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildListItem(item, items2[index]);
      });
  Widget _buildListItem(CountryList item, BirdDatas items2) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BirdAbout(data: items2),
            ),
          );
        },
        child: ListTile(
          leading: Container(
            width: 57,
            height: 100,
            child: CircularProfileAvatar(
              '',
              child: Image.network(
                'http://${backUrl}/media/${items2.tCPROFILEIMAGES}',
                loadingBuilder: (context, child, progress) {
                  if (progress == null) {
                    return child;
                  }
                  return CircularProgressIndicator(
                    value: progress.expectedTotalBytes != null
                        ? progress.cumulativeBytesLoaded /
                            progress.expectedTotalBytes!
                        : null,
                  );
                },
              ),
              borderColor: Colors.white,
              borderWidth: 2,
              elevation: 5,
              radius: 50,
            ),
          ),
          trailing: IconButton(
            onPressed: () async {
              final url = 'http://${backUrl}/media/${items2.tCVOICES}';
              playAudioUrl(url);
            },
            icon: Icon(Icons.volume_up),
          ),
          title: Text(item.title),
          subtitle: Text(items2.tCIMAGES!),
        ),
      );
}
