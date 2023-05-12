import 'package:appcinema/presentation/views/movies/populares_view.dart';
import 'package:appcinema/presentation/views/views.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {

  static const name = 'home_screen';

 // final Widget childView;
 //final int pageIndex;
 final int pageIndex;

  const HomeScreen({
    super.key,
    required this.pageIndex
    //required this.childView,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {

  late PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController(
      keepPage: true
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final viewRoutes = const <Widget>[
      HomeView(), 
      PopularView(), 
      FavoritesViews()
  ];

  @override
  Widget build(BuildContext context) { 
    super.build(context);

    if ( pageController.hasClients ) {
        pageController.animateToPage(
        widget.pageIndex, 
        curve: Curves.easeInOut, 
        duration: const Duration( milliseconds: 250),
      );
    }

    return Scaffold(
      //body: childView,
      //body: IndexedStack( index: widget.pageIndex, children: viewRoutes ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: viewRoutes,
      ),
      bottomNavigationBar:  CustomBottomNavigationBar( currentIndex: widget.pageIndex,),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
  
}
