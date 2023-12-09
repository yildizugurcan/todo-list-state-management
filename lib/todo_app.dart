import 'package:flutter/material.dart';
import 'package:flutter_proje_7_statemanagment/providers/all_providers.dart';
import 'package:flutter_proje_7_statemanagment/widgets/title_widget.dart';
import 'package:flutter_proje_7_statemanagment/widgets/todo_list_item_widget.dart';
import 'package:flutter_proje_7_statemanagment/widgets/toolbar_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoApp extends ConsumerWidget {
  TodoApp({super.key});

  final newTodoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filteredTodoList);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          const TitleWidget(),
          TextField(
            controller: newTodoController,
            decoration: const InputDecoration(
              labelText: 'Neler Yapacaksın Bugün ?',
            ),
            onSubmitted: (newTodo) {
              ref.read(todoListProvider.notifier).addTodo(newTodo);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ToolBarWidget(),
          allTodos.isEmpty
              ? const SizedBox(
                  height: 400,
                  child: Center(
                    child: Text(
                      'Herhangi Bir Görev Yok',
                    ),
                  ),
                )
              : const SizedBox(),
          for (var i = 0; i < allTodos.length; i++)
            Dismissible(
              key: ValueKey(allTodos[i].id),
              onDismissed: (_) {
                ref.read(todoListProvider.notifier).remove(allTodos[i]);
              },
              child: ProviderScope(overrides: [
                currentTodoProvider.overrideWithValue(allTodos[i]),
              ], child: const TodoListItemWidget()),
            ),
        ],
      ),
    );
  }
}
