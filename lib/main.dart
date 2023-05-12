import 'package:flutter/material.dart';

import 'package:appcinema/config/router/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:appcinema/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/date_symbol_data_local.dart';

import 'presentation/providers/providers.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp( const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {

  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {

 @override
  void initState() {
    
    super.initState();
    initializeDateFormatting();
  }


  @override
  Widget build(BuildContext context ) {  

    final AppTheme appTheme = ref.watch( themeNotifierProvider );

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: appTheme.getTheme(),
    );
  }
}

// class MyApp extends ConsumerWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context, ref) { 

//     final AppTheme appTheme = ref.watch( themeNotifierProvider );
    
//     return MaterialApp.router(
//       routerConfig: appRouter,
//       debugShowCheckedModeBanner: false,
//       title: 'Material App',
//       theme: appTheme.getTheme(),
//     );
//   }
// }
