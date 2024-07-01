import 'package:flutter_firebase_architecture/di/firebase_service.dart';
import 'package:flutter_firebase_architecture/domain/entity/todo_item.dart';
import 'package:injectable/injectable.dart';

@singleton
class TodoDataSource {
  final FirebaseService _firebaseService;

  const TodoDataSource(this._firebaseService);

  Future<void> addTodoItem(String uid, String text) {
    final todoRef =
        _firebaseService.database.ref().child('users/$uid/todos').push();
    return todoRef.set({
      'text': text,
      'done': false,
    });
  }

  Future<List<TodoItem>> getTodoItems(String uid) async {
    final snapshot =
        await _firebaseService.database.ref().child('users/$uid/todos').get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> todoItemsMap =
          snapshot.value as Map<dynamic, dynamic>;
      List<TodoItem> todoItems = [];
      print("todo items = ${todoItemsMap.length}");
      todoItemsMap.forEach((key, value) {
        final todoItem =
            TodoItem(id: key, text: value['text'], done: value['done']);
        todoItems.add(todoItem);
      });
      todoItems.forEach((element) {
        print("todo items = ${element.id}, ${element.text}");
      });

      return todoItems;
    } else {
      print("todo items = empty");
      return [];
    }
  }

  Future<void> updateTodoItem(String uid, String todoId, bool done) =>
      _firebaseService.database
          .ref()
          .child('users/$uid/todos/$todoId')
          .update({'done': done});

  Future<void> deleteTodoItem(String uid, String todoId) =>
      _firebaseService.database
          .ref()
          .child('users/$uid/todos/$todoId')
          .remove();
}
