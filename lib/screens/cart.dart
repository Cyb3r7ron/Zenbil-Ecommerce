import 'package:zenbil_two/consts/colors.dart';
import 'package:zenbil_two/consts/my_icons.dart';
import 'package:zenbil_two/provider/cart_provider.dart';
import 'package:zenbil_two/services/global_method.dart';
//import 'package:zenbil_two/services/payment.dart';
import 'package:zenbil_two/widget/cart_empty.dart';
import 'package:zenbil_two/widget/cart_full.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  //To be known 1) the amount must be an integer 2) the amount must not be double 3) the minimum amount should be less than 0.5 $
  static const routeName = '/CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //StripeService.init();
  }

  /*void payWithCard({int amount}) async {
    ProgressDialog dialog = ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var response = await StripeService.payWithNewCard(
        currency: 'USD', amount: amount.toString());
    await dialog.hide();
    print('response : ${response.message}');
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration: Duration(milliseconds: response.success == true ? 1200 : 3000),
    ));
  }*/
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCartItems.isEmpty
        ? Scaffold(body: CartEmpty())
        : Scaffold(
            bottomSheet: checkoutSection(context, cartProvider.totalAmount),
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text('Cart (${cartProvider.getCartItems.length})'),
              actions: [
                IconButton(
                  onPressed: () {
                    globalMethods.showDialogg(
                        'Clear cart!',
                        'Your cart will be cleared!',
                        () => cartProvider.clearCart(),
                        context);
                    // cartProvider.clearCart();
                  },
                  icon: Icon(MyAppIcons.trash),
                )
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                  itemCount: cartProvider.getCartItems.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return ChangeNotifierProvider.value(
                      value: cartProvider.getCartItems.values.toList()[index],
                      child: CartFull(
                        productId:
                            cartProvider.getCartItems.keys.toList()[index],
                        // id:  cartProvider.getCartItems.values.toList()[index].id,
                        // productId: cartProvider.getCartItems.keys.toList()[index],
                        // price: cartProvider.getCartItems.values.toList()[index].price,
                        // title: cartProvider.getCartItems.values.toList()[index].title,
                        // imageUrl: cartProvider.getCartItems.values.toList()[index].imageUrl,
                        // quatity: cartProvider.getCartItems.values.toList()[index].quantity,
                      ),
                    );
                  }),
            ),
          );
  }

  Widget checkoutSection(BuildContext ctx, double subtotal) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            /// mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(colors: [
                      ColorsConsts.gradiendLStart,
                      ColorsConsts.gradiendLEnd,
                    ], stops: [
                      0.0,
                      0.7
                    ]),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      /*onTap: () {
                        double amountInCents = subtotal * 1000;
                        int intengerAmount = (amountInCents / 10).ceil();
                        payWithCard(amount: intengerAmount);
                      },*/
                      splashColor: Theme.of(ctx).splashColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Checkout',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(ctx).textSelectionColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Text(
                'Total:',
                style: TextStyle(
                    color: Theme.of(ctx).textSelectionColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'US ${subtotal.toStringAsFixed(3)}',
                //textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }
}
