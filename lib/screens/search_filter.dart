
part of searching;

class SearchFilter extends StatefulWidget {

  final Function? applyChanges;
 
  final List<TypeModel> typeList;

  const SearchFilter(List<TypeModel> this.typeList, {super.key, this.applyChanges});

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff5C5CFF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                      child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
              ),
              InkWell(
                onTap: () {

                  if (widget.applyChanges != null) {
                    widget.applyChanges!();
                  }

                  BlocProvider.of<AppBloc>(context).ReloadEventScreen();

                  Navigator.of(context).pop();

                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff5C5CFF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                      child: Text(
                    "Apply",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
              )
            ],
          ),
        ),
      )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                bottom: true,
                child: Card(
                  elevation: 10,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: widget.typeList.length,
                      itemBuilder: (context, index) => CheckboxListTile(
                        title: Text(widget.typeList[index].name),
                        value: widget.typeList[index].selected,
                        autofocus: false,
                        controlAffinity: ListTileControlAffinity.platform,
                        onChanged: (bool? value) {
                          debugPrint('typeList: ${widget.typeList.toString()}');
                          setState(() {
                            widget.typeList[index].selected = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
