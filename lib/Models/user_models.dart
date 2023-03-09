class UserModel {
  String uid;
  String name;
  String? designation;
  String? bio;
  String email;
  String imageURL;
  List<String>? connectedList;
  String? github;
  String? linkedin;
  String? twitter;
  String? portfolio;
  bool isPrivate;

  UserModel({
    required this.uid,
    required this.name,
    this.designation,
    this.bio,
    required this.email,
    required this.imageURL,
    this.connectedList,
    this.github,
    this.linkedin,
    this.twitter,
    this.portfolio,
    required this.isPrivate,
  });

  // Convert a EventDetailsModel object into a Map object
  // Fetch data from Firestore and convert it into a Map
  factory UserModel.fromMap(Map<String, dynamic>? map) {
    return UserModel(
      uid: map!['uid'],
      name: map['name'],
      designation: map['designation'],
      bio: map['bio'],
      email: map['email'],
      imageURL: map['imageURL'],
      connectedList: map['connectedList'].cast<String>(),
      github: map['github'],
      linkedin: map['linkedin'],
      twitter: map['twitter'],
      portfolio: map['portfolio'],
      isPrivate: map['isPrivate'],
    );
  }

  Map<String, dynamic> ToMap(UserModel user) {
    Map<String, dynamic> map = {
      "uid": user.uid,
      "name": user.name,
      "designation": user.designation,
      "bio": user.bio,
      "email": user.email,
      "imageURL": user.imageURL,
      "connectedList": user.connectedList,
      "github": user.github,
      "linkedin": user.linkedin,
      "twitter": user.twitter,
      "portfolio": user.portfolio,
      "isPrivate": user.isPrivate,
    };

    return map;
  }
}
