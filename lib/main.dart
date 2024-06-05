import 'package:flutter/material.dart';

void main() {
  runApp(GmailCloneApp());
}

class GmailCloneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gmail Clone',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Email> emails = List.generate(
    20,
    (index) => Email(
      subject: 'Email Subject $index',
      sender: 'sender$index@example.com',
      body: 'This is the body of email $index.',
    ),
  );

  List<Email> filteredEmails = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredEmails = emails;
    searchController.addListener(() {
      filterEmails();
    });
  }

  void filterEmails() {
    setState(() {
      filteredEmails = emails
          .where((email) => email.subject
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://via.placeholder.com/150'), 
            radius: 20,
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search emails',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(child: EmailList(emails: filteredEmails)),
          GoogleMeetWidget(),
        ],
      ),
    );
  }
}

class EmailList extends StatelessWidget {
  final List<Email> emails;

  EmailList({required this.emails});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: emails.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(emails[index].subject),
          subtitle: Text(emails[index].sender),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EmailDetailScreen(email: emails[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class EmailDetailScreen extends StatelessWidget {
  final Email email;

  EmailDetailScreen({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(email.subject),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              email.sender,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(email.body),
          ],
        ),
      ),
    );
  }
}

class GoogleMeetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: ListTile(
        leading: Icon(Icons.video_call, color: Colors.white),
        title: Text('Google Meet', style: TextStyle(color: Colors.black38)),
        subtitle: Text('Join or start a meeting',
            style: TextStyle(color: Colors.white70)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GoogleMeetScreen()),
          );
        },
      ),
    );
  }
}

class GoogleMeetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Meet'),
      ),
      body: Center(
        child: Text('Go Back '),
      ),
    );
  }
}
class Email {
  final String subject;
  final String sender;
  final String body;

  Email({required this.subject, required this.sender, required this.body});
}

