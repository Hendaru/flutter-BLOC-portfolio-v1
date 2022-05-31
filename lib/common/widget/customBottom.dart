import 'package:flutter/material.dart';

class CustomBottom extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isActive;
  final bool isLoading;

  CustomBottom({
    required this.title,
    required this.onTap,
    required this.isActive,
    this.isLoading = false,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      // elevation: 10,
      color: Colors.white,
      child: Ink(
        height: 50,
        color: Colors.blue,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: onTap,
                  child: Ink(
                      height: 41,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                ),
        ),
      ),
    );
  }
}
