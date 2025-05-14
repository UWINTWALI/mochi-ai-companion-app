import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data/profile_api_service.dart';
import '../domain/user_profile.dart';
import '../../auth/data/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  late final ProfileApiService _apiService;
  late Future<UserProfile> _profileFuture;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _bioController = TextEditingController();
  DateTime? _selectedDate;
  List<String> _selectedInterests = [];
  File? _imageFile;
  bool _isLoading = false;

  final _interests = [
    'Reading', 'Writing', 'Music', 'Sports', 
    'Technology', 'Travel', 'Cooking', 'Art'
  ];

  @override
  void initState() {
    super.initState();
    _apiService = ProfileApiService(_authService);
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      _profileFuture = _apiService.getUserProfile();
      final profile = await _profileFuture;
      
      if (!mounted) return;

      setState(() {
        _firstNameController.text = profile.firstName;
        _lastNameController.text = profile.lastName;
        _bioController.text = profile.bio ?? '';
        _selectedDate = profile.dateOfBirth;
        _selectedInterests = profile.interests;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load profile: $e')),
      );
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      String? imageUrl;
      if (_imageFile != null) {
        imageUrl = await _apiService.uploadProfileImage(_imageFile!);
      }

      final profile = UserProfile(
        email: _authService.userEmail ?? '',
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        bio: _bioController.text,
        interests: _selectedInterests,
        profileImageUrl: imageUrl,
        dateOfBirth: _selectedDate,
      );

      await _apiService.updateProfile(profile);
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _imageFile != null 
                      ? FileImage(_imageFile!) 
                      : null,
                  child: _imageFile == null
                      ? const Icon(Icons.camera_alt, size: 50)
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) =>
                    value?.isEmpty == true ? 'Please enter first name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) =>
                    value?.isEmpty == true ? 'Please enter last name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(labelText: 'Bio'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Date of Birth'),
                subtitle: Text(_selectedDate?.toString() ?? 'Not selected'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() => _selectedDate = date);
                  }
                },
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: _interests.map((interest) {
                  final isSelected = _selectedInterests.contains(interest);
                  return FilterChip(
                    label: Text(interest),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedInterests.add(interest);
                        } else {
                          _selectedInterests.remove(interest);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _saveProfile,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}