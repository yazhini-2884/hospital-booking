import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HospitalManageAppointment extends StatefulWidget {
  const HospitalManageAppointment({super.key});

  @override
  State<HospitalManageAppointment> createState() => _HospitalManageAppointmentState();
}

class _HospitalManageAppointmentState extends State<HospitalManageAppointment> {
  List<dynamic> pendingAppointments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPendingAppointments();
  }

  // Use 10.0.2.2 for Android emulator to access local Node API, or your machine's IP.
  // Using 10.0.2.2 as a default since flutter apps are usually tested on emulator.
  final String apiUrl = "http://10.0.2.2:3000/api/booking"; 

  Future<void> fetchPendingAppointments() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse('$apiUrl/all/pending'));
      if (response.statusCode == 200) {
        setState(() {
          pendingAppointments = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load pending appointments');
      }
    } catch (error) {
      print("Error fetching appointments: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updateStatus(String appointmentId, String newStatus) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/status'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "appointment_id": appointmentId,
          "status": newStatus,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Appointment $newStatus')),
        );
        // Refresh the list after update
        fetchPendingAppointments();
      } else {
        throw Exception('Failed to update status');
      }
    } catch (error) {
      print("Error updating status: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating appointment')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Manage Appointments',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : pendingAppointments.isEmpty
              ? const Center(
                  child: Text(
                    "No pending appointments",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: fetchPendingAppointments,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12.0),
                    itemCount: pendingAppointments.length,
                    itemBuilder: (context, index) {
                      final appointment = pendingAppointments[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.person, color: Colors.blue),
                                  const SizedBox(width: 8),
                                  Text(
                                    appointment['name'] ?? 'Unknown',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              const SizedBox(height: 8),
                              _buildDetailRow("Age", appointment['age']?.toString() ?? 'N/A'),
                              _buildDetailRow("City", appointment['city'] ?? 'N/A'),
                              _buildDetailRow("Date", appointment['appointment_date'] ?? 'N/A'),
                              _buildDetailRow("Time", appointment['appointment_time'] ?? 'N/A'),
                              _buildDetailRow("Reason", appointment['reason'] ?? 'N/A'),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      updateStatus(appointment['id'], "Confirmed");
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    icon: const Icon(Icons.check),
                                    label: const Text('Accept'),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      updateStatus(appointment['id'], "Rejected");
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    icon: const Icon(Icons.close),
                                    label: const Text('Decline'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}