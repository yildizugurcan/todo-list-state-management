import 'package:flutter/material.dart';
import 'package:flutter_proje_7_statemanagment/providers/all_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToolBarWidget extends ConsumerWidget {
  ToolBarWidget({super.key});

  var _currentFilter = TodoListFilter.all;

  Color changeTextColor(TodoListFilter filt) {
    return _currentFilter == filt ? Colors.orange : Colors.black;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onCompletedTodoCount = ref.watch(unCompletedTodoCount);

    _currentFilter = ref.watch(todoListFilter);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            onCompletedTodoCount == 0
                ? 'Görevler Tamamlandı'
                : onCompletedTodoCount.toString() + " Görev Tamamlanmadı",
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Tooltip(
          message: 'All Todos',
          child: TextButton(
            style: TextButton.styleFrom(
                foregroundColor: changeTextColor(TodoListFilter.all)),
            onPressed: () {
              ref.read(todoListFilter.notifier).state = TodoListFilter.all;
            },
            child: const Text('All'),
          ),
        ),
        Tooltip(
          message: 'Only Uncompleted Todos',
          child: TextButton(
            style: TextButton.styleFrom(
                foregroundColor: changeTextColor(TodoListFilter.active)),
            onPressed: () {
              ref.read(todoListFilter.notifier).state = TodoListFilter.active;
            },
            child: const Text('Active'),
          ),
        ),
        Tooltip(
          message: 'Only Completed Todos',
          child: TextButton(
            style: TextButton.styleFrom(
                foregroundColor: changeTextColor(TodoListFilter.completed)),
            onPressed: () {
              ref.read(todoListFilter.notifier).state =
                  TodoListFilter.completed;
            },
            child: const Text('Completed'),
          ),
        ),
      ],
    );
  }
}
