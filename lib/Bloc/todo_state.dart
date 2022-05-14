import 'package:equatable/equatable.dart';
import 'package:mind_orbit_todo/Models/todo_model.dart';

class TodoState extends Equatable{
  const TodoState({this.allTodo = const <TodoModel>[]});
  final List<TodoModel> allTodo;

  @override
  List<Object?> get props => [allTodo];
}
