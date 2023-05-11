import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}


//he page payment mn package 3n pub dev bt3tik design jehz 

class _PaymentScreenState extends State<PaymentScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
        children: [
           IconButton(
            onPressed: (){
              Navigator.pop(
                  context,
                  
                );
                     },
             icon: Icon(Icons.arrow_back_ios)),
          CreditCardWidget(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: isCvvFocused,
            obscureCardNumber: true,
            obscureCardCvv: true,
            onCreditCardWidgetChange: (CreditCardBrand) {},
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                CreditCardForm(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  onCreditCardModelChange: (CreditCardBrand) {},
                  themeColor: Colors.blue,
                  formKey: formKey,
                  cardNumberDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Number",
                    hintText: 'xxxx xxxx xxxx xxxx',
                  ),
                  expiryDateDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Expired Date",
                    hintText: 'xx/xx',
                  ),
                  cvvCodeDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "CVV",
                    hintText: 'xxx',
                  ),
                  cardHolderDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Card Holder",
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      print('Valid');
                    } else {
                      print('inValid');
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: Text(
                      'Validate',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'halter',
                        fontSize: 14,
                        package: 'flutter_credit_card',
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    primary: Color(0xff1b44b),
                  ),
                ),
              ],
            ),
          )),
        ],
      )),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
