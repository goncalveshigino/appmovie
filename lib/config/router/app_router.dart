import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';


final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [

    GoRoute(
      path: '/home/:page', 
      name: HomeScreen.name, 
      builder: (context, state){
        final pageIndex = state.pathParameters['page'] ?? '0';

        return  HomeScreen( pageIndex: int.parse(pageIndex) );
      },
      //builder: (context, state) => const HomeScreen( childView:  HomeView(),), 
      
      routes: [

          GoRoute(
              path: 'movie/:id', 
              name: MovieScreen.name, 
              builder: (context, state){
                final movieId = state.pathParameters['id'] ?? 'no-id';
                return  MovieScreen(movieId: movieId);
            }
          ),
      ]
    ), 

    GoRoute(
      path: '/', 
      redirect: (_, __) => '/home/0'
    )


      // ShellRoute(
    //   builder: (context, state, child){
    //     return HomeScreen(childView: child);
    //   }, 
    //   routes: [

    //     GoRoute(
    //       path: '/',
    //       builder: (context, state){
    //         return const HomeView();
    //       },
    //       routes: [
            
    //         GoRoute(
    //           path: 'movie/:id', 
    //           name: MovieScreen.name, 
    //           builder: (context, state){
    //             final movieId = state.pathParameters['id'] ?? 'no-id';
    //             return  MovieScreen(movieId: movieId);
    //         }
    //       ),

    //       ]
    //       ),

    //       GoRoute(
    //       path: '/favorites',
    //       builder: (context, state){
    //         return const FavoritesViews();
    //       },),
    //   ]
    // ),

  ]
);