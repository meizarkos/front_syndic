String stringNullOrDefaultValue(String? value, String defaultValue) {
  return value ?? defaultValue;
}

String trimText(String title,int size){
  return title.length > size ? '${title.substring(0, size)}...' : title;
}

String? handleEmptyList(List<dynamic>? list, String defaultValue){
  if(list == null){
    return defaultValue;
  }
  if(list.isEmpty){
    return defaultValue;
  }
  return null;
}