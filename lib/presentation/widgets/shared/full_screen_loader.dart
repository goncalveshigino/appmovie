import 'package:flutter/material.dart';


class FullScreenLoader extends StatelessWidget {



 Stream<String> getLadingMessages() {
   
    final messages = <String>[
    'Carregando os Filmes', 
    'Carregando os populares', 
    'Vem Veu Amor', 
    'Isto esta demorando :('
  ];

   return Stream.periodic( const Duration(milliseconds: 1200), (step){
    return messages[step];
   }).take(messages.length);
 }

  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [

         const Text('Espere por favor'),
         const SizedBox( height: 10,),
         const CircularProgressIndicator( strokeWidth: 2,), 
         const SizedBox( height: 10,), 

          StreamBuilder(
            stream: getLadingMessages(),
            builder: (context, snapshot){
               if( !snapshot.hasData ) return const Text('Carregando...');

               return Text( snapshot.data!);
            }
          )

        ],
      ),
    );
  }
}