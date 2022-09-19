import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import 'TestBean.dart';
import 'order_pick_sku_info.dart';

/// 描述：操作步骤，点击列表最后一个item中的增加库位按钮即+新增库位9，就会出现报错信息。
/// 建立时间: 2022-09-19 13:41

class TestObPager extends StatefulWidget {
  const TestObPager({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TestObPagerState();
  }
}

class _TestObPagerState extends State<TestObPager> {
  TextEditingController locationController = TextEditingController();
  ValueNotifier<bool> showBottomScan = ValueNotifier(false);
  int currentIndex = 0;
  ScrollController scrollController = ScrollController();
  StreamController<List<TestBean>> data = StreamController();
  bool outsideAddClick = false;

  //ListObserverController observerController = ListObserverController();
  bool userScY = false;
  List<int> tempDisplaying = [];
  List<TestBean> test = [
    TestBean('', '', [Location('location2-天津市大港区天津港南头仓库区-100086', '10000')]),
    TestBean('', '', [
      Location('location2-天津市大港区天津港南头仓库区-100086', '3000'),
      Location('location2-天津市大港区天津港南头仓库区-100086', '15203366')
    ]),
    TestBean('', '', [
      Location('location2-天津', '987897897'),
      Location('', ''),
      Location('', ''),
      Location('location2-天津市大港区天津港南头仓库区-100086', ''),
      Location('', ''),
      Location('', ''),
      Location('', ''),
      Location('', ''),
      Location('', ''),
      Location('location2-天津市大港区天津港南头仓库区-100086', ''),
      Location('', ''),
      Location('', ''),
      Location('', ''),
      Location('', ''),
      Location('', ''),
      Location('', ''),
      Location('', ''),
      Location('', ''),
      Location('', ''),
      Location('', ''),
    ]),
    TestBean('', '', [
      Location('location2-天津市大港区天津港南头仓库区-100086', ''),
      Location('', ''),
      Location('', ''),
      Location('', '')
    ]),
    TestBean('', '',
        [Location('', ''), Location('', ''), Location('', ''), Location('', ''), Location('', '')]),
    TestBean('', '', [Location('', ''), Location('', ''), Location('', ''), Location('', '')]),
    TestBean('', '', [Location('', '')]),
    TestBean('', '', [Location('', '')]),
    TestBean('', '', [Location('', '')]),
    TestBean('', '', [Location('', '')]),
  ];

  @override
  void initState() {
    super.initState();
    data.sink.add(test);
  }

  @override
  void dispose() {
    super.dispose();
    locationController.dispose();
    scrollController.dispose();
    data.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestObPager'),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (UserScrollNotification notification) {
            ///业务逻辑的判断,已经测试不包裹在NotificationListener依然会发生错误，只有操作列表中的最后一个数据会发生这种情况
            ///我认为应该是在item中使用setState导致的。
            outsideAddClick = false;
            userScY = true;
            if (tempDisplaying.length >= 2 &&
                showBottomScan.value == true &&
                notification.direction != ScrollDirection.forward) {
              showBottomScan.value = false;
            }
            return true;
          },
          child: Stack(
            children: [
              orderPickHeader(),
              Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 45.0),
                      child: ListViewObserver(
                        //controller: observerController,
                        child: StreamBuilder(
                            stream: data.stream,
                            builder:
                                (BuildContext context, AsyncSnapshot<List<TestBean>> snapshot) {
                              return ListView.builder(
                                physics: const ClampingScrollPhysics(),
                                itemCount: snapshot.data == null ? 0 : snapshot.data!.length,
                                controller: scrollController,
                                itemBuilder: (BuildContext context, int index) {
                                  return OrderPickDetailItem(
                                    position: index,
                                    item: snapshot.data![index],
                                    scroll: scrollController,
                                  );
                                },
                              );
                            }),
                        onObserve: (ListViewObserveModel resultModel) {
                          print('firstChild.index -- ${resultModel.firstChild?.index}');
                          print('displaying -- ${resultModel.displayingChildIndexList}');
                          tempDisplaying = resultModel.displayingChildIndexList;
                          if (resultModel.displayingChildModelList.length == 1 &&
                              resultModel.displayingChildModelList[0].index ==
                                  resultModel.firstChild!.index) {
                            currentIndex = resultModel.firstChild!.index;
                            showBottomScan.value = true;
                          } else {
                            if (!outsideAddClick) {
                              showBottomScan.value = false;
                            }
                            outsideAddClick = false;
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 66.0),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    child: Container(
                      height: 48.0,
                      alignment: Alignment.center,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                      ),
                      child: const Text('输入框'),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget orderPickHeader() {
    return SizedBox(
      height: 44.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 28.0,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'NNNN5465465465NNNN5465465465NNNN5465465465',
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: const TextSpan(
                    text: '0',
                    children: [
                      TextSpan(
                        text: '/10',
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: const TextSpan(
                    text: '0',
                    children: [
                      TextSpan(
                        text: '/30',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderPickDetailItem extends StatefulWidget {
  const OrderPickDetailItem({
    this.position = 0,
    this.item,
    this.scroll,
    this.cutLocationCall,
  });

  final int position;
  final TestBean? item;
  final ScrollController? scroll;
  final ValueChanged<int>? cutLocationCall;

  @override
  State<StatefulWidget> createState() {
    return _OrderPickDetailItemState();
  }
}

class _OrderPickDetailItemState extends State<OrderPickDetailItem> {
  List<Location> tempList = [];
  final GlobalKey _key = GlobalKey();
  int exeNum = 0;

  @override
  void initState() {
    super.initState();
    tempList = widget.item!.location;
    for (Location single in widget.item!.location) {
      single.skuNumController = TextEditingController(text: single.name);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OrderPickSkuInfo(
          shouldPickNum: '30',
          pickingNum: ValueNotifier('20'),
        ),

        ///库位的ListView
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.item == null ? 0 : widget.item!.location.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return _location(widget.item!.location[index], index);
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            ///增加里面listView的长度，这里使用setState(() {});只更新了item的Widget，会导致错误发生
            ///如果不在item里面更新，在外部pager里更新整个列表则不会报错。
            ///应该和我使用的方式有关系。
            tempList.add(Location('宁波港西南片区新增库位', '10085',
                skuNumController: TextEditingController(text: '宁波港西南片区新增库位')));
            widget.item!.location = tempList;
            widget.scroll?.jumpTo(widget.scroll!.offset + 42.0);
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: SizedBox(
              height: 30.0,
              key: _key,
              child: Row(
                children: [
                  const Text(
                    '+',
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '新增库位${widget.position}',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _location(Location singleLocation, int locationPosi) {
    FocusNode itemNode = FocusNode();
    return Container(
      height: 36.0,
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 6.0),
      decoration: const BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 60.0,
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                '库位1:',
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
              child: Row(
                children: [
                  Flexible(child: Text('${singleLocation.skuNumController?.text}')),
                  const Text(
                    '(30)',
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 8.0,
              ),
              GestureDetector(
                onTap: () {},
                child: const SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: Icon(Icons.delete),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  if (widget.item!.location.length > 1) {
                    widget.item!.location.removeAt(locationPosi);
                    widget.scroll?.jumpTo(widget.scroll!.offset - 42.0);
                    setState(() {});
                  }
                },
                child: const SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: Icon(Icons.access_alarm),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
