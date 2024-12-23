import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:highlight/languages/python.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';


class CodeEditor extends StatefulWidget {
  final String initialCode;
  final Function(String) onCodeChanged;

  const CodeEditor({
    required this.initialCode,
    required this.onCodeChanged,
    Key? key,
  }) : super(key: key);

  @override
  _CodeEditorState createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> {
  late CodeController _codeController;

  @override
  void initState() {
    super.initState();

    final pythonLanguage = python;

    _codeController = CodeController(
      text: widget.initialCode,
      language: pythonLanguage,
    );

    _codeController.addListener(() {
      widget.onCodeChanged(_codeController.text);
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CodeTheme(
      data: CodeThemeData(styles: monokaiSublimeTheme),
      child: CodeField(
        controller: _codeController,
        textStyle: const TextStyle(fontFamily: 'SourceCodePro'),
      ),
    );
  }
}
