import 'package:flutter_firebase_architecture/domain/entity/todo_item.dart';
import 'package:flutter_firebase_architecture/domain/entity/user_profile.dart';
import 'package:flutter_firebase_architecture/domain/result.dart';
import 'package:flutter_firebase_architecture/domain/usecase/todo/dto/update_todo_dto.dart';

abstract class DataRepository {
  Future<Result<UserProfile>> login(String email, String password);
  Future<Result<void>> logout();
  Future<Result<UserProfile>> register(
      String email, String password, String name);
  Future<Result<UserProfile>> getUser();
  Future<Result<bool>> isLogin();
  Future<Result<void>> addTodoItem(String text);
  Future<Result<List<TodoItem>>> getTodoItems();
  Future<Result<void>> updateTodoItem(UpdateTodoDto todoDto);
  Future<Result<void>> deleteTodoItem(String todoId);
}
