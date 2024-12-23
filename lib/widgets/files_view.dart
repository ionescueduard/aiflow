import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aiflow/providers/script_provider.dart';
import 'package:aiflow/models/script.dart';

class FilesView extends ConsumerStatefulWidget {
  final VoidCallback onScriptSelected;

  FilesView({required this.onScriptSelected});

  @override
  _FilesViewState createState() => _FilesViewState();
}

class _FilesViewState extends ConsumerState<FilesView> {
  
  void _createNewScript() {
    final newScript = Script(
      id: "",
      title: 'Untitled',
      content: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    ref.read(currentScriptProvider.notifier).state = newScript;
    widget.onScriptSelected();
  }

  void _deleteScript(Script script) {
    final scriptsNotifier = ref.read(scriptProvider.notifier);
    scriptsNotifier.deleteScript(script);
  }

  void _selectScript(Script script) {
    ref.read(currentScriptProvider.notifier).state = script;
    widget.onScriptSelected();
  }

  @override
  Widget build(BuildContext context) {
    final scripts = ref.watch(scriptProvider);

    return Column(
      children: [
        AppBar(
          title: Text('My Scripts'),
          backgroundColor: Color(0xFFCBC4D4),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _createNewScript,
            ),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Last Modified',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: Text(
                        'Actions',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: scripts.length,
                  itemBuilder: (context, index) {
                    final script = scripts[index];
                    return InkWell(
                      onTap: () => _selectScript(script),
                      hoverColor: Colors.grey[300], // Highlight color when hovering
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(script.title),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(script.updatedAt.toString()),
                            ),
                            SizedBox(
                              width: 50,
                              child: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteScript(script),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
