// import 'package:dio/dio.dart';
// import 'package:flutter_auth/strip_payment/strip_keys.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

// abstract class PaymentManager {
//   static Future<void> makePayment(int amount, String currency) async {
//     try {
//       String clientSecret =
//           await _getClientSecret((amount * 100).toString(), currency);
//       await _initailzePaymentSheet(clientSecret);
//       await Stripe.instance.presentPaymentSheet();
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   static Future<void> _initailzePaymentSheet(String clientSecret) async {
//     await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//       paymentIntentClientSecret: clientSecret,
//       merchantDisplayName: 'kareem',
//     ));
//   }

//   static Future<String> _getClientSecret(String amount, String currency) async {
//     Dio dio = Dio();
//     var response = await dio.post("",
//         options: Options(headers: {
//           "Authorization": 'Bearer ${ApiKeys.secretKey}',
//           "Content-Type": 'application/x-www-form-urlencoded'
//         }),
//         data: {"amount": amount, 'currency': currency});

//     return response.data['client_secret'];
//   }
// }
