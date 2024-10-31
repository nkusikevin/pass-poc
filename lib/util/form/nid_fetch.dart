import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NIDFetchField extends StatefulWidget {
  final String label;
  final String placeholder;
  final Function(Map<String, dynamic>) onNIDDetailsUpdated;

  NIDFetchField({
    required this.label,
    required this.placeholder,
    required this.onNIDDetailsUpdated,
  });

  @override
  _NIDFetchFieldState createState() => _NIDFetchFieldState();
}

class _NIDFetchFieldState extends State<NIDFetchField> {
  Map<String, dynamic>? _nidDetails;
  bool _isLoading = false;
  String _nidNumber = '';
  bool _hasShownPopup = false;

  Future<void> _fetchNidDetails() async {
    if (!_hasShownPopup) {
      await _showVerificationPopup();
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Mock the API response
      await Future.delayed(Duration(seconds: 2));
      if (_nidDetails != null) {
        widget.onNIDDetailsUpdated(_nidDetails!);
      } else {
        // Show verification popup again if details are null
        await _showVerificationPopup();
        if (_nidDetails != null) {
          widget.onNIDDetailsUpdated(_nidDetails!);
        } else {
          widget.onNIDDetailsUpdated({});
        }
      }
    } catch (e) {
      _nidDetails = null;
      widget.onNIDDetailsUpdated({});
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _showVerificationPopup() async {
    String? firstName;
    bool isVerified = false;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Verification',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  _nidDetails = null;
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  'Please enter one of the names of the owner of this ID number'),
              const SizedBox(height: 16),
              const Text(
                'First Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  hintText: "Enter the first name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
                onChanged: (value) {
                  firstName = value;
                },
              ),
            ],
          ),
          actions: [
            Container(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  if (firstName != null && firstName!.isNotEmpty) {
                    if (firstName!.toLowerCase() == 'john') {
                      isVerified = true;
                      _nidDetails = {
                        'firstName': 'John',
                        'lastName': 'Doe',
                        'nidNumber': _nidNumber,
                        'countryOfBirth': 'United States',
                      };
                    } else {
                      _nidDetails = null;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Incorrect name. Please try again.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                    _hasShownPopup = true;
                    Navigator.of(context).pop();
                  }
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ]),
    );

    setState(() {
      if (!isVerified) {
        _nidDetails = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
          ],
          validator: (value) {
            if (value == null || value.isEmpty || value.length != 16) {
              return 'Please enter a valid 16-digit NID number';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: widget.placeholder,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            suffixIcon: _isLoading
                ? Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 20,
                    height: 20,
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : null,
          ),
          onChanged: (value) {
            setState(() {
              _nidNumber = value;
            });
            if (value.length == 16) {
              _fetchNidDetails();
            }
          },
        ),
        if (_nidDetails != null)
          Container(
            margin: const EdgeInsets.only(top: 7),
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Applicant Details',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('First Name: ${_nidDetails?['firstName']}'),
                    Text('Last Name: ${_nidDetails?['lastName']}'),
                    Text('NID Number: ${_nidDetails?['nidNumber']}'),
                    Text('Country of Birth: ${_nidDetails?['countryOfBirth']}'),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
