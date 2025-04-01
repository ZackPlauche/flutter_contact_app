import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ContactsPage(title: 'Flutter Contact App'),
    );
  }
}

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key, required this.title});

  final String title;

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    try {
      debugPrint('Attempting to request contact permission...');
      // Request contact permission
      if (!await FlutterContacts.requestPermission(readonly: true)) {
        debugPrint('Permission denied by user');
        setState(() => _permissionDenied = true);
        return;
      }
      
      debugPrint('Permission granted, fetching contacts...');
      // Fetch all contacts (with thumbnail)
      final contacts = await FlutterContacts.getContacts(
        withPhoto: true,
        withThumbnail: true,
      );
      
      debugPrint('Fetched ${contacts.length} contacts');
      setState(() => _contacts = contacts);
    } catch (e) {
      debugPrint('Error fetching contacts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchContacts,
        tooltip: 'Refresh Contacts',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _body() {
    if (_permissionDenied) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.no_accounts, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Contact permission denied',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _fetchContacts,
              child: const Text('Request Permission Again'),
            ),
          ],
        ),
      );
    }
    
    if (_contacts == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            const Text('Loading contacts...'),
            const SizedBox(height: 8),
            Text('If this takes too long, check permission prompts',
                style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
      );
    }
    
    if (_contacts!.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.contacts, size: 48, color: Colors.blue),
            SizedBox(height: 16),
            Text('No contacts found on this device', style: TextStyle(fontSize: 18)),
          ],
        ),
      );
    }
    
    return ListView.builder(
      itemCount: _contacts!.length,
      itemBuilder: (context, index) {
        final contact = _contacts![index];
        return ListTile(
          leading: contact.thumbnail != null
              ? CircleAvatar(backgroundImage: MemoryImage(contact.thumbnail!))
              : CircleAvatar(child: Text(contact.displayName[0])),
          title: Text(contact.displayName),
          onTap: () async {
            final fullContact = await FlutterContacts.getContact(contact.id);
            if (!mounted) return;
            
            // Show contact details in a dialog
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(fullContact?.displayName ?? 'Contact Details'),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (fullContact?.phones.isNotEmpty ?? false)
                        ...[
                          const Text('Phone numbers:', style: TextStyle(fontWeight: FontWeight.bold)),
                          ...fullContact!.phones.map((phone) => Text('${phone.label}: ${phone.number}')),
                          const SizedBox(height: 16),
                        ],
                      
                      if (fullContact?.emails.isNotEmpty ?? false)
                        ...[
                          const Text('Emails:', style: TextStyle(fontWeight: FontWeight.bold)),
                          ...fullContact!.emails.map((email) => Text('${email.label}: ${email.address}')),
                        ],
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
