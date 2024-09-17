import 'package:flutter/material.dart';
import 'package:mvcr_agency_portal_wireframe/custom_dropdown_button.dart';
import 'package:mvcr_agency_portal_wireframe/main.dart';

class ReportDetails extends StatefulWidget {
  final Map<String, dynamic> report;

  ReportDetails({required this.report});

  @override
  _ReportDetailsState createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  List<String> assigneeItems = [
    'Stacy',
    'John',
    'Tom',
    'Emily'
  ]; // Add more assignees as needed
  bool _allExpanded = false;

  void _toggleAllPanels() {
    setState(() {
      _allExpanded = !_allExpanded;
      for (int i = 0; i < _isExpanded.length; i++) {
        _isExpanded[i] = _allExpanded;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth <= 600;
    bool isTablet = screenWidth > 600 && screenWidth <= 800;
    bool isDesktop = screenWidth > 800;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0),
        child: Container(
          width: double.infinity,
          height: 90.0,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 61, 121, 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 35,
                top: 6,
                child: SizedBox(
                  width: 95,
                  height: 95,
                  child: Image.asset('assets/images/logo-yrp.png'),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(builder: (context, constraints) {
          double containerWidth = constraints.maxWidth * 0.9;
          if (constraints.maxWidth < 1200) {
            containerWidth = constraints.maxWidth;
          }
          return Center(
            child: Container(
              width: containerWidth,
              padding: EdgeInsets.only(
                top: 40.0,
                bottom: 20,
                left: isMobile
                    ? 10
                    : isTablet
                        ? 20
                        : 90,
                right: isMobile
                    ? 10
                    : isTablet
                        ? 20
                        : 90,
              ),
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Report Details',
                    style: TextStyle(
                      fontSize: 32,
                      //fontFamily: 'ArchivoNarrow',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildReportDetailsContainer(),
                  const SizedBox(height: 20),
                  _buildCollisionInfoContainer(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  List<bool> _isExpanded = List.generate(7, (_) => false);

  Widget _buildCollisionInfoContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Aligns button to the right
              children: [
                ElevatedButton(
                  onPressed: _toggleAllPanels,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _allExpanded ? 'Collapse All' : 'Expand All',
                      style: const TextStyle(
                          color: Colors.white), // Set text color to white
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 61, 121, 1),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Rounded corners
                    ),
                  ),
                ),
              ],
            ),
          ),
          ExpansionPanelList(
            elevation: 1,
            expandedHeaderPadding: EdgeInsets.all(16),
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _isExpanded[index] = !isExpanded;
              });
            },
            children: [
              _buildExpansionPanel(
                0,
                'Collision Information',
                _buildCollisionInfoContent(),
              ),
              _buildExpansionPanel(
                1,
                "Reporting Driver's Information",
                _buildReportingDriverInfoContent(),
              ),

              // Add more panels for other sections
            ],
          )
        ],
      ),
    );
  }

  ExpansionPanel _buildExpansionPanel(int index, String title, Widget content) {
    return ExpansionPanel(
      canTapOnHeader: true,
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
      body: content,
      isExpanded: _isExpanded[index],
    );
  }

  Widget _buildCollisionInfoContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
      child: Wrap(
        spacing: 40,
        runSpacing: 40,
        children: [
          _buildDetailColumn(
              'Location of Collision', widget.report['Location'] ?? 'N/A'),
          _buildDetailColumn(
              '# of Vehicles Involved', widget.report['Time'] ?? 'N/A'),
          _buildDetailColumn(
              'Time of Collision', widget.report['Time'] ?? 'N/A'),
          _buildDetailColumn('Weather', widget.report['Time'] ?? 'N/A'),
          _buildDetailColumn('Road Conditions', widget.report['Time'] ?? 'N/A'),
          _buildDetailColumn('Road Surface', widget.report['Time'] ?? 'N/A'),
          _buildDetailColumn('Road Alignment', widget.report['Time'] ?? 'N/A'),
          _buildDetailColumn(
              'Pavement Markings?', widget.report['Time'] ?? 'N/A'),
          _buildDetailColumn(
              'Vehicle Direction', widget.report['Time'] ?? 'N/A'),
          _buildDetailColumn(
              'Damage to Property?', widget.report['Time'] ?? 'N/A'),
          _buildDetailColumn('Vehicle Parked?', widget.report['Time'] ?? 'N/A'),
        ],
      ),
    );
  }

  Widget _buildReportingDriverInfoContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
      child: Wrap(
        spacing: 40,
        runSpacing: 40,
        children: [
          _buildDetailColumn('Last Name', widget.report['Last Name'] ?? 'N/A'),
          _buildDetailColumn(
              'First Name', widget.report['First Name'] ?? 'N/A'),
          _buildDetailColumn(
              'Date of Birth', widget.report['First Name'] ?? 'N/A'),
          _buildDetailColumn(
              "Driver's License Number", widget.report['First Name'] ?? 'N/A'),
          _buildDetailColumn("Driver's License Province/State",
              widget.report['First Name'] ?? 'N/A'),
          _buildDetailColumn('Address', widget.report['First Name'] ?? 'N/A'),
          _buildDetailColumn(
              'Apt #/Unit', widget.report['First Name'] ?? 'N/A'),
          _buildDetailColumn('City/Town', widget.report['First Name'] ?? 'N/A'),
          _buildDetailColumn(
              'Province/State', widget.report['First Name'] ?? 'N/A'),
          _buildDetailColumn(
              'Postal Code/Zip Code', widget.report['First Name'] ?? 'N/A'),
          _buildDetailColumn(
              'Cell Phone Number', widget.report['First Name'] ?? 'N/A'),
          _buildDetailColumn(
              'Home Phone Number', widget.report['First Name'] ?? 'N/A'),
          _buildDetailColumn(
              'Business Phone Number', widget.report['First Name'] ?? 'N/A'),
          _buildDetailColumn('Email', widget.report['First Name'] ?? 'N/A'),
          _buildDetailColumn('Action at time of collision',
              widget.report['First Name'] ?? 'N/A'),
          _buildDetailColumn(
              'Wearing Seatbelt?', widget.report['First Name'] ?? 'N/A'),
          // Add other reporting driver info fields
        ],
      ),
    );
  }

