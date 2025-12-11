import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Notes, Categories, Tags, NoteTags])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
      },
    );
  }

  Future<List<Note>> getAllNotes() async {
    return await select(notes).get();
  }

  Future<Note> getNoteById(int id) async {
    return await (select(notes)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<int> createNote(NotesCompanion note) async {
    return await into(notes).insert(note);
  }

  Future<bool> updateNote(NotesCompanion note) async {
    return await update(notes).replace(note);
  }

  Future<int> deleteNote(int id) async {
    return await (delete(notes)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<Note>> getCompletedNotes() async {
    return await (select(notes)..where((tbl) => tbl.isCompleted.equals(true))).get();
  }

  Future<List<Note>> getPendingNotes() async {
    return await (select(notes)..where((tbl) => tbl.isCompleted.equals(false))).get();
  }

  Stream<List<Note>> watchAllNotes() {
    return select(notes).watch();
  }

  Stream<Note> watchNote(int id) {
    return (select(notes)..where((tbl) => tbl.id.equals(id))).watchSingle();
  }

  Future<List<Note>> searchNotes(String query) async {
    return await (select(notes)
          ..where((tbl) =>
              tbl.title.like('%$query%') | tbl.content.like('%$query%')))
        .get();
  }

  Future<List<Category>> getAllCategories() async {
    return await select(categories).get();
  }

  Future<int> createCategory(CategoriesCompanion category) async {
    return await into(categories).insert(category);
  }

  Future<bool> updateCategory(CategoriesCompanion category) async {
    return await update(categories).replace(category);
  }

  Future<int> deleteCategory(int id) async {
    return await (delete(categories)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<Note>> getNotesByCategory(int categoryId) async {
    return await (select(notes)..where((tbl) => tbl.categoryId.equals(categoryId))).get();
  }

  Future<List<Tag>> getAllTags() async {
    return await select(tags).get();
  }

  Future<int> createTag(TagsCompanion tag) async {
    return await into(tags).insert(tag);
  }

  Future<int> deleteTag(int id) async {
    return await (delete(tags)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> addTagToNote(int noteId, int tagId) async {
    await into(noteTags).insert(NoteTagsCompanion(
      noteId: Value(noteId),
      tagId: Value(tagId),
    ));
  }

  Future<void> removeTagFromNote(int noteId, int tagId) async {
    await (delete(noteTags)
          ..where((tbl) => tbl.noteId.equals(noteId) & tbl.tagId.equals(tagId)))
        .go();
  }

  Future<List<Tag>> getTagsForNote(int noteId) async {
    final query = select(tags).join([
      innerJoin(noteTags, noteTags.tagId.equalsExp(tags.id)),
    ])
      ..where(noteTags.noteId.equals(noteId));

    final result = await query.get();
    return result.map((row) => row.readTable(tags)).toList();
  }

  Future<void> markNoteAsCompleted(int id) async {
    await (update(notes)..where((tbl) => tbl.id.equals(id)))
        .write(const NotesCompanion(isCompleted: Value(true)));
  }

  Future<int> getNoteCount() async {
    final count = countAll();
    final query = selectOnly(notes)..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    return NativeDatabase(file);
  });
}

