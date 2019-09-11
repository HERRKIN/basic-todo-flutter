// Import MaterialApp and other widgets which we can use to quickly create a material app
import 'package:flutter/material.dart';

void main() => runApp( TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Todo List',
      home:  TodoList()
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() =>  TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  // This will be called each time the + button is pressed
  void _addTodoItem(String task) {
    // Putting our code inside "setState" tells the app that our state has changed, and
    // it will automatically re-render the list
    setState(() {
      if(task.length>0){
      _todoItems.add(task);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
  return  Scaffold(
    appBar:  AppBar(
      title:  Text('Todo List')
    ),
    body: _buildTodoList(),
    floatingActionButton:  FloatingActionButton(
      onPressed: _pushAddTodoScreen, // pressing this button now opens the  screen
      tooltip: 'Add task',
      child:  Icon(Icons.add)
    ),
  );
}

// Build the whole list of todo items
  Widget _buildTodoList() {
  return  ListView.builder(
    itemBuilder: (context, index) {
      if(index < _todoItems.length) {
        return _buildTodoItem(_todoItems[index], index);
      }
    },
  );
}
void _promptRemoveTodoItem(int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return  AlertDialog(
        title:  Text('Mark "${_todoItems[index]}" as done?'),
        actions: <Widget>[
           FlatButton(
            child:  Text('CANCEL'),
            onPressed: () => Navigator.of(context).pop()
          ),
           FlatButton(
            child:  Text('MARK AS DONE'),
            onPressed: () {
              _removeTodoItem(index);
              Navigator.of(context).pop();
            }
          )
        ]
      );
    }
  );
}

  // Build a single todo item
Widget _buildTodoItem(String todoText, int index) {
  return  ListTile(
    title:  Text(todoText),
    onTap: () => _promptRemoveTodoItem(index)
  );
}
void _pushAddTodoScreen() {
  // Push this page onto the stack
  Navigator.of(context).push(
    // MaterialPageRoute will automatically animate the screen entry, as well
    // as adding a back button to close it
     MaterialPageRoute(
      builder: (context) {
        return  Scaffold(
          appBar:  AppBar(
            title:  Text('Add a new task')
          ),
          body:  TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context); // Close the add todo screen
            },
            decoration:  InputDecoration(
              hintText: 'Enter something to do...',
              contentPadding: const EdgeInsets.all(16.0)
            ),
          )
        );
      }
    )
  );}
  // Much like _addTodoItem, this modifies the array of todo strings and
// notifies the app that the state has changed by using setState
void _removeTodoItem(int index) {
  setState(() => _todoItems.removeAt(index));
}
}