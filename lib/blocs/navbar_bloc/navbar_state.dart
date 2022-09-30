import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:travelservices/screens/pages/favorite_page.dart';
import 'package:travelservices/screens/pages/home_page.dart';
import 'package:travelservices/screens/pages/profile_page.dart';
import 'package:travelservices/screens/pages/search_page.dart';


class NavbarState extends Equatable {

  final Widget widget;
  final int indexItem;
  final bool statusSearch;

  const NavbarState({
    this.widget = const HomePage(),
    this.indexItem = 0,
    this.statusSearch = false
  });

  NavbarState copyWith({
    Widget? widget,
    int? indexItem,
    bool? statusSearch
  }) {
    return NavbarState(
      widget: widget ?? this.widget,
      indexItem: indexItem ?? this.indexItem,
      statusSearch: statusSearch ?? this.statusSearch 
    );
  }
  
  @override
  List<Object?> get props => [widget, indexItem, statusSearch];

}