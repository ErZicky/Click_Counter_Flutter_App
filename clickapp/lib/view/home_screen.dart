import 'package:clickapp/logic/CounterViewModel.dart';
import 'package:clickapp/logic/countersStorage.dart';
import 'package:clickapp/model/CounterModel.dart';
import 'package:clickapp/view/counter_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

   // Controller per il TextField nel dialogo
  final TextEditingController _counterNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }


   @override
  void dispose() {
    // Pulisce il controller quando il widget viene rimosso (buona pratica)
    _counterNameController.dispose();
    super.dispose();
  }








  void showCounterNameDialog(BuildContext context)
  {

    showDialog(

      context: context,
      builder: (BuildContext dialogContext)
      {
        return AlertDialog(
          title: const Text('Give the counter a name'),
          content: TextField(
            controller: _counterNameController,
            decoration: const InputDecoration(
              hintText: 'Write the name here',
              border: OutlineInputBorder(),
            ),
            autofocus: true,

          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                
                Navigator.pop(context);
                 _counterNameController.clear(); 

              },
              ),
              ElevatedButton(
                 child: const Text("Create"),
                onPressed: () {
                   final String counterName = _counterNameController.text.trim();
                    if (counterName.isNotEmpty) {
                  Provider.of<CounterViewModel>(context, listen: false).addCounter(counterName);
                  Navigator.of(context).pop(); // Chiudi il dialogo
                  _counterNameController.clear();
                }
                }, 
               )
          ],
        );
      }

    );

  }



  @override
  Widget build(BuildContext context) {
  // Uso Consumer per ricostruire solo la parte che dipende dal ViewModel
    return Consumer<CounterViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: const Icon(Icons.numbers),
            title: const Text('ClickApp'),
          ),

      body:viewModel.isLoading
              ? const Center(child: CircularProgressIndicator()) // Mostra un indicatore di caricamento
              : viewModel.counters.isEmpty
                  ? const Center(
                      child: Text(
                        'No counter. press "+" to add one!',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: viewModel.counters.length,
                      itemBuilder: (context, index) {
                        final counter = viewModel.counters[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            leading: const Icon(Icons.adjust, color: Colors.blueAccent, size: 30),
                            title: Text(
                              counter.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'current value: ${counter.value}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                                  onPressed: () {
                                    viewModel.deleteCounter(counter.id);
                                  },
                                ),
                              ],
                            ),
                            onTap: () async {
                              // Naviga alla CounterScreen e attendi il risultato (il contatore aggiornato)
                              final updatedCounter = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CounterScreen(counter: counter),
                                ),
                              );

                              if (updatedCounter != null && updatedCounter is CounterModel) {
                                // Aggiorna il contatore nel ViewModel
                                viewModel.updateCounter(updatedCounter);
                              }
                            },
                          ),
                        );
                      },
                    ),

      floatingActionButton: FloatingActionButton(
        

        onPressed: () {

          showCounterNameDialog(context);

        },
        
          child: const Icon(Icons.add),
            
        ),

    );
      },
    );
  }
}