// ignore_for_file: prefer_typing_uninitialized_variables, override_on_non_overriding_member, unnecessary_brace_in_string_interps, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, avoid_print

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
  List<BirdDatas> filteredBirdDataList = [];
  List<CountryList> filteredBirdDataListName = [];
  final searchField = TextEditingController();
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
    filteredBirdDataListName = this.items;
  }

  void initList2(List<BirdDatas> birdDataList) {
    this.items2 = birdDataList.toList();
    filteredBirdDataList = this.items2;
  }

  AudioPlayer player = AudioPlayer();
  bool isPlay = false;

  Future<void> playAudioUrl(String url) async {
    await player.play(UrlSource(url));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: searchField,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        searchField.clear();
                        filteredBirdDataList = items2;
                        filteredBirdDataListName = items;
                      });
                    },
                    icon: Icon(Icons.close)),
                // icon: Icon(Icons.person_outlined),
                hintText: 'Нэрээр хайлт хийнэ үү',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  // Filter the birdDataList based on the entered search text
                  filteredBirdDataList = items2
                      .where((bird) => bird.tCBIRDNAME!
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                  filteredBirdDataListName = items
                      .where((bird) => bird.title
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();

                  print("filteredBirdDataList.length");
                  print(filteredBirdDataList.length);
                });
              },
            ),
          ),
          Container(
            width: size.width,
            height: size.height - 200,
            child: AzListView(
                data: filteredBirdDataListName,
                itemCount: filteredBirdDataListName.length,
                itemBuilder: (context, index) {
                  final item = filteredBirdDataListName[index];
                  return _buildListItem(item, filteredBirdDataList[index]);
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(CountryList item, BirdDatas filteredBirdDataList) =>
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BirdAbout(data: filteredBirdDataList),
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
                filteredBirdDataList.tCPROFILEIMAGES != null
                    ? 'http://${backUrl}/media/${filteredBirdDataList.tCPROFILEIMAGES}'
                    : 'http://${backUrl}/media/${filteredBirdDataList.tCIMAGES}',
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
              final url =
                  'http://${backUrl}/media/${filteredBirdDataList.tCVOICES}';
              playAudioUrl(url);
            },
            icon: Icon(Icons.volume_up),
          ),
          title: Text(item.title),
          subtitle: Text("Овгийн нэр: " + filteredBirdDataList.tCBIRDFAMILYPK!),
        ),
      );
}
