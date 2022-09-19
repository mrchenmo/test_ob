import 'package:flutter/material.dart';

class TestBean {
  TestBean(
    this.title,
    this.id,
    this.location, {
    this.completeSingleSKU = false,
    this.completeOrder = false,
    this.realNumController,
    this.scanCodeController,
    this.shouldPickNum = '0',
    this.focusNode,
    this.pickingNum = '0',
  });

  String title;
  String id;
  List<Location> location;
  bool completeSingleSKU;
  bool completeOrder;
  TextEditingController? realNumController;
  TextEditingController? scanCodeController;
  String shouldPickNum;
  FocusNode? focusNode;
  String pickingNum;
}

class Location {
  Location(this.name, this.locationSKUNum, {this.skuNumController});

  String name;
  String locationSKUNum;
  TextEditingController? skuNumController;
}
