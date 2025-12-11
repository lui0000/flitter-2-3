import '../../../core/database/drift/app_database.dart';
import '../data/notes_drift_data_source.dart';

class NotesUseCase {
  final NotesDriftDataSource _dataSource;

  NotesUseCase(this._dataSource);

  Future<List<Note>> getAllNotes() async {
    return await _dataSource.getAllNotes();
  }

  Future<Note> getNoteById(int id) async {
    return await _dataSource.getNoteById(id);
  }

  Future<int> createNote({
    required String title,
    required String content,
    int? categoryId,
  }) async {
    if (title.trim().isEmpty) {
      throw Exception('Title cannot be empty');
    }
    return await _dataSource.createNote(
      title: title,
      content: content,
      categoryId: categoryId,
    );
  }

  Future<bool> updateNote({
    required int id,
    String? title,
    String? content,
    bool? isCompleted,
    int? categoryId,
  }) async {
    if (title != null && title.trim().isEmpty) {
      throw Exception('Title cannot be empty');
    }
    return await _dataSource.updateNote(
      id: id,
      title: title,
      content: content,
      isCompleted: isCompleted,
      categoryId: categoryId,
    );
  }

  Future<int> deleteNote(int id) async {
    return await _dataSource.deleteNote(id);
  }

  Future<List<Note>> getCompletedNotes() async {
    return await _dataSource.getCompletedNotes();
  }

  Future<List<Note>> getPendingNotes() async {
    return await _dataSource.getPendingNotes();
  }

  Stream<List<Note>> watchAllNotes() {
    return _dataSource.watchAllNotes();
  }

  Future<List<Note>> searchNotes(String query) async {
    if (query.trim().isEmpty) {
      return await getAllNotes();
    }
    return await _dataSource.searchNotes(query);
  }

  Future<void> toggleNoteCompletion(int id) async {
    final note = await getNoteById(id);
    await updateNote(id: id, isCompleted: !note.isCompleted);
  }

  Future<int> getNoteCount() async {
    return await _dataSource.getNoteCount();
  }

  Future<List<Category>> getAllCategories() async {
    return await _dataSource.getAllCategories();
  }

  Future<int> createCategory({
    required String name,
    required String color,
  }) async {
    if (name.trim().isEmpty) {
      throw Exception('Category name cannot be empty');
    }
    return await _dataSource.createCategory(name: name, color: color);
  }

  Future<List<Note>> getNotesByCategory(int categoryId) async {
    return await _dataSource.getNotesByCategory(categoryId);
  }

  Future<List<Tag>> getAllTags() async {
    return await _dataSource.getAllTags();
  }

  Future<int> createTag(String name) async {
    if (name.trim().isEmpty) {
      throw Exception('Tag name cannot be empty');
    }
    return await _dataSource.createTag(name);
  }

  Future<void> addTagToNote(int noteId, int tagId) async {
    await _dataSource.addTagToNote(noteId, tagId);
  }

  Future<void> removeTagFromNote(int noteId, int tagId) async {
    await _dataSource.removeTagFromNote(noteId, tagId);
  }

  Future<List<Tag>> getTagsForNote(int noteId) async {
    return await _dataSource.getTagsForNote(noteId);
  }
}

