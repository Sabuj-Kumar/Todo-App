import 'package:bloc/bloc.dart';
import 'package:mind_orbit_todo/Bloc/todo_event.dart';
import 'package:mind_orbit_todo/Bloc/todo_state.dart';
import 'package:mind_orbit_todo/Models/todo_model.dart';

class TodoBloc extends Bloc<TodoEvent,TodoState>{

  TodoBloc() : super(const TodoState()){
    on<AddTodo>(_onAddTodo);
    on<EditTodo>(_onEditTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<DoneOrNotDone>(_todoDoneOrNot);
  }

  _onAddTodo(AddTodo addTodo,Emitter<TodoState> emit) {

    print("${addTodo.todoModel.todoName}");
    final state = this.state;
    emit(TodoState(allTodo: List.from(state.allTodo)..add(addTodo.todoModel)));
  }

  _onEditTodo(EditTodo editTodo,Emitter<TodoState> emit){

    final state = this.state;
    final int index = state.allTodo.indexOf(editTodo.previousTodo);
    List<TodoModel> list = List.from(state.allTodo)..remove(editTodo.previousTodo);
    emit(TodoState(allTodo: list..insert(index,editTodo.todoModel)));
  }

  _onDeleteTodo(DeleteTodo deleteTodo,Emitter<TodoState> emit) {

    final state = this.state;
    List<TodoModel> list = List.from(state.allTodo)..remove(deleteTodo.todoModel);
    emit(TodoState(allTodo: list));
  }

  _todoDoneOrNot(DoneOrNotDone doneOrNotDone,Emitter<TodoState> emit){

    final state = this.state;
    final todo = doneOrNotDone.todoModel;
    final int index = state.allTodo.indexWhere((element) => element.todoName == doneOrNotDone.todoModel.todoName);

    List<TodoModel> list = List.from(state.allTodo)..remove(todo);

    if(list.length <= index) {
        todo.todoDone == false ? list.add(todo.copyWith(
          todoDone: true,
        )) : list.add(todo.copyWith(
          todoDone: false,
        ));
     }
    else{
      todo.todoDone == false ? list.insert(index,todo.copyWith(
        todoDone: true,
      )) : list.insert(index,todo.copyWith(
        todoDone: false,
      ));
    }
    emit(TodoState(allTodo: list));
  }
}
