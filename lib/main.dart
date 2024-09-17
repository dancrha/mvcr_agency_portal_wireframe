import 'package:flutter/material.dart';
import 'package:mvcr_agency_portal_wireframe/custom_dropdown_button.dart';
import 'package:mvcr_agency_portal_wireframe/report_details.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MVCR Online Form',
      home: DashboardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int? _hoveredRowIndex;
  final double _scaleFactor = 1.03; // Scale factor for hover effect
  int? _changingStatusRowIndex;
  List<String> dropdownItems = [
    'Open',
    'In Progress',
    'On Hold',
    'Approved - Pending Submission',
    'Completed - Sent to Versadex',
    'Rejected'
  ];

  List<String> assignees = [
    'Open',
    'In Progress',
    'On Hold',
    'Approved - Pending Submission',
    'Completed - Sent to Versadex',
    'Rejected'
  ];

  List<Map<String, dynamic>> reports = [
    {
      'Occurrence Number': 2,
      'Assignee': 'Stacy',
      'Submission Date': '2024/07/10',
      'Status': 'Open',
      'Follow up Date': '2024/07/10',
    },
    {
      'Occurrence Number': 2,
      'Assignee': 'John',
      'Submission Date': '2024/07/10',
      'Follow up Date': '2024/07/10',
      'Status': 'In Progress',
    },
    {
      'Occurrence Number': 3,
      'Assignee': 'Tom',
      'Submission Date': '2024/07/10',
      'Follow up Date': '2024/07/10',
      'Status': 'On Hold',
    },
    {
      'Occurrence Number': 3,
      'Assignee': 'Tom',
      'Submission Date': '2024/07/10',
      'Follow up Date': '2024/07/10',
      'Status': 'Approved - Pending Submission',
    },
    {
      'Occurrence Number': 3,
      'Assignee': 'Tom',
      'Submission Date': '2024/07/10',
      'Follow up Date': '2024/07/10',
      'Status': 'Completed - Sent to Versadex',
    },
    {
      'Occurrence Number': 3,
      'Assignee': 'Tom',
      'Submission Date': '2024/07/10',
      'Follow up Date': '2024/07/10',
      'Status': 'Rejected',
    },
    {
      'Occurrence Number': 3,
      'Assignee': 'Tom',
      'Submission Date': '2024/07/10',
      'Follow up Date': '2024/07/10',
      'Status': 'Completed - Sent to Versadex',
    },
    {
      'Occurrence Number': 3,
      'Assignee': 'Tom',
      'Submission Date': '2024/07/10',
      'Follow up Date': '2024/07/10',
      'Status': 'Completed - Sent to Versadex',
    },
    {
      'Occurrence Number': 3,
      'Assignee': 'Tom',
      'Submission Date': '2024/07/10',
      'Follow up Date': '2024/07/10',
      'Status': 'Completed - Sent to Versadex',
    },
    {
      'Occurrence Number': 3,
      'Assignee': 'Tom',
      'Submission Date': '2024/07/10',
      'Follow up Date': '2024/07/10',
      'Status': 'Completed - Sent to Versadex',
    },
    {
      'Occurrence Number': 3,
      'Assignee': 'Tom',
      'Submission Date': '2024/07/10',
      'Follow up Date': '2024/07/10',
      'Status': 'Completed - Sent to Versadex',
    },
    {
      'Occurrence Number': 3,
      'Assignee': 'Tom',
      'Submission Date': '2024/07/10',
      'Follow up Date': '2024/07/10',
      'Status': 'Completed - Sent to Versadex',
    },
    {
      'Occurrence Number': 3,
      'Assignee': 'Tom',
      'Submission Date': '2024/07/10',
      'Follow up Date': '2024/07/10',
      'Status': 'Completed - Sent to Versadex',
    },
    // Add more reports as needed
  ];

  IconData getStatusIcon(String status) {
    switch (status) {
      case 'Completed - Sent to Versadex':
        return Icons.check_circle;
      case 'Open':
        return Icons.radio_button_unchecked;
      case 'Approved - Pending Submission':
        return Icons.task_alt;
      case 'On Hold':
        return Icons.pause_circle_outline;
      case 'Rejected':
        return Icons.cancel;
      default:
        return Icons.radio_button_checked;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Open':
        return Colors.grey;
      case 'In Progress':
        return Colors.yellow.shade700;
      case 'Approved - Pending Submission':
        return Colors.blue.shade700;
      case 'Completed - Sent to Versadex':
        return Colors.green;
      case 'On Hold':
        return Colors.yellow.shade900;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
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
            containerWidth =
                constraints.maxWidth; // Snap to screen width if less than 600
          }
          return Center(
            child: Container(
              width: containerWidth,
              padding: EdgeInsets.symmetric(
                vertical: 40.0,
                horizontal: isMobile
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
                    'Motor Vehicle Collision Report Submissions',
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'ArchivoNarrow',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Search by:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        spacing: 10.0, // Horizontal spacing between items
                        runSpacing: 20.0, // Vertical spacing between rows
                        children: [
                          SizedBox(
                            width: 200,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 14.0),
                              cursorColor: const Color.fromRGBO(0, 61, 121,
                                  1), // Set cursor color to dark blue
                              decoration: const InputDecoration(
                                labelText: 'Occurrence Number',
                                fillColor: Colors.white,
                                floatingLabelStyle: TextStyle(
                                  color: Color.fromRGBO(0, 61, 121, 1),
                                ),
                                hintText: 'e.g. 2024-123456',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(0, 61, 121, 1),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 14.0),
                              cursorColor: const Color.fromRGBO(0, 61, 121,
                                  1), // Set cursor color to dark blue
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                floatingLabelStyle: TextStyle(
                                  color: Color.fromRGBO(0, 61, 121, 1),
                                ),
                                hintText: 'e.g. John Doe',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(0, 61, 121, 1),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 14.0),
                              cursorColor: const Color.fromRGBO(0, 61, 121,
                                  1), // Set cursor color to dark blue
                              decoration: const InputDecoration(
                                labelText: 'Licence Plate',
                                floatingLabelStyle: TextStyle(
                                  color: Color.fromRGBO(0, 61, 121, 1),
                                ),
                                hintText: 'e.g. ABC-1234',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(0, 61, 121, 1),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.filter_list,
                                color: Colors.white),
                            label: const Text(
                              'Filter',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 18),
                              backgroundColor:
                                  const Color.fromRGBO(0, 61, 121, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.sort, color: Colors.white),
                            label: const Text(
                              'Sort',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 18),
                              backgroundColor:
                                  const Color.fromRGBO(0, 61, 121, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
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
                            // Header row
                            _buildTableRow(
                              -1, // No hover effect for header
                              [
                                _buildHeaderCell('Occurrence #'),
                                _buildHeaderCell('Assignee'),
                                _buildHeaderCell('Submission Date'),
                                _buildHeaderCell('Follow up Date'),
                                _buildHeaderCell('Status'),
                              ],
                              isHeader: true,
                            ),
                            ...reports.asMap().entries.map((entry) {
                              int idx = entry.key;
                              Map report = entry.value;
                              return _buildTableRow(
                                idx,
                                [
                                  Text(report['Occurrence Number'].toString()),
                                  Text(report['Assignee']),
                                  Text(report['Submission Date']),
                                  Text(report['Follow up Date']),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8), // Increased padding
                                    decoration: BoxDecoration(
                                      color: getStatusColor(report['Status']),
                                      borderRadius: BorderRadius.circular(30.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          getStatusIcon(report['Status']),
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                            width:
                                                8), // Increased spacing between icon and text\
                                        if (!isMobile)
                                          Text(
                                            report['Status'],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTableRow(int idx, List<Widget> cells, {bool isHeader = false}) {
    return MouseRegion(
      onEnter: isHeader
          ? null
          : (_) {
              setState(() {
                _hoveredRowIndex = idx;
              });
            },
      onExit: isHeader
          ? null
          : (_) {
              setState(() {
                _hoveredRowIndex = null;
              });
            },
      child: GestureDetector(
        onTap: isHeader
            ? null
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReportDetails(
                      report: reports[idx],
                    ),
                  ),
                );
              },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()
            ..scale(_hoveredRowIndex == idx ? _scaleFactor : 1.0),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            color: isHeader
                ? Colors.transparent
                : _hoveredRowIndex == idx
                    ? Color.fromARGB(255, 199, 230, 255)
                    : (idx % 2 == 0 ? Colors.grey[200] : Colors.white),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: cells.asMap().entries.map((entry) {
              int cellIndex = entry.key;
              Widget cell = entry.value;

              if (cellIndex == cells.length - 1 && !isHeader) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomDropdownButton(
                        value: reports[idx]['Status'],
                        items: dropdownItems,
                        onChanged: (String? newValue) {
                          setState(() {
                            _changingStatusRowIndex = idx;
                            reports[idx]['Status'] = newValue!;
                          });
                          Future.delayed(const Duration(milliseconds: 5000),
                              () {
                            setState(() {
                              _changingStatusRowIndex = null;
                            });
                          });
                        },
                      ),
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: cell,
                  ),
                );
              }
            }).toList(),
          ),
        ),
      ),
    );
  }
}
