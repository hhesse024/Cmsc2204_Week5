import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Hesse Week 5'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool pageFirstLoad = true;
  bool isLoadingFromDatabase = false;

  List<Customer> customers = [
    Customer('Gary', 'Anderson', 12, 'Spender'),
    Customer('John', 'Johnson', 1877, 'Occasional'),
    Customer('Lisa', 'Jackson', 654, 'Spender'),
    Customer('Antonio', 'Cappucino', 33, 'Saver'),
    Customer('Caramel', 'Latte', 495, 'Occasional'),
    Customer('Kara', 'Machiatto', 4, 'Frequent'),
    Customer('Sam', 'Smith', 101, 'Frequent'),
    Customer('Depth', 'Charge', 9, 'Saver'),
    Customer('Cereal', 'Milk', 84, 'Frequent'),
    Customer('Suzie', 'Queue', 62, 'Spender'),
  ];

  void _handleButtonPress() {
    setState(() {
      pageFirstLoad = false;
      isLoadingFromDatabase = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoadingFromDatabase = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: pageFirstLoad
            ? ElevatedButton(
                onPressed: _handleButtonPress,
                child: const Text("Load items"),
              )
            : isLoadingFromDatabase
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Text("Please Wait")
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: customers.map((customer) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(customer.firstName,
                                  style: const TextStyle(fontSize: 17)),
                              Text(customer.lastName,
                                  style: const TextStyle(fontSize: 17)),
                              Text(
                                  'Customer ID: ${customer.customerID.toString()}'),
                              Text(customer.type),
                              const Divider(),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
      ),
    );
  }
}

class Customer {
  String firstName;
  String lastName;
  int customerID;
  String type;

  Customer(this.firstName, this.lastName, this.customerID, this.type);
}
