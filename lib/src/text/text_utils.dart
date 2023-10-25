part of easy_utils;

extension EasyString on String {
  // https://stackoverflow.com/a/54180384
  bool equalsIgnoreCase(String? other) {
    return toLowerCase() == other?.toLowerCase();
  }

  List<int> indexesOf(String char) {
    assert(char.length == 1);

    List<int> out = [];

    for (int i = 0; i < length; i++) {
      if (this[i] == char) {
        if (i > 0 && this[i - 1] == r'\') {
          continue;
        }

        out.add(i);
      }
    }

    return out;
  }

  List<String> splitExtended(String sep, [int? index]) {
    var indexes = indexesOf(sep);

    if (index == null) {
      var out = <String>[];
      for (int i = 0; i < indexes.length; i++) {
        var index = i == 0 ? 0 : (indexes[i - 1] + 1);
        out.add(substring(index, indexes[i]));
      }

      return out;
    }

    assert(index > 0);
    index -= 1;

    return indexes.length <= index
        ? [this]
        : [substring(0, indexes[index]), substring(indexes[index] + 1)];
  }
}
