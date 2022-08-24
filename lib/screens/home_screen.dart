// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:search/model/gts_model.dart';
// import 'package:search/model/type_model.dart';
// import 'package:search/screens/search_filter.dart';

// import '../bloc/app_bloc.dart';

part of searching;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = '';

  List<Model> _allEntries = [];

  List<TypeModel> typeList = [];

  List<String> typeListString = [];

  TextEditingController searchBox = TextEditingController();

  Future<List<Model>> _loadData() async {
    final gtsJson = await rootBundle.loadString('assets/gts.json');
    final gtsData = jsonDecode(gtsJson) as List<dynamic>;
    return gtsData.map((e) => Model.fromJson(e)).toList();
  }

  @override
  initState() {
    _loadData().then((value) {
      for (var model in value) {
        for (var type in model.type) {
          if (!typeListString.contains(type)) {
            typeListString.add(type);
            typeList.add(TypeModel(type));
          }
        }
      }
      setState(() {
        _allEntries = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var filteredItems = _allEntries.where((element) {
    //   return element.text.toLowerCase().contains(searchText);
    // }).toList();


          print("Done");

          List checkBoxFilter = [];

          for (var element in typeList) {
            if (element.selected == true) {
              checkBoxFilter.add(element.name);
            }
          }

          var filteredItems = _allEntries.where((element) {
            bool check = true;
            if (checkBoxFilter.isNotEmpty) {
              check = element.type
                      .toSet()
                      .intersection(checkBoxFilter.toSet())
                      .isEmpty
                  ? false
                  : true;
            }

            return element.text.toLowerCase().contains(searchText) && check;
          }).toList();

          return SafeArea(
            child: DefaultTabController(
                length: 1,
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Scaffold(
                    appBar: AppBar(
                      toolbarHeight: 100,
                      backgroundColor: Color(0xffE8E8E8),
                      title: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 120.0),
                                  child: Text(
                                    "Search",
                                    style: TextStyle(color: Color(0xff005b96)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 100.0),
                                  child: GestureDetector(
                    
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) => SearchFilter(
                                                typeList,
                                                applyChanges: () {

                                                    setState(() {
                                                      
                                                    });
                                                    // BlocProvider.of<AppBloc>(context).ReloadEventScreen();
                                                },
                                              ));
                                    },
                                    child: Icon(
                                      Icons.filter_list,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: TextField(
                                  controller: searchBox,
                                  onChanged: (value) {
                                    debugPrint('value: ');

                                    setState(() {
                                      searchText = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.fromLTRB(
                                          5.0, 1.0, 5.0, 1.0),
                                      prefixIcon: Icon(Icons.search),
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            setState(() {
                                              searchBox.text = '';
                                              searchText = '';
                                            });
                                          },
                                          child: Icon(Icons.highlight_remove)),
                                      // labelText: "Search",
                                      hintText: "Search",
                                      hintStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red.shade200,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  setState(() {});
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      bottom: TabBar(
                        indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                                width: 5.0, color: Color(0xff005b96)),
                            insets: EdgeInsets.symmetric(horizontal: 120.0)),
                        // indicatorSize: TabBarIndicatorSize.label,
                        tabs: [
                          Tab(
                            text: "Full Text Search",
                          ),
                        ],
                        labelColor: Colors.black,
                      ),
                    ), 
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        child: TabBarView(
                          children: [
                            ListView.builder(
                                keyboardDismissBehavior:
                                    ScrollViewKeyboardDismissBehavior.onDrag,
                                itemCount: filteredItems.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                  width: 300,
                                                  child: Text(filteredItems[index]
                                                      .chapterName
                                                      .toString())),
                                            ),
                                            //Text(items[index].page.toString()),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8, bottom: 8),
                                              child: Text("@guidlines"),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          );
     
  }
}
