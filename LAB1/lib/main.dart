import 'package:flutter/material.dart';

// Написати програму під платформу Андроїд, яка має інтерфейс для введення
// або/та вибору даних згідно варіанту (таблиця) і відображає результат
// взаємодії з цим
// інтерфейсом у деяке текстове поле цього інтерфейсу. Передбачити наступне:
// якщо не всі дані введені або обрані, а користувач натискає кнопку для
// отримання результату,
// то відобразити вікно, що спливає, з повідомленням завершити введення
// всіх даних.

// Вікно містить групу прапорів (площа і периметр), тобто чек-бокси, групу
// опцій (різні фігури), тобто радіо-батони, та кнопку «ОК». Вивести
// інформацію щодо вибору при натисканні на кнопку «ОК» у деяке текстове
// поле.


void main() {
  runApp(const MaterialApp(
    home: ShapeCalculator(),
  ));
}

class ShapeCalculator extends StatefulWidget {

  const ShapeCalculator({Key? key}) : super(key: key);

  @override
  _ShapeCalculatorState createState() => _ShapeCalculatorState();
}

class _ShapeCalculatorState extends State<ShapeCalculator> {
  String? selectedShape;
  bool isAreaChecked = false;
  bool isPerimeterChecked = false;
  String result = "";
  String selectedFont = 'Montserrat';

  void calculate() {
    if (selectedShape == null || (!isAreaChecked && !isPerimeterChecked)) {
      _showAlert();
      return;
    }

    String output = "Your chosen shape: $selectedShape\n";
    if (isAreaChecked) output += "- Need to calculate area\n";
    if (isPerimeterChecked) output += "- Need to calculate perimeter\n";

    setState(() {
      result = output;
    });
  }

  void _showAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error",
            style: TextStyle(
              fontFamily: selectedFont,
              fontSize: 20,
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,)),
        content: Text("Choose shape and at least one parameter to continue.",
            style: TextStyle(
              fontFamily: selectedFont,
              fontSize: 16,
              fontWeight: FontWeight.w400,)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK",
                style: TextStyle(
                  fontFamily: selectedFont,
                  fontSize: 16,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,)
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE48AFF), Color(0xFF97E9FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius:
              BorderRadius.vertical(bottom: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFC5C5C5),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            title: Row(
              children: [
                const Icon(Icons.calculate, color: Colors.white),
                const SizedBox(width: 10),
                Text("Objects calculator",
                    style: TextStyle(
                      fontFamily: selectedFont,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,)
                ),
              ],
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Choose parameters:",
                style: TextStyle(
                    fontFamily: selectedFont,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)
            ),

            CheckboxListTile(
              title: Text("Area",
                  style: TextStyle(
                      fontFamily: selectedFont,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)
              ),
              value: isAreaChecked,
              onChanged: (value) {
                setState(() {
                  isAreaChecked = value!;
                });
              },
            ),

            CheckboxListTile(
              title: Text("Perimeter",
                  style: TextStyle(
                      fontFamily: selectedFont,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
              value: isPerimeterChecked,
              onChanged: (value) {
                setState(() {
                  isPerimeterChecked = value!;
                });
              },
            ),

            const SizedBox(height: 24),

            Text("Choose shape:",
                style: TextStyle(
                    fontFamily: selectedFont,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)
            ),

            Column(
              children: ["Circle", "Square", "Triangle", "Rectangle"].map((shape) {
                return RadioListTile(
                  title: Text(shape,
                      style: TextStyle(
                          fontFamily: selectedFont,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)
                  ),
                  value: shape,
                  groupValue: selectedShape,
                  onChanged: (value) {
                    setState(() {
                      selectedShape = value as String?;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            Center(
              child: ElevatedButton(
                onPressed: calculate,
                child: Text("OK",
                    style: TextStyle(
                        fontFamily: selectedFont,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
              ),
            ),

            const SizedBox(height: 24),

            Text(result,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400)
            ),
          ],
        ),
      ),
    );
  }
}
