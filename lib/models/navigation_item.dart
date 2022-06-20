import 'package:flutter/material.dart';

class NavigationItem {
  String? label;
  IconData? icon;
  Widget? page;
  String? access;

  NavigationItem({
    this.label,
    this.icon,
    this.page,
    this.access,
  });

  NavigationItem.fromJson(Map<String, dynamic> json):
    label = json['Label'],
    icon = json['Icon'],
    page = json['Page'],
    access = json['Access'];

  Map<String, dynamic> toJson() => {
    'Label': label,
    'Icon': icon,
    'Page': page,
    'Access': access,
  };
}