class user {
  String? id;
  String? email;
  bool? emailVerified;
  int? role;
  String? firstName;
  String? lastName;
  Null? phoneNumber;
  Null? birthDate;
  Null? gender;
  Null? photo;
  Null? bloodType;
  Null? length;
  Null? weight;
  Null? chronicDisease;
  Null? geneticDisease;
  Null? otherInfo;
  Null? license;
  bool? availableForMeeting;
  Null? city;
  Null? specialization;

  user(
      {this.id,
      this.email,
      this.emailVerified,
      this.role,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.birthDate,
      this.gender,
      this.photo,
      this.bloodType,
      this.length,
      this.weight,
      this.chronicDisease,
      this.geneticDisease,
      this.otherInfo,
      this.license,
      this.availableForMeeting,
      this.city,
      this.specialization});

  user.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    emailVerified = json['email_verified'];
    role = json['role'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    photo = json['photo'];
    bloodType = json['blood_type'];
    length = json['length'];
    weight = json['weight'];
    chronicDisease = json['chronic_disease'];
    geneticDisease = json['genetic_disease'];
    otherInfo = json['other_info'];
    license = json['license'];
    availableForMeeting = json['available_for_meeting'];
    city = json['city'];
    specialization = json['specialization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['email_verified'] = this.emailVerified;
    data['role'] = this.role;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['birth_date'] = this.birthDate;
    data['gender'] = this.gender;
    data['photo'] = this.photo;
    data['blood_type'] = this.bloodType;
    data['length'] = this.length;
    data['weight'] = this.weight;
    data['chronic_disease'] = this.chronicDisease;
    data['genetic_disease'] = this.geneticDisease;
    data['other_info'] = this.otherInfo;
    data['license'] = this.license;
    data['available_for_meeting'] = this.availableForMeeting;
    data['city'] = this.city;
    data['specialization'] = this.specialization;
    return data;
  }
}
