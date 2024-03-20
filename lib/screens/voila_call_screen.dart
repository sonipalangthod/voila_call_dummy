import 'package:flutter/material.dart';
import 'package:voila_call_dummy/widgets/database_helper.dart';

class VoilaCallScreen extends StatefulWidget {
  @override
  _VoilaCallScreenState createState() => _VoilaCallScreenState();
}

class _VoilaCallScreenState extends State<VoilaCallScreen> {
  String selectedLead = 'not responding';
  TextEditingController nameController = TextEditingController();

  void submitData() async {
    String name = nameController.text;
    print('Data inserted into SQLite database: Name: $name, Lead: $selectedLead');
    await DatabaseHelper.insertCustomer(name, selectedLead); // Store customer data in the database
    nameController.clear();
    setState(() {
      selectedLead = 'not responding';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status of call'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name:',
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                controller: nameController,
              ),
              SizedBox(height: 20),
              Text(
                'Select Lead:',
                style: TextStyle(fontSize: 18),
              ),
              Column(
                children: [
                  RadioListTile(
                    title: Text('Not Responding'),
                    value: 'not responding',
                    groupValue: selectedLead,
                    onChanged: (value) {
                      setState(() {
                        selectedLead = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Open Lead'),
                    value: 'open lead',
                    groupValue: selectedLead,
                    onChanged: (value) {
                      setState(() {
                        selectedLead = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Warm Lead'),
                    value: 'warm lead',
                    groupValue: selectedLead,
                    onChanged: (value) {
                      setState(() {
                        selectedLead = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Cold Lead'),
                    value: 'cold lead',
                    groupValue: selectedLead,
                    onChanged: (value) {
                      setState(() {
                        selectedLead = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Hot Lead'),
                    value: 'hot lead',
                    groupValue: selectedLead,
                    onChanged: (value) {
                      setState(() {
                        selectedLead = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Customer'),
                    value: 'customer',
                    groupValue: selectedLead,
                    onChanged: (value) {
                      setState(() {
                        selectedLead = value.toString();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitData,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}