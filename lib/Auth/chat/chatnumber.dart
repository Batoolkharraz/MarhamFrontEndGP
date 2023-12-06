import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/chat/mk.dart';
import 'package:flutter_application_4/Auth/chat/time.dart';

class PersonChat extends StatefulWidget {
  final String email;
  

  const PersonChat({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<PersonChat> createState() => _PersonChatState();
}

class _PersonChatState extends State<PersonChat> {
  late String _email; // Declare a local variable to store the email

  late String username; // Declare a variable to store the username

  @override
  void initState() {
    super.initState();
    _email = widget.email; // Get the email value from the widget
    
    // useer(); // Call the useer() function to fetch the username
  }

//  void useer() async {
//   // If you're in an async function:
//   final fetchedUsername = await getUserName(_email); // Fetch the username using getUserName()

//   // Check if the widget is still mounted before updating the state
//   if (mounted) {
//     setState(() {
//       username = fetchedUsername; // Update the username only if the widget is still mounted
//     });
//   }
//   print("Username: $username"); // Print the fetched username
// }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell( // Wrap the container in an InkWell to handle taps
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey, // Choose your border color
                width: 2.0, // Choose the width of the border
              ),
            ),
          ),
          width: 600,
          height: 130,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 25), // Add some space to the left
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // Make the profile picture circular
                    border: Border.all(color: Colors.blue, width: 3), // Add a blue border
                    boxShadow: [ // Add a shadow effect
                      BoxShadow(
                        color: const Color(0xFF0561DD).withOpacity(0.3), // Set the shadow color and opacity
                        offset: const Offset(0, 4), // Set the shadow offset
                        blurRadius: 15, // Set the shadow blur radius
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('assets/5bbc3519d674c.jpg'), // Set the profile picture image
                    radius: 40, // Set the profile picture size
                  ),
                ),
                const SizedBox(width: 18), // Add some space between the profile picture and the username
                Expanded( // Stretch the username text to fill the remaining space
                  child: Padding(
                    padding: const EdgeInsets.only(right: 70), // Add some padding to the right
                    child: Text(
  _email, // Display "Loading..." if username is not available yet
  style: const TextStyle(
    color: Colors.black,
    fontSize: 30,
    fontWeight: FontWeight.w500,
    fontFamily: 'Salsa',
  ),
),
                  ),
                ),
                const SizedBox(width: 25), // Add some space to the right
                const Text("l", style: TextStyle(fontSize: 20)), // Add a placeholder text for the last seen time
                const SizedBox(width: 25), // Add some space to the right
              ],
            ),
          ),
        ),
        onTap: () {
          print("InkWell tapped");
          Navigator.of(context).push( // Navigate to the ChatScreen when the InkWell is tapped
            MaterialPageRoute(
              builder: (context) {
                print("Navigating to ChatScreen");
                return ChatScreen(
                  ruseremail: _email, // Pass the user's email to the ChatScreen
                );
              },
            ),
          );
        }
      )
    );

      
    
  }
}
