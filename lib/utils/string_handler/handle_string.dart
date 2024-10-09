String stringNullOrDefaultValue(String? value, String defaultValue) {
  return value ?? defaultValue;
}

String trimText(String title,int size){
  return title.length > size ? '${title.substring(0, size)}...' : title;
}