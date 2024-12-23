import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/script.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final scriptProvider = StateNotifierProvider<ScriptNotifier, List<Script>>((ref) {
  return ScriptNotifier(ref);
});

final currentScriptProvider = StateProvider<Script>((ref) {
  // Return a default script or the selected one
  return Script(
    id: '',
    title: 'Untitled',
    content: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

class ScriptNotifier extends StateNotifier<List<Script>> {
  final Ref ref;

  ScriptNotifier(this.ref) : super([]) {
    // Load scripts from Firestore
    loadScripts();
  }

  Future<void> loadScripts() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('scripts')
          .where('userId', isEqualTo: user.uid)
          .get();
      state = snapshot.docs.map((doc) => Script.fromMap(doc.data())).toList();
    } else {
      throw Exception('User not authenticated');
    }

  }

  Future<void> saveScript() async {
    final script = ref.read(currentScriptProvider.notifier).state;
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      if (script.id.isEmpty) {
        // Generate a new document ID if not already set
        script.id = FirebaseFirestore.instance.collection('scripts').doc().id; // Update the script's id
      }

      final docRef = FirebaseFirestore.instance.collection('scripts').doc(script.id);
      await docRef.set({
        ...script.toMap(),
        'userId': user.uid, // Add userId to the script
      });
      // Reload scripts after saving
      loadScripts();
    } else {
      throw Exception('User not authenticated');
    }
  }

  Future<void> deleteScript(Script script) async {
    try {
      // Remove from Firestore
      final docRef = FirebaseFirestore.instance.collection('scripts').doc(script.id);
      await docRef.delete();

      // Remove from local state
      state = state.where((s) => s.id != script.id).toList();
    } catch (e) {
      print('Error deleting script: $e');
    }
  }

  void updateContent(String content) {
    final scriptNotifier = ref.read(currentScriptProvider.notifier);
    final script = scriptNotifier.state;
    script.content = content;
    script.updatedAt = DateTime.now();
    scriptNotifier.state = script;
  }

  void updateTitle(String title) {
    final scriptNotifier = ref.read(currentScriptProvider.notifier);
    final script = scriptNotifier.state;
    script.title = title;
    script.updatedAt = DateTime.now();
    scriptNotifier.state = script;
  }

  
}
