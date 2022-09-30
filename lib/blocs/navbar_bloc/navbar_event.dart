import 'package:equatable/equatable.dart';

class NavbarEvent extends Equatable {
  @override
  List<Object?> get props => [];

}

class NavbarHomePageEvent extends NavbarEvent {
  NavbarHomePageEvent();
}

class NavbarSearchPageEvent extends NavbarEvent {
  final bool status;
  NavbarSearchPageEvent(this.status);
}

class NavbarFavoritePageEvent extends NavbarEvent {
  NavbarFavoritePageEvent();
}

class NavbarProfilePageEvent extends NavbarEvent {
  NavbarProfilePageEvent();
}