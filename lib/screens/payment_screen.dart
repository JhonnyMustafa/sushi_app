import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app_jhonny_mustafa/providers/cart.dart';
import 'package:sushi_app_jhonny_mustafa/screens/home_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // controller to retrieve the text
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    testcopy() {
      final value = ClipboardData(text: controller.text);
      Clipboard.setData(value);
    }

    double price = 0;
    double totalPrice = 0;
    double taxAndService = 0;
    double totalPayment = 0;

    return Consumer<Cart>(
      builder: (context, value, child) {
        for (var cartModel in value.cart) {
          price = int.parse(cartModel.quantity.toString()) *
              int.parse(cartModel.price.toString()).toDouble();

          totalPrice += double.parse(price.toString());
          taxAndService = (totalPrice * 0.11).toDouble();
          totalPayment = totalPrice + taxAndService.toDouble();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Payment'),
          ),
          body: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: value.cart.length,
                itemBuilder: (context, index) {
                  final food = value.cart[index];
                  return ListTile(
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset(
                        food.imagePath.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(food.name.toString()),
                    subtitle: Text('${food.quantity} x  ${food.price} IDR'),
                  );
                },
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'BCA-123456',
                  enabled: false,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  testcopy;
                },
                icon: const Icon(Icons.copy),
                label: const Text('Copy'),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(8),
            width: MediaQuery.sizeOf(context).width,
            // height: 200,
            // color: Colors.blue,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Price',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'IDR $totalPayment',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                //Tombol Konfirmasi
                CupertinoButton(
                  color: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(20),
                  borderRadius: BorderRadius.circular(30),
                  onPressed: () {
                    //addToCart();
                    for (var cartModel in value.cart) {
                      value.removeFoodCart(cartModel);
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
