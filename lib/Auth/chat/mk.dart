import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_4/Auth/chat/gg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
 final FirebaseFirestore firestore = FirebaseFirestore.instance;
   const storage = FlutterSecureStorage(); 
class ChatScreen extends StatefulWidget {
  final String ruseremail;

  const ChatScreen({
    Key? key,
    required this.ruseremail,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController messageController = TextEditingController();
 
  final FirebaseAuth auth = FirebaseAuth.instance;
late User signedinuser;
  String? messagetext;
  var _email;
  var _id;

  @override
  
  void initState() {
    super.initState();
    _email = widget.ruseremail;
    getcurrentuser();
  }

  void getcurrentuser() {
    try {
      var user = auth.currentUser;
      if (user != null) {
        signedinuser = user;
      }
    } catch (e) {
      print(e);
    }
  }
   
String getChatRoomId() {
  // Create a unique chat room ID based on sender and receiver emails
  List<String?> participants = [signedinuser.email, _email];
  participants.sort(); // Sort emails to ensure consistency
  return participants.where((e) => e != null).join('_') ?? '';
  print("from mm+ ${signedinuser.email}");
}
 
  @override
  Widget build(BuildContext context) {
    String chatRoomId = getChatRoomId();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const SizedBox(width: 10),
            const Spacer(),
            Text(
              _email,
              style: const TextStyle(
                fontSize: 33,
                color: Color(0xFF0561DD),
                fontFamily: 'Salsa',
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0561DD).withOpacity(0.3),
                    offset: const Offset(0, 4),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 33,
                backgroundImage: AssetImage("assets/5bbc3519d674c.jpg"),
              ),
            ),
          ],
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () => {Navigator.of(context).pop()},
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection('messages')
                  .doc(chatRoomId)
                  .collection('chats')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                List<MessageLine> messageWidgets = [];
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                    ),
                  );
                }
                final messages = snapshot.data!.docs;
                for (var item in messages) {
                  final textm = item.get('text');
                  final send = item.get('emailsender'); 
          
   
                // timestamp = item.get('timestamp');
                  final messageWidget =
                      MessageLine(textm: textm, sender: send,
                      isSender:signedinuser.email==send ,
                      );
                  messageWidgets.add(messageWidget);
                }
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: messageWidgets,
                );
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(fontSize: 27),
                    controller: messageController,
                    onChanged: (text) {
                      setState(() {
                        messagetext = text;
                      });
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 25,
                        horizontal: 20,
                      ),
                      hintText: 'Write your message here...',
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    width: 50,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: const FaIcon(
                      FontAwesomeIcons.arrowRight,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () {
                    
                    if (messagetext != null && messagetext!.isNotEmpty) {
                      firestore
                          .collection('messages')
                          .doc(chatRoomId)
                          .collection('chats')
                          .add({
                        'emailsender': signedinuser.email,
                        'text': messagetext,
                        'reciver':_email,
                        'timestamp': FieldValue.serverTimestamp(),

                      }
                      
                      );
                      var m=_email;
   storage.write(key: 'email', value: m);
   
  add(signedinuser.email);
                     
                     
                    }
                    messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
 

}

class MessageLine extends StatelessWidget {
  const MessageLine({this.textm, this.sender,required this.isSender,Key? key}) : super(key: key);
  final String? textm;
  final String? sender;
  final bool isSender;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
         crossAxisAlignment: isSender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
    
          Padding(
            padding: const EdgeInsets.only(right:13.0),
            child: Text(
              '$sender',
              style: const TextStyle(fontSize: 19),
            ),
          ),
          Material(
            borderRadius: isSender?
             const BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomRight:Radius.circular(30),
          bottomLeft: Radius.circular(30), 
            ):
             const BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight:Radius.circular(30),
          bottomLeft: Radius.circular(30), 
            ),
            color: isSender ? Colors.blue : const Color.fromARGB(197, 158, 158, 158),
           
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:14, horizontal: 20),
              child: Text(
                '$textm',
                style: const TextStyle(
                  fontSize: 26,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    
  }
  
}
