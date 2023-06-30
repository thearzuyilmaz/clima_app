import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async {
  task1();
  print(await task2());

  //String task2result = await task2();
  //task3(task2result);
}

void task1() {
  print('Task 1 complete');
}

Future<String> task2() async {
  String result = 'initial value';

  Duration threeSeconds = Duration(seconds: 3);
  await Future.delayed(threeSeconds, () {
    result = 'Task2 result';
    print('Task 2 complete');
  });

  return result;
}

void task3(String task2result) {
  print('Task 3 complete with $task2result');
}
