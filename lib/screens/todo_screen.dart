import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_apis_flutter/models.dart';
import 'package:rest_apis_flutter/provider.dart';
import 'package:rest_apis_flutter/screens/create_todo_screen.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  // init state
  void initState() {
    super.initState();
    //
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<TodoProvider>(context, listen: false).fetchTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<TodoProvider>(
        builder: (BuildContext context, TodoProvider provider, Widget? child) =>
            Stack(
          alignment: Alignment.center,
          children: [
            Scaffold(
              // app Bar
              appBar: PreferredSize(
                preferredSize: Size(
                  MediaQuery.sizeOf(context).width, // full width of the screen
                  70, // preferred height
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "User 1",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateTodoScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ), // empty box
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    Todo todo = provider.todos[index];
                    // tile to display todo
                    return ListTile(
                      // displaying id
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 16,
                        child: Text(
                          todo.id,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      // displaying title
                      title: Text(
                        todo.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      // displaying weekday
                      subtitle: Text(
                        weekdays[todo.createdAt - 1],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.black,
                    );
                  },
                  itemCount: provider.todos.length,
                ),
              ),
            ),
            Visibility(
              visible: provider.isTodoFetching,
              child: const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
