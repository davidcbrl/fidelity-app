import 'package:flutter/material.dart';

class NavigationItem {
  final String label;
  final IconData icon;
  final Widget page;
  final String? access;

  NavigationItem({
    required this.label,
    required this.icon,
    required this.page,
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