import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String shape;
  final bool isAreaChecked;
  final bool isPerimeterChecked;
  final VoidCallback onReset;

  const ResultScreen({
    Key? key,
    required this.shape,
    required this.isAreaChecked,
    required this.isPerimeterChecked,
    required this.onReset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String result = "Your chosen shape: $shape\n";
    if (isAreaChecked) result += "- Need to calculate area\n";
    if (isPerimeterChecked) result += "- Need to calculate perimeter\n";

    return Scaffold(
      appBar: AppBar(title: const Text("Result",
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            fontWeight: FontWeight.bold,)
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(result,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400)
               ),

              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    onReset();
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
