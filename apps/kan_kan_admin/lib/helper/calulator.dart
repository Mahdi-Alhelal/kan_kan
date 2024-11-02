calPer({required num value, required num total}) {
  double result = (value / total) * 100;
  
  if (result != 0) return result;
  return .1;
}