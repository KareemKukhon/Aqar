List<String> CalendarData() {
  return [
    'user0 - 2023-11-29 12:00:00.000 - 2023-11-29 12:30:00.000',
    'user1 - 2023-11-29 15:30:00.000 - 2023-11-29 16:00:00.000',
    'user2 - 2023-11-30 15:00:00.000 - 2023-11-30 15:30:00.000',
  ];
}
List<Map<String, String>> convertToJSON(List<String> data) {
    List<Map<String, String>> jsonList = [];
    for (String entry in data) {
      List<String> parts = entry.split(' - ');
      String userName = parts[0];
      String start = parts[1].split(' ')[1];
      String end = parts[2].split(' ')[1];

      Map<String, String> jsonEntry = {
        "userName": userName,
        "start": start,
        "end": end,
      };

      jsonList.add(jsonEntry);
    }
    return jsonList;
  }
