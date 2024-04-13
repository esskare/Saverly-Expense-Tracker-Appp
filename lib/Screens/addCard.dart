import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:velocity_x/velocity_x.dart';


void main() => runApp(const addCard());


class addCard extends StatefulWidget {
 const addCard({Key? key}) : super(key: key);


 @override
 State<addCard> createState() => _addCardState();
}


class _addCardState extends State<addCard> {
 final CreditCardValidator _ccValidator = CreditCardValidator();
 bool isLightTheme = false;
 String cardNumber = '';
 String expiryDate = '';
 String cardHolderName = '';
 String cvvCode = '';
 bool isCvvFocused = false;
 bool useGlassMorphism = false;
 bool useBackgroundImage = false;
 bool useFloatingAnimation = true;
 final navigatorKey = GlobalKey<NavigatorState>();
 final OutlineInputBorder border = OutlineInputBorder(
   borderSide: BorderSide(
     color: Colors.grey.withOpacity(0.7),
     width: 2.0,
   ),
 );






 void validateCreditCard(String ccNum, String expDate, String cvv) {
   final ccNumResults = _ccValidator.validateCCNum(ccNum);
   print('Card Number: ${ccNumResults.isPotentiallyValid} is potentially valid');






   final expDateResults = _ccValidator.validateExpDate(expDate);
   print('Expiry Date: ${expDateResults.isValid} is valid');


   final cvvResults = _ccValidator.validateCVV(cvv, ccNumResults.ccType);
   print('CVV: ${cvvResults.isValid} is valid');


   final isValid = (ccNumResults.isValid || ccNumResults.isPotentiallyValid) &&
       expDateResults.isValid &&
       cvvResults.isValid;


   if (isValid) {
     // Credit card is valid
     showToast('Credit card is valid', isValid);
   } else {
     // Credit card is invalid
     showToast('Credit card is invalid', isValid);
   }
 }


 void showToast(String message, bool isValid) {
   final context = navigatorKey.currentContext!;
   final scaffold = ScaffoldMessenger.of(context);
   scaffold.showSnackBar(
     SnackBar(
       content: Text(message),
       duration: const Duration(seconds: 2),
       backgroundColor: isValid ? Colors.green : Colors.red,
     ),
   );
 }


 final GlobalKey<FormState> formKey = GlobalKey<FormState>();






