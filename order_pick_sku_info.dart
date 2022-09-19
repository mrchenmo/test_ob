import 'package:flutter/material.dart';

/// 描述：
/// 建立时间: 2022-08-03 11:29

class OrderPickSkuInfo extends StatelessWidget {
  const OrderPickSkuInfo({
    this.skuUrl = '',
    this.skuTitle = '',
    this.skuSerialNumber = '',
    this.shouldPickNum = '',
    this.pickingNum,
  });

  final String skuUrl;
  final String skuTitle;
  final String skuSerialNumber;
  final String shouldPickNum;
  final ValueNotifier<String>? pickingNum;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              'https://img.win3000.com/m00/5b/9c/e628dd5855819779c65981fed4e78d50.jpg',
              width: 60.0,
              height: 60.0,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 60.0,
            margin: const EdgeInsets.only(left: 10.0, right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'titletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitle',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
                const Text(
                  'SYW2060310titletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitle',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    const Text(
                      '应拣',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        '$shouldPickNum',
                      ),
                    ),
                    const SizedBox(
                      width: 50.0,
                    ),
                    const Text(
                      '已拣',
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ValueListenableBuilder(
                          valueListenable: pickingNum!,
                          builder: (BuildContext context, String value, Widget? child) {
                            return Text(
                              value,
                            );
                          },
                        )),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
