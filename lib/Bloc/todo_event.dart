import 'package:mind_orbit_todo/Models/todo_model.dart';

abstract class TodoEvent{}

class AddTodo extends TodoEvent{
    final TodoModel todoModel;
    AddTodo({required this.todoModel});
}

class DeleteTodo extends TodoEvent{
  final TodoModel todoModel;
  DeleteTodo({required this.todoModel});
}

class EditTodo extends TodoEvent{
  final TodoModel todoModel;
  final TodoModel previousTodo;
  EditTodo({required this.previousTodo,required this.todoModel});
}

class DoneOrNotDone extends TodoEvent{
  final TodoModel todoModel;
  DoneOrNotDone({required this.todoModel});
}
