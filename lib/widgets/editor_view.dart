import 'package:flutter/material.dart';
import '../widgets/code_editor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/script_provider.dart';

class EditorView extends ConsumerWidget {
  final VoidCallback onExit;

  EditorView({required this.onExit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final script = ref.watch(currentScriptProvider);
    final TextEditingController titleController = TextEditingController(text: script.title);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: titleController,
          decoration: InputDecoration(
            hintText: 'Enter title',
            border: InputBorder.none,
          ),
          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 20),
          onChanged: (value) {
            ref.read(scriptProvider.notifier).updateTitle(value);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              ref.read(scriptProvider.notifier).saveScript();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Script saved successfully')),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              ref.read(scriptProvider.notifier).saveScript();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Script saved successfully')),
              );
              onExit();
            }
          ),
        ],
      ),
      body: CodeEditor(
        initialCode: script.content,
        onCodeChanged: (value) {
          ref.read(scriptProvider.notifier).updateContent(value);
        },
      ),
    );
  }
}
