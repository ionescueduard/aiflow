import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aiflow/widgets/files_view.dart';
import 'package:aiflow/widgets/editor_view.dart';

class ScriptsScreen extends ConsumerStatefulWidget {
  @override
  _ScriptsScreenState createState() => _ScriptsScreenState();
}

class _ScriptsScreenState extends ConsumerState<ScriptsScreen> {
  bool _activeScript = false;

  void _openEditor(bool state) {
    setState(() {
      _activeScript = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _activeScript == false
                ? FilesView(
                    onScriptSelected: () => _openEditor(true),
                  )
                : EditorView(
                    onExit: () => _openEditor(false),
                  ),
          ),
        ],
      ),
    );
  }
}
