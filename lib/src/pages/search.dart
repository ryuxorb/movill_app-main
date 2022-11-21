import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String serchText = "";
  _SearchState() {
    filter.addListener(() {
      setState(() {
        serchText = filter.text;
      });
    });
  }
  //검색어 결과 반환
  Widget buildBody(BuildContext context) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(12)),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 6,
                      child: TextField(
                        focusNode: focusNode,
                        style: TextStyle(fontSize: 15),
                        autofocus: true,
                        controller: filter,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black12,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black54,
                            size: 25,
                          ),
                          suffixIcon: focusNode.hasFocus
                              ? IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    size: 22,
                                    color: Colors.black54,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      filter.clear();
                                      serchText = "";
                                    });
                                  },
                                )
                              : Container(),
                          hintText: '검색어를 입력하세요 ...',
                          labelStyle: TextStyle(color: Colors.white12),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      )),
                  focusNode.hasFocus
                      ? Expanded(
                          child: TextButton(
                            child: Text('취소'),
                            onPressed: () {
                              setState(() {
                                filter.clear();
                                serchText = "";
                                focusNode.unfocus();
                              });
                            },
                          ),
                        )
                      : Expanded(
                          flex: 0,
                          child: Container(),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
