import 'package:appcinema/presentation/views/movies/categories_view.dart';
import 'package:appcinema/presentation/views/views.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home_screen';

 // final Widget childView;
 final int pageIndex;

  const HomeScreen({
    super.key,
    required this.pageIndex
    //required this.childView,
  });

  final viewRoutes = const <Widget>[
      HomeView(), 
      CategoriesViews(), 
      FavoritesViews()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: childView,
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar:  CustomBottomNavigationBar( currentIndex: pageIndex,),
    );
  }
}