// Create similar methods for other sections

  Widget _buildReportDetailsContainer() {
    return Container(
      width: 1000,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildReportDetailsColumns('Occurrence Number',
                  widget.report['Occurrence Number'].toString()),
              _buildAssigneeDropdown(widget.report),
              _buildReportDetailsColumns(
                  'Submission Date', widget.report['Submission Date']),
              _buildReportDetailsColumns(
                  'Follow up Date', widget.report['Follow up Date']),
              _buildStatusDropdown(),
            ],
          ),
          if (widget.report['Status'] == 'Approved - Pending Submission') ...{
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 230,
                child: ElevatedButton(
                  onPressed: () {
                    // Implement push to Versadex functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromRGBO(0, 61, 121, 1), // Background color
                    padding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 10.0),
                  ),
                  child: const Text(
                    'PUSH TO VERSADEX',
                    style: TextStyle(
                      color: Colors.white, // White text
                      letterSpacing:
                          1.5, // Adjust letter spacing for better readability in all caps
                    ),
                  ),
                ),
              ),
            )
          }
        ],
      ),
    );
  }

  // Widget _buildReportDetailsContainer() {
  //   return Container(
  //     width: 1000,
  //     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(15),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.3),
  //           spreadRadius: 2,
  //           blurRadius: 5,
  //           offset: const Offset(0, 3),
  //         ),
  //       ],
  //       border: Border.all(color: Colors.grey.shade300),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               'Occurrence Number:',
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 16,
  //               ),
  //             ),
  //             Text(
  //               'Assignee:',
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 16,
  //               ),
  //             ),
  //             Text(
  //               'Submission Date:',
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 16,
  //               ),
  //             ),
  //             Text(
  //               'Follow up Date:',
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 16,
  //               ),
  //             ),
  //             Text(
  //               'Status:',
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 16,
  //               ),
  //             ),
  //             // _buildDetailColumn('Occurrence Number',
  //             //     widget.report['Occurrence Number'].toString()),
  //             // _buildAssigneeDropdown(widget.report),
  //             // _buildDetailColumn(
  //             //     'Submission Date', widget.report['Submission Date']),
  //             // _buildDetailColumn(
  //             //     'Follow up Date', widget.report['Follow up Date']),
  //             // _buildStatusDropdown(),
  //           ],
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               widget.report['Occurrence Number'].toString(),
  //               style: TextStyle(
  //                 fontSize: 16,
  //               ),
  //             ),
  //             DropdownButton<String>(
  //               value: widget.report['Assignee'],
  //               items:
  //                   assigneeItems.map<DropdownMenuItem<String>>((String value) {
  //                 return DropdownMenuItem<String>(
  //                   value: value,
  //                   child: Text(value),
  //                 );
  //               }).toList(),
  //               onChanged: (String? newValue) {
  //                 setState(() {
  //                   widget.report['Assignee'] = newValue!;
  //                 });
  //               },
  //             ),
  //             Text(
  //               widget.report['Submission Date'],
  //               style: TextStyle(
  //                 fontSize: 16,
  //               ),
  //             ),
  //             Text(
  //               widget.report['Follow up Date'],
  //               style: TextStyle(
  //                 fontSize: 16,
  //               ),
  //             ),
  //             CustomDropdownButton(
  //               value: widget.report['Status'],
  //               items: const [
  //                 'Open',
  //                 'In Progress',
  //                 'On Hold',
  //                 'Approved - Pending Submission',
  //                 'Completed - Sent to Versadex',
  //                 'Rejected'
  //               ],
  //               onChanged: (String? newValue) {
  //                 setState(() {
  //                   widget.report['Status'] = newValue!;
  //                 });
  //               },
  //             ),
  //           ],
  //         ),
  //         if (widget.report['Status'] == 'Approved - Pending Submission') ...{
  //           const SizedBox(height: 30),
  //           Center(
  //             child: SizedBox(
  //               width: 400,
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   // Implement push to Versadex functionality
  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor:
  //                       const Color.fromRGBO(0, 61, 121, 1), // Background color
  //                   padding: const EdgeInsets.symmetric(
  //                       vertical: 18.0, horizontal: 10.0),
  //                 ),
  //                 child: const Align(
  //                   alignment: Alignment.center,
  //                   child: Text(
  //                     'PUSH TO VERSADEX',
  //                     style: TextStyle(
  //                       color: Colors.white, // White text
  //                       letterSpacing:
  //                           1.5, // Adjust letter spacing for better readability in all caps
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           )
  //         }
  //       ],
  //     ),
  //   );
  // }

  Widget _buildDetailColumn(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            value,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildReportDetailsColumns(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          value,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildAssigneeDropdown(Map<String, dynamic> report) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            'Assignee',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          DropdownButton<String>(
            value: report['Assignee'],
            items: assigneeItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                report['Assignee'] = newValue!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text(
          'Status',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 14),
        CustomDropdownButton(
          value: widget.report['Status'],
          items: const [
            'Open',
            'In Progress',
            'On Hold',
            'Approved - Pending Submission',
            'Completed - Sent to Versadex',
            'Rejected'
          ],
          onChanged: (String? newValue) {
            setState(() {
              widget.report['Status'] = newValue!;
            });
          },
        ),
      ],
    );
  }
}
