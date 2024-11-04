double calPer({required num value, required num total}) {
  try {
    if (value != 0) {
      double result = (value / total) * 100;
      print("value : $value");
      print("result : $result");
      return result;
    }

    return .0000000000000001;
  } catch (e) {
    return .0000000000000001;
  }
}
