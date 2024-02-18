class recommPageProp {
  final dynamic id;
  final String imagePath;
  final String cityName;
  final String status;
  final dynamic bedroom;
  final dynamic bathroom;
  final dynamic garage;
  final String location;

  recommPageProp({
    required this.id,
    required this.imagePath,
    required this.cityName,
    required this.status,
    required this.bedroom,
    required this.bathroom,
    required this.garage,
    required this.location,
  });
}

List<Map<String, dynamic>> recommPage_Prop() {
  // Create a list to store property records.
  List<Map<String, dynamic>> properties = [
    {
      "id": 1,
      "url": "assets/images/house1.jpg",
      "cityName": "Gaza",
      "status": "for sale",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "location": 2.2,
    },
    {
      "id": 2,
      "url": "assets/images/house2.jpg",
      "cityName": "Nablus",
      "status": "for rent",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "location": 3.3,
    },
    {
      "id": 3,
      "url": "assets/images/house3.jpg",
      "cityName": "Ramallah",
      "status": "for sale",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "location": 2.2,
    },
    {
      "id": 4,
      "url": "assets/images/house4.jpg",
      "cityName": "Tullkarm",
      "status": "for rent",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "location": 422,
    },
    {
      "id": 5,
      "url": "assets/images/house4.jpg",
      "cityName": "Tullkarm",
      "status": "for rent",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "location": 422,
    },
    {
      "id": 6,
      "url": "assets/images/house4.jpg",
      "cityName": "Tullkarm",
      "status": "for rent",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "location": 422,
    },
    {
      "id": 7,
      "url": "assets/images/house4.jpg",
      "cityName": "Tullkarm",
      "status": "for rent",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "location": 422,
    },
    {
      "id": 8,
      "url": "assets/images/house4.jpg",
      "cityName": "Tullkarm",
      "status": "for rent",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "location": 422,
    },
    {
      "id": 9,
      "url": "assets/images/house4.jpg",
      "cityName": "Tullkarm",
      "status": "for rent",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "location": 422,
    },
    {
      "id": 10,
      "url": "assets/images/house4.jpg",
      "cityName": "Ramallah",
      "status": "for rent",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "location": 422,
    },
    // Add more property records as needed.
  ];

  // Ensure that the 'location' field is always a double.
  properties.forEach((property) {
    property["location"] = property["location"].toDouble();
    //print(property["location"]);
  });

  return properties;
}
