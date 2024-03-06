import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/common/constants.dart';
import 'package:todo_list/data/models/domain/todo.dart';

import '../bloc/todo_bloc.dart';
import '../components/task_list_item_view.dart';

class SearchTaskPage extends StatefulWidget {
  static const String pageId = "/search_task_page";

  const SearchTaskPage({super.key});

  @override
  State<SearchTaskPage> createState() => _SearchTaskPageState();
}

class _SearchTaskPageState extends State<SearchTaskPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        List<Todo>? listTask;
        if (state is TodoSearchSuccess) {
          listTask = state.taskList;
        }

        return Scaffold(
          backgroundColor: tdBGColor,
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purple.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            title: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
              onSubmitted: (value) {
                // Perform search functionality here
                context.read<TodoBloc>().add(TodoSearched(searchedString: value));
              },
            ),
          ),
          body: (listTask == null || listTask.isEmpty)
              ? Center(child: Image.asset('assets/images/search_no_result.jpg', scale: 1,))
              : Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: listTask.length,
                          itemBuilder: (context, index) {
                            return TaskListItemView(task: listTask![index]);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              color: Colors.grey,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
