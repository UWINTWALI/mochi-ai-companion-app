import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../domain/user_profile.dart';
import '../../auth/data/auth_service.dart';

class ProfileApiService {
  static const String baseUrl = 'http://your-backend-url:3000/api';
  final AuthService _authService;

  ProfileApiService(this._authService);

  Future<String> get _token async => await _authService.token;

  Future<UserProfile> getUserProfile() async {
    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Authorization': 'Bearer ${await _token}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return UserProfile.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<UserProfile> updateProfile(UserProfile profile) async {
    final response = await http.put(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Authorization': 'Bearer ${await _token}',
        'Content-Type': 'application/json',
      },
      body: json.encode(profile.toJson()),
    );

    if (response.statusCode == 200) {
      return UserProfile.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update profile');
    }
  }

  Future<String> uploadProfileImage(File image) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/profile/image'),
    );

    request.headers['Authorization'] = 'Bearer ${await _token}';
    request.files.add(
      await http.MultipartFile.fromPath('image', image.path),
    );

    final response = await request.send();
    final responseData = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final data = json.decode(responseData);
      return data['imageUrl'];
    } else {
      throw Exception('Failed to upload image');
    }
  }
}