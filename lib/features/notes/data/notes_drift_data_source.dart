import 'package:drift/drift.dart';
import '../../../core/database/drift/app_database.dart';

class NotesDriftDataSource {
  final AppDatabase _db;

  NotesDriftDataSource(this._db);

  Future<List<Note>> getAllNotes() async {
    return await _db.getAllNotes();
  }

  Future<Note> getNoteById(int id) async {
    return await _db.getNoteById(id);
  }

  Future<int> createNote({
    required String title,
    required String content,
    int? categoryId,
  }) async {
    return await _db.createNote(
      NotesCompanion(
        title: Value(title),
        content: Value(content),
        categoryId: Value(categoryId),
        createdAt: Value(DateTime.now()),
      ),
    );
  }

  Future<bool> updateNote({
    required int id,
    String? title,
    String? content,
    bool? isCompleted,
    int? categoryId,
  }) async {
    return await _db.updateNote(
      NotesCompanion(
        id: Value(id),
        title: title != null ? Value(title) : const Value.absent(),
        content: content != null ? Value(content) : const Value.absent(),
        isCompleted: isCompleted != null ? Value(isCompleted) : const Value.absent(),
        categoryId: categoryId != null ? Value(categoryId) : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> deleteNote(int id) async {
    return await _db.deleteNote(id);
  }

  Future<List<Note>> getCompletedNotes() async {
    return await _db.getCompletedNotes();
  }

  Future<List<Note>> getPendingNotes() async {
    return await _db.getPendingNotes();
  }

  Stream<List<Note>> watchAllNotes() {
    return _db.watchAllNotes();
  }

  Stream<Note> watchNote(int id) {
    return _db.watchNote(id);
  }

  Future<List<Note>> searchNotes(String query) async {
    return await _db.searchNotes(query);
  }

  Future<void> markAsCompleted(int id) async {
    await _db.markNoteAsCompleted(id);
  }

  Future<int> getNoteCount() async {
    return await _db.getNoteCount();
  }

  Future<List<Category>> getAllCategories() async {
    return await _db.getAllCategories();
  }

  Future<int> createCategory({
    required String name,
    required String color,
  }) async {
    return await _db.createCategory(
      CategoriesCompanion(
        name: Value(name),
        color: Value(color),
      ),
    );
  }

  Future<List<Note>> getNotesByCategory(int categoryId) async {
    return await _db.getNotesByCategory(categoryId);
  }

  Future<List<Tag>> getAllTags() async {
    return await _db.getAllTags();
  }

  Future<int> createTag(String name) async {
    return await _db.createTag(
      TagsCompanion(
        name: Value(name),
      ),
    );
  }

  Future<void> addTagToNote(int noteId, int tagId) async {
    await _db.addTagToNote(noteId, tagId);
  }

  Future<void> removeTagFromNote(int noteId, int tagId) async {
    await _db.removeTagFromNote(noteId, tagId);
  }

  Future<List<Tag>> getTagsForNote(int noteId) async {
    return await _db.getTagsForNote(noteId);
  }
}

