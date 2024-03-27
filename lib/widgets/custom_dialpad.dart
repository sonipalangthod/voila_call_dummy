import 'package:flutter/material.dart';

class CustomDialpad extends StatelessWidget {
  final Function(String) onDigitPressed;
  final Function() onClearPressed;
  final Function() onCallPressed;
  final List<String> enteredDigits;

  const CustomDialpad({
    Key? key,
    required this.onDigitPressed,
    required this.onClearPressed,
    required this.onCallPressed,
    required this.enteredDigits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      enteredDigits.join(), // Display entered digits inside the tab
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  IconButton(
                    onPressed: onClearPressed,
                    icon: Icon(Icons.backspace_outlined
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('*'),
              _buildButton('0'),
              _buildButton('#'),
            ],
          ),
          SizedBox(height: 16.0),
          Center(
            child: InkWell(
              onTap: onCallPressed,
              child: Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.purple[100], // Light purple color
                ),
                child: Icon(
                  Icons.phone,
                  size: 48.0,
                  color: Colors.purple, // Icon color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label) {
    return InkWell(
      onTap: () => onDigitPressed(label),
      child: Container(
        width: 64.0,
        height: 64.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}