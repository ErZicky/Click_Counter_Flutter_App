import 'package:clickapp/model/CounterModel.dart';
import 'package:flutter/material.dart';
import 'more_options_sheet.dart';


class CounterScreen extends StatefulWidget {

  final CounterModel counter;

  const CounterScreen({super.key, required this.counter});

  @override
  State<CounterScreen> createState() => _CounterScreen();
}




class _CounterScreen extends State<CounterScreen> {

 late int counter;

   @override
  void initState() {
    super.initState();
    counter = widget.counter.value;
  }


  void incrementCounter()
  {

    setState(() {
      counter++;
    });
      widget.counter.value = counter; // Aggiorna il modello
  }

  void resetCounter()
  {
    setState(() {
      counter = 0;
    });
      widget.counter.value = counter; // Aggiorna il modello
  }

  void showMoreSheet()
  {
    showModalBottomSheet(
      context: context, 
      builder: (context) {

         return MoreOptionsSheet(onReset: resetCounter); //passiamo la funzione resetCounter a MoreOptionsSheet in modo che possa eseguirla quando viene premuto

      },
      );
  }



  @override
  Widget build(BuildContext context) {
   

    return WillPopScope(
  onWillPop: () async {
    // Passa dati al Navigator quando torni indietro
    Navigator.pop(context, widget.counter);
    return false; // impedisce il pop automatico perché hai fatto tu il pop
  },


   child: Scaffold(

    appBar: AppBar(
      
      title: Container(
        alignment: Alignment.centerLeft,
        child: Text(widget.counter.name),

      ),

    actions: [
      IconButton(
        icon: const Icon(Icons.more_vert),
       
        onPressed: (){
          showMoreSheet();
        }
        ,

      )

    ],

      ),

    body: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: incrementCounter,
      child: Align(
        alignment: Alignment.center,
        child:  Text( 
        '$counter',
        style: const TextStyle(
          fontSize: 180,
          fontWeight: FontWeight.bold

        ),

      ),

      ),
      
      
      
    ),
      

   ),
   );

      

  }
}