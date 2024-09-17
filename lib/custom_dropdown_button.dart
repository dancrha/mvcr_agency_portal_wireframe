import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  CustomDropdownButton({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton>
    with SingleTickerProviderStateMixin {
  late OverlayEntry _overlayEntry;
  late GlobalKey _key;
  bool _isDropdownOpen = false;
  String _currentValue = '';
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _key = LabeledGlobalKey("dropdownButton");
    _currentValue = widget.value;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 360),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: 280,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[300]!), // Light grey border
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.items.map((String value) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentValue = value;
                      _controller.forward(from: 0.0);
                    });
                    widget.onChanged(value);
                    _closeDropdown();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: getStatusColor(value),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            getStatusIcon(value),
                            size: 20,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            value,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)!.insert(_overlayEntry);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _closeDropdown() {
    _overlayEntry.remove();
    setState(() {
      _isDropdownOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTap: _toggleDropdown,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _controller.isAnimating ? _scaleAnimation.value : 1.0,
            child: Opacity(
              opacity: _controller.isAnimating ? _fadeAnimation.value : 1.0,
              child: child,
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: getStatusColor(_currentValue),
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
                getStatusIcon(_currentValue),
                size: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                _currentValue,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
