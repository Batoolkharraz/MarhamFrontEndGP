// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//  final FirebaseFirestore firestore = FirebaseFirestore.instance;
 
  
// class ChatScreen extends StatefulWidget {
//   final String ruseremail;
//   final String reid;

//   const ChatScreen({
//     Key? key,
//     required this.ruseremail,
//     required this.reid,
//   }) : super(key: key);

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {

//   final TextEditingController messageController = TextEditingController();
 
//   final FirebaseAuth auth = FirebaseAuth.instance;
// late User signedinuser;
//   String? messagetext;
//   var _email;
//   var _id;

//   @override
//   void initState() {
//     super.initState();
//     _email = widget.ruseremail;
//     _id = widget.reid;
//     getcurrentuser();
//   }

//   void getcurrentuser() {
//     try {
//       var user = auth.currentUser;
//       if (user != null) {
//         signedinuser = user;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 140,
//         backgroundColor: Colors.white,
//         title: Row(
//           children: [
//             SizedBox(width: 10),
//             Spacer(),
//             Text(
//               _email,
//               style: TextStyle(
//                 fontSize: 33,
//                 color: Color(0xFF0561DD),
//                 fontFamily: 'Salsa',
//               ),
//             ),
//             Spacer(),
//             Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.blue, width: 3),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Color(0xFF0561DD).withOpacity(0.3),
//                     offset: Offset(0, 4),
//                     blurRadius: 15,
//                   ),
//                 ],
//               ),
//               child: CircleAvatar(
//                 radius: 33,
//                 backgroundImage: AssetImage("assets/5bbc3519d674c.jpg"),
//               ),
//             ),
//           ],
//         ),
//         leading: BackButton(
//           color: Colors.black,
//           onPressed: () => {Navigator.of(context).pop()},
//         ),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(child:  StreamBuilder<QuerySnapshot>(
//               stream: firestore.collection('messages').
//               where('emailsender',isEqualTo:signedinuser.email).
//               where('receiver',isEqualTo:_email).snapshots(),
//               builder: (context, snapshot) {
//                 List<MessageLine> messageWidgets = [];
//                 if (!snapshot.hasData) {
//                   return Center(
//                     child: CircularProgressIndicator(
//                       backgroundColor: Colors.blue,
//                     ),
//                   );
//                 }
//                 final messages = snapshot.data!.docs;
//                 for (var item in messages) {
//                   final textm = item.get('text');
//                   final send = item.get('emailsender');
                 
//                   final messageWidget = MessageLine(textm: textm, sender: send);
//                   messageWidgets.add(messageWidget);
//                 }
//                 return ListView(
//            physics: BouncingScrollPhysics(),
//                   children: messageWidgets,
//                 );
//               },
//           )),
//           Container(
//             decoration: BoxDecoration(
//               border: Border(
//                 top: BorderSide(color: Colors.blue, width: 2),
//               ),
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     style: TextStyle(fontSize: 27),
//                     controller: messageController,
//                     onChanged: (text) {
//                       setState(() {
//                         messagetext = text;
//                       });
//                     },
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.symmetric(
//                         vertical: 25,
//                         horizontal: 20,
//                       ),
//                       hintText: 'Write your message here...',
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   child: Container(
//                     width: 50,
//                     padding: EdgeInsets.only(left: 10, right: 10),
//                     child: FaIcon(
//                       FontAwesomeIcons.arrowRight,
//                       size: 30,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   onTap: () {
//                     print(messagetext);
//                     print(signedinuser);
//                     if (messagetext != null && messagetext!.isNotEmpty) {
//                       firestore.collection('messages').add({
//                         'emailsender': signedinuser.email,
//                         'text': messagetext,
//                         'receiver':_email,
                        
//                       });
//                     }
//                     messageController.clear();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MessageLine extends StatelessWidget {
//   const MessageLine({this.textm, this.sender, Key? key}) : super(key: key);
//   final String? textm;
//   final String? sender;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
    
//           Padding(
//             padding: const EdgeInsets.only(right:13.0),
//             child: Text(
//               '$sender',
//               style: TextStyle(fontSize: 19),
//             ),
//           ),
//           Material(
//             borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           bottomRight:Radius.circular(30),
//           bottomLeft: Radius.circular(30), 
//             ),
//             color: Colors.blue,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               child: Text(
//                 '$textm',
//                 style: TextStyle(
//                   fontSize: 26,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
