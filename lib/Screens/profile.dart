import 'package:flutter/material.dart';
import 'package:management/main.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
 @override
 _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
 String _username = 'Esther Wangari';
 String _email = 'esskaree@gmail.com';
 String _language = 'English';
 bool _isDarkMode = true;

 // Move these variables to the class level
 DateTime _selectedDate = DateTime.now();
 TimeOfDay _selectedTime = TimeOfDay.now();
 String _dateTimeFormat = 'MM/dd/yyyy'; 
 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ListView(
        children: <Widget>[
          _buildProfilePicture(),
          _buildUsername(),
          _buildEmail(),
          _buildDateTimeFormat(),
          _buildLogoutButton(),
        ],
      ),
    );
 }

 Widget _buildProfilePicture() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage
        ('https://www.google.com/imgres?q=black%20woman&imgurl=https%3A%2F%2Fimageio.forbes.com%2Fspecials-images%2Fdam%2Fimageserve%2F1150881602%2F0x0.jpg%3Fformat%3Djpg%26height%3D900%26width%3D1600%26fit%3Dbounds&imgrefurl=https%3A%2F%2Fwww.forbes.com%2Fsites%2Fjanicegassam%2F2019%2F05%2F31%2Fovercoming-the-angry-black-woman-stereotype%2F&docid=TLlHQ6zlZADCHM&tbnid=LSe0BWwmvPtI_M&vet=12ahUKEwivxKTNr7iFAxXFhv0HHeMLDjAQM3oECBYQAA..i&w=1350&h=900&hcb=2&ved=2ahUKEwivxKTNr7iFAxXFhv0HHeMLDjAQM3oECBYQAA'),
      ),
      title: Text('Profile Picture'),
    );
 }

 Widget _buildUsername() {
    return ListTile(
      title: Text('Username'),
      subtitle: Text(_username),
    );
 }

 Widget _buildEmail() {
    return ListTile(
      title: Text('Email'),
      subtitle: Text(_email),
    );
 }

 Widget _buildDateTimeFormat() {
    return ListTile(
      title: Text('Date and Time Format'),
      subtitle: Text(_dateTimeFormat),
      onTap: () async {
        // Show date picker
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(DateTime.now().year - 5),
          lastDate: DateTime(DateTime.now().year + 5),
        );

        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
          });
        }

        // Show time picker
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: _selectedTime,
        );

        if (pickedTime != null) {
          setState(() {
            _selectedTime = pickedTime;
          });
        }

        // Update the format display based on the selected date and time
        // This is a simple example; you might want to allow users to select a format
        _dateTimeFormat = DateFormat(_dateTimeFormat).format(_selectedDate);
      },
    );
 }




 Widget _buildLogoutButton() {
    return ElevatedButton(
      onPressed: () {
        // Implement logout logic
        Navigator.pushReplacementNamed(context, '/Login_Page');
      },
      child: Text('Logout'),
    );
 }
}
