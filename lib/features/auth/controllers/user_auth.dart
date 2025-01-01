// user_auth.dart

import 'package:flutter_application_1/utils/databaseHelper.dart';

class User {
  final int? id; // Add an ID to represent the user in the database
  final String username;
  final String firstName;
  final String lastName;
  final String password;
  final String email;

  User({
    this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.email,
  });

  // Convert a User into a Map to insert into the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };
  }

  // Create a User from a Map (database record)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      password: map['password'],
    );
  }

  static final DatabaseHelper _dbHelper = DatabaseHelper();

  // Authenticate a user
  static Future<User?> authenticate(String username, String password) async {
    final users = await _dbHelper.authUser(username, password);
    if (users.isNotEmpty) {
      return User.fromMap(users.first); // Return the authenticated user
    }
    return null; // Authentication failed
  }

  // Register a new user
  static Future<bool> register(User newUser) async {
    final db = await _dbHelper.database;

    // Check if the username already exists
    final existingUsers = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [newUser.username],
    );

    if (existingUsers.isNotEmpty) {
      // Username already exists
      return false;
    }

    // Add the new user to the database
    await db.insert('users', newUser.toMap());
    return true; // Registration successful
  }
}

// Global variable for the current user
User? currentUser;

// Global function to authenticate a user and set `currentUser`
Future<bool> authenticateAndSetUser(String username, String password) async {
  final user = await User.authenticate(username, password);
  if (user != null) {
    currentUser = user; // Save the user object globally
    return true;
  }
  return false;
}

// Global function to register a new user
Future<bool> registerNewUser(String username, String firstName, String lastName,
    String password, String email) async {
  final newUser = User(
    username: username,
    firstName: firstName,
    lastName: lastName,
    password: password,
    email: email,
  );
  return await User.register(newUser);
}