 @override
 Widget build(BuildContext context) {
   SystemChrome.setSystemUIOverlayStyle(
     isLightTheme ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
   );
   return MaterialApp(
     navigatorKey: navigatorKey,
     title: 'Flutter Credit Card View Demo',
     debugShowCheckedModeBanner: false,
     themeMode: isLightTheme ? ThemeMode.light : ThemeMode.dark,
     theme: ThemeData(
       textTheme: const TextTheme(
         // Text style for text fields' input.
         headline6: TextStyle(color: Colors.black, fontSize: 18),
       ),
       colorScheme: ColorScheme.fromSwatch().copyWith(
         secondary: Colors.black,
       ),
       inputDecorationTheme: InputDecorationTheme(
         hintStyle: const TextStyle(color: Colors.black),
         labelStyle: const TextStyle(color: Colors.black),
         focusedBorder: border,
         enabledBorder: border,
       ),
     ),
     darkTheme: ThemeData(
       textTheme: const TextTheme(
         // Text style for text fields' input.
         headline6: TextStyle(color: Colors.white, fontSize: 18),
       ),
       colorScheme: ColorScheme.fromSwatch().copyWith(
         secondary: Colors.white,
       ),
       inputDecorationTheme: InputDecorationTheme(
         hintStyle: const TextStyle(color: Colors.white),
         labelStyle: const TextStyle(color: Colors.white),
         focusedBorder: border,
         enabledBorder: border,
       ),
     ),
     home: Scaffold(
       backgroundColor: Colors.black26,
       resizeToAvoidBottomInset: false,
       body: Builder(
         builder: (BuildContext context) {
           return Container(
             decoration: const BoxDecoration(
               image: DecorationImage(
                 image: ExactAssetImage(
                   'assets/bg-dark.png',
                 ),
                 fit: BoxFit.fill,
               ),
             ),
             child: Center(
               child: SafeArea(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.end,
                   children: <Widget>[
                     CreditCardWidget(
                       enableFloatingCard: useFloatingAnimation,
                       cardNumber: cardNumber,
                       expiryDate: expiryDate,
                       cardHolderName: cardHolderName,
                       cvvCode: cvvCode,
                       bankName: 'Axis Bank',
                       frontCardBorder: useGlassMorphism
                           ? null
                           : Border.all(color: Colors.grey),
                       backCardBorder: useGlassMorphism
                           ? null
                           : Border.all(color: Colors.grey),
                       showBackView: isCvvFocused,
                       obscureCardNumber: true,
                       obscureCardCvv: true,
                       isHolderNameVisible: true,
                       cardBgColor: isLightTheme ? Colors.white : Colors.black,
                       backgroundImage:
                       useBackgroundImage ? 'assets/card_bg.png' : null,
                       isSwipeGestureEnabled: true,
                       onCreditCardWidgetChange:
                           (CreditCardBrand creditCardBrand) {},
                       customCardTypeIcons: <CustomCardTypeIcon>[
                         CustomCardTypeIcon(
                           cardType: CardType.mastercard,
                           cardImage: Image.asset(
                             'assets/mastercard.png',
                             height: 48,
                             width: 48,
                           ),
                         ),
                       ],
                     ),
                     Expanded(
                       child: SingleChildScrollView(
                         child: Column(
                           children: <Widget>[
                             CreditCardForm(
                               formKey: formKey,
                               obscureCvv: true,
                               obscureNumber: true,
                               cardNumber: cardNumber,
                               cvvCode: cvvCode,
                               isHolderNameVisible: true,
                               isCardNumberVisible: true,
                               isExpiryDateVisible: true,
                               cardHolderName: cardHolderName,
                               expiryDate: expiryDate,
                               inputConfiguration: const InputConfiguration(
                                 cardNumberDecoration: InputDecoration(
                                   hintStyle: TextStyle(color: Colors.white),
                                   labelStyle: TextStyle(color: Colors.white),
                                   labelText: 'Number',
                                   hintText: 'XXXX XXXX XXXX XXXX',
                                 ),
                                 expiryDateDecoration: InputDecoration(
                                   hintStyle: TextStyle(color: Colors.white),
                                   labelStyle: TextStyle(color: Colors.white),
                                   labelText: 'Expired Date',
                                   hintText: 'XX/XX',
                                 ),
                                 cvvCodeDecoration: InputDecoration(
                                   hintStyle: TextStyle(color: Colors.white),
                                   labelStyle: TextStyle(color: Colors.white),
                                   labelText: 'CVV',
                                   hintText: 'XXX',
                                 ),
                                 cardHolderDecoration: InputDecoration(
                                   hintStyle: TextStyle(color: Colors.white),
                                   labelStyle: TextStyle(color: Colors.white),
                                   labelText: 'Card Holder',
                                 ),
                               ),
                               onCreditCardModelChange: onCreditCardModelChange,


                             ),
                             const SizedBox(height: 20),
                             ElevatedButton(
                               onPressed: _onValidate,
                               style: ElevatedButton.styleFrom(
                                 foregroundColor: Colors.white, backgroundColor: Colors.green, // Text color
                                 padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50), // Button padding
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(8), // Button border radius
                                 ),
                               ),
                               child: Text(
                                 'Validate',
                                 style: TextStyle(
                                   color: Colors.black, // Text color
                                   fontFamily: 'halter',
                                   fontSize: 14,
                                 ),
                               ),
                             )
                           ],
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             ),
           );
         },
       ),
     ),
   );
 }
 void _onValidate() {
   if (formKey.currentState?.validate() ?? false) {
     print("HEREEE");
     print(cardNumber.text);
     final ccNum = cardNumber.text;
     final exDate = expiryDate.text;
     final cvv = cvvCode.text;


     print('CC Num: $ccNum');
     print('CVV: $cvv');


     validateCreditCard(cardNumber, expiryDate, cvvCode);
   } else {
     print('Form is invalid!');
   }
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

