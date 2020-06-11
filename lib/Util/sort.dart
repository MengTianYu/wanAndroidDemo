import 'dart:math';

class test {
  var number = <int>[];

  void sort() {
    number.clear();

    int x;
    int t;
    if (number.length <= 0) {
      Random random = new Random.secure();
      number.add(random.nextInt(100));
      number.add(random.nextInt(100));
      number.add(random.nextInt(100));
      number.add(random.nextInt(100));
      number.add(random.nextInt(100));
      number.add(random.nextInt(100));
      number.add(random.nextInt(100));
      number.add(random.nextInt(100));
      number.add(random.nextInt(100));
      number.add(random.nextInt(100));
      number.add(random.nextInt(100));
      number.add(random.nextInt(100));
    }
    print(number.toString());
//    //冒泡
//    for (int i = 0; i < number.length; i++) {
//      for (int j = 0; j < number.length; j++) {
//        if (number[i] > number[j]) {
//          x = number[i];
//          number[i] = number[j];
//          number[j] = x;
//        }
//      }
//    }
//
//    //选择排序
//    for (int i = 0; i < number.length; i++) {
//      x = i;
//      for (int j = i; j < number.length; j++) {
//        if (number[j] < number[x]) {
//          x = j;
//        }
//      }
//      t = number[i];
//      number[i] = number[x];
//      number[x] = t;
//    }

    //插入排序
    int index;
    for (int i = 1; i < number.length; i++) {
      t = number[i];
      index = i;
      for (int j = i; j > 0; j--) {
        if (j > 0 && t < number[j - 1]) {
          number[j] = number[j - 1];
          index = j - 1;
        } else {
          break;
        }
      }
      number[index] = t;
    }
    print(number.toString());
  }
}
