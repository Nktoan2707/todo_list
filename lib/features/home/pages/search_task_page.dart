import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/common/constants.dart';
import 'package:todo_list/data/models/domain/task.dart';
import 'package:todo_list/features/home/components/task_list_item_view.dart';

import '../bloc/home_bloc.dart';

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
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        List<Task>? listTask;;
        if (state is HomeSearchTaskSuccess) {
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
              onChanged: (value) {
                // Perform search functionality here
              },
            ),
          ),
          body: listTask == null
              ? Image.asset('assets/images/search_no_result.jpg')
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
