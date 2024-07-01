import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_firebase_architecture/page/todo/provider/todo_list_provider.dart';
import 'package:flutter_firebase_architecture/page/widget/todo_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoListPage extends ConsumerStatefulWidget {
  const TodoListPage({super.key});

  @override
  ConsumerState createState() => _TodoListPageState();
}

class _TodoListPageState extends ConsumerState<TodoListPage> {
  @override
  void initState() {
    super.initState();
    ref.read(todoListNotifierProvider.notifier).loadTodoItem();
  }

  @override
  Widget build(BuildContext context) {
    final todoItemState = ref.watch(todoListNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo 리스트'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                ref.read(todoListNotifierProvider.notifier).loadTodoItem();
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: todoItemState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : (todoItemState.errorMessage != null &&
                  todoItemState.errorMessage!.isNotEmpty)
              ? Center(child: Text(todoItemState.errorMessage!))
              : todoItemState.isEmpty
                  ? const Center(child: Text('No Todo Items Found'))
                  : ListView.builder(
                      itemCount: todoItemState.items.length,
                      itemBuilder: (context, index) => TodoListItem(
                        item: todoItemState.items[index],
                        onEdit: (id, done) => ref
                            .read(todoListNotifierProvider.notifier)
                            .updateTodoItem(id, done),
                        onRemove: (id) => ref
                            .read(todoListNotifierProvider.notifier)
                            .deleteTodoItem(id),
                      ),
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final text = await _showAddDialog(context);
          if (text != null && text.isNotEmpty) {
            ref.read(todoListNotifierProvider.notifier).addTodoItem(text);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<String?> _showAddDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Text'),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(hintText: 'Enter'),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(controller.text);
                  },
                  child: Text('Add'))
            ],
          );
        });
  }
}
