class UserProfile {
  final int? id;
  final String email;
  String firstName;
  String lastName;
  String? bio;
  List<String> interests;
  String? profileImageUrl;
  DateTime? dateOfBirth;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserProfile({
    this.id,
    required this.email,
    this.firstName = '',
    this.lastName = '',
    this.bio,
    this.interests = const [],
    this.profileImageUrl,
    this.dateOfBirth,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'bio': bio,
    'interests': interests.join(','),
    'profileImageUrl': profileImageUrl,
    'dateOfBirth': dateOfBirth?.toIso8601String(),
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json['id'],
    email: json['email'],
    firstName: json['firstName'] ?? '',
    lastName: json['lastName'] ?? '',
    bio: json['bio'],
    interests: json['interests']?.split(',') ?? [],
    profileImageUrl: json['profileImageUrl'],
    dateOfBirth: json['dateOfBirth'] != null 
        ? DateTime.parse(json['dateOfBirth'])
        : null,
    createdAt: json['createdAt'] != null 
        ? DateTime.parse(json['createdAt'])
        : null,
    updatedAt: json['updatedAt'] != null 
        ? DateTime.parse(json['updatedAt'])
        : null,
  );
}