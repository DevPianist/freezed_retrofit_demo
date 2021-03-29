abstract class CustomBloc<T> {
  T get initialState;
  Stream<T> get stream;
  void dispose();
}
