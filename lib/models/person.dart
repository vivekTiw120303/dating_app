import 'package:cloud_firestore/cloud_firestore.dart';

class Person {

  // Personal Info
  String? uid;
  String? imageProfile;
  String? email;
  String? password;
  String? name;
  String? gender;
  int? age;
  String? phoneNo;
  String? city;
  String? country;
  String? profileHeading;
  String? lookingForInAPartner;
  int? publishedTime;


  // Appearance
  String? height;
  String? weight;
  String? bodyType;

  // LifeStyle
  String? drink;
  String? smoke;
  String? martialStatus;
  String? haveChildren;
  String? noOfChildren;
  String? profession;
  String? employmentStatus;
  String? income;
  String? livingSituation;
  String? willingToRelocate;
  String? relationshipYouAreLookingFor;

  // Cultural
  String? nationality;
  String? education;
  String? languageSpoken;
  String? religion;

  Person({
    // Personal Info
    this.uid,
    this.imageProfile,
    this.email,
    this.password,
    this.name,
    this.age,
    this.gender,
    this.phoneNo,
    this.city,
    this.country,
    this.profileHeading,
    this.lookingForInAPartner,
    this.publishedTime,

    // Appearance
    this.height,
    this.weight,
    this.bodyType,

    // LifeStyle
    this.drink,
    this.smoke,
    this.martialStatus,
    this.haveChildren,
    this.noOfChildren,
    this.profession,
    this.employmentStatus,
    this.income,
    this.livingSituation,
    this.willingToRelocate,
    this.relationshipYouAreLookingFor,

    // Cultural
    this.nationality,
    this.education,
    this.languageSpoken,
    this.religion,
  });

  static Person fromJson(DocumentSnapshot snapshot) {
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;

    return Person(
      // Personal Info
      uid: dataSnapshot["uid"],
      imageProfile: dataSnapshot["imageProfile"],
      email: dataSnapshot["email"],
      password: dataSnapshot["password"],
      name: dataSnapshot["name"],
      age: dataSnapshot["age"],
      gender: dataSnapshot["gender"],
      phoneNo: dataSnapshot["phoneNo"],
      city: dataSnapshot["city"],
      country: dataSnapshot["country"],
      profileHeading: dataSnapshot["profileHeading"],
      lookingForInAPartner: dataSnapshot["lookingForInAPartner"],
      publishedTime: dataSnapshot["publishedTime"],

      // Appearance
      height: dataSnapshot["height"],
      weight: dataSnapshot["weight"],
      bodyType: dataSnapshot["bodyType"],

      // LifeStyle
      drink: dataSnapshot["drink"],
      smoke: dataSnapshot["smoke"],
      martialStatus: dataSnapshot["martialStatus"],
      haveChildren: dataSnapshot["haveChildren"],
      noOfChildren: dataSnapshot["noOfChildren"],
      profession: dataSnapshot["profession"],
      employmentStatus: dataSnapshot["employmentStatus"],
      income: dataSnapshot["income"],
      livingSituation: dataSnapshot["livingSituation"],
      willingToRelocate: dataSnapshot["willingToRelocate"],
      relationshipYouAreLookingFor: dataSnapshot["relationshipYouAreLookingFor"],

      // Cultural
      nationality: dataSnapshot["nationality"],
      education: dataSnapshot["education"],
      languageSpoken: dataSnapshot["languageSpoken"],
      religion: dataSnapshot["religion"],
    );
  }

  // Convert Person object to a JSON map
  Map<String, dynamic> toJson() => {
    // Personal Info
    'uid': uid,
    'imageProfile': imageProfile,
    'email': email,
    'password': password,
    'name': name,
    'age': age,
    'gender': gender,
    'phoneNo': phoneNo,
    'city': city,
    'country': country,
    'profileHeading': profileHeading,
    'lookingForInAPartner': lookingForInAPartner,
    'publishedTime': publishedTime,

    // Appearance
    'height': height,
    'weight': weight,
    'bodyType': bodyType,

    // LifeStyle
    'drink': drink,
    'smoke': smoke,
    'martialStatus': martialStatus,
    'haveChildren': haveChildren,
    'noOfChildren': noOfChildren,
    'profession': profession,
    'employmentStatus': employmentStatus,
    'income': income,
    'livingSituation': livingSituation,
    'willingToRelocate': willingToRelocate,
    'relationshipYouAreLookingFor': relationshipYouAreLookingFor,

    // Cultural
    'nationality': nationality,
    'education': education,
    'languageSpoken': languageSpoken,
    'religion': religion,
  };
}