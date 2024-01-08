// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({Key? key}) : super(key: key);

  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  TextEditingController amountController = TextEditingController();
  String converted1Amount = '0.00';
  String converted2Amount = '0.00';
  String selectedSourceCurrency = 'INR';
  String selected1TargetCurrency = 'USD';
  String selected2TargetCurrency = 'GBP';

  Map<String, double> exchangeRates = {
    'INR': 1,
    'USD': 0.012,
    'EUR': 0.011,
    'GBP': 0.0095,
    'JPY': 1.77,
    'CHF': 0.010,
    'CAD': 0.016,
    'AUD': 0.018,
    'SGD': 0.016,
    'HKD': 0.094,
    'CNY': 0.085
  };

  Map<String, String> countryNames = {
    'INR': 'Indian Rupee',
    'USD': 'United States Dollar',
    'EUR': 'Euro',
    'GBP': 'British Pound ',
    'JPY': 'Japanese Yen',
    'CHF': "Swiss Franc",
    'CAD': "Canadian Dollar",
    'AUD': "Australian Dollar",
    'SGD': "Singapore Dollar",
    'HKD': "Hong Kong Dollar ",
    'CNY': "Chinese  Renminbi"
  };

  final List<String> buttons = [
    "AC",
    "Del",
    "=",
    '7',
    '8',
    '9',
    '4',
    '5',
    '6',
    '1',
    '2',
    '3',
    '00',
    '0',
    '.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
              child:
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          value: selectedSourceCurrency,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedSourceCurrency = newValue!;
                              convertCurrency();
                            });
                          },
                          items: exchangeRates.keys.map((String currency) {
                            return DropdownMenuItem<String>(
                              value: currency,
                              child: Text(countryNames[currency]!),
                            );
                          }).toList(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.indigo,
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 30.0,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextFormField(
                              textAlign: TextAlign.end,
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                convertCurrency();
                              },
                              style: const TextStyle(fontSize: 18),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Amount",
                              ),
                            ),
                            Text(
                              selectedSourceCurrency,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      DropdownButton<String>(
                        value: selected1TargetCurrency,
                        onChanged: (String? newValue) {
                          setState(() {
                            selected1TargetCurrency = newValue!;
                            convertCurrency(); // Trigger conversion when target currency changes
                          });
                        },
                        items: exchangeRates.keys.map((String currency) {
                          return DropdownMenuItem<String>(
                            value: currency,
                            child: Text(countryNames[currency]!),
                          );
                        }).toList(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.indigo,
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          size: 30.0,
                          color: Colors.indigo,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            converted1Amount,
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            selected1TargetCurrency,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      DropdownButton<String>(
                        value: selected2TargetCurrency,
                        onChanged: (String? newValue) {
                          setState(() {
                            selected2TargetCurrency = newValue!;
                            convertCurrency(); // Trigger conversion when target currency changes
                          });
                        },
                        items: exchangeRates.keys.map((String currency) {
                          return DropdownMenuItem<String>(
                            value: currency,
                            child: Text(countryNames[currency]!),
                          );
                        }).toList(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.indigo,
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          size: 30.0,
                          color: Colors.indigo,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            converted2Amount,
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            selected2TargetCurrency,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
              child:
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.5,
                crossAxisCount: 3,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CurrencyButton(
                      text: buttons[index],
                      callback: _onButtonPressed,
                    ),
                  );
                },
                childCount: buttons.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        amountController.text = '';
        converted1Amount = '';
        converted2Amount = '';
      } else if (buttonText == 'Del') {
        _delete();
      } else if (buttonText == '=') {
        convertCurrency();
      } else {
        amountController.text += buttonText;
      }
    });
    convertCurrency();
  }

  void _delete() {
    if (amountController.text.isNotEmpty) {
      setState(() {
        amountController.text = amountController.text
            .substring(0, amountController.text.length - 1);
      });
    }
  }

  void convertCurrency() {
    if (amountController.text.isNotEmpty) {
      double amount = double.parse(amountController.text);
      double sourceRate = exchangeRates[selectedSourceCurrency]!;
      double targetRate1 = exchangeRates[selected1TargetCurrency]!;
      double targetRate2 = exchangeRates[selected2TargetCurrency]!;

      setState(() {
        converted1Amount =
            ((amount / sourceRate) * targetRate1).toStringAsFixed(2);

        converted2Amount =
            ((amount / sourceRate) * targetRate2).toStringAsFixed(2);
      });
    }
  }
}

class CurrencyButton extends StatelessWidget {
  final String text;
  final Function callback;

  const CurrencyButton({
    Key? key,
    required this.text,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color buttonColor;
    Color buttontextcolor;
    if (text == 'AC' || text == 'Del' || text == '=') {
      buttonColor = Colors.indigo.shade200;
      buttontextcolor = Colors.white;
    } else {
      buttonColor = Colors.white;
      buttontextcolor = Colors.black;
    }
    return InkWell(
      onTap: () => callback(text),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            width: .5,
            style: BorderStyle.solid,
            color: Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: buttontextcolor,
          ),
        ),
      ),
    );
  }
}
