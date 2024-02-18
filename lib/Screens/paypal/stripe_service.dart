// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:stripe_checkout/stripe_checkout.dart';

// class StripeService {
//   String secretKey =
//       "sk_test_51OY4RTCNJbSmAIkSXW1SqauFdOmC6WppQ8HBEfszyPwuFoMyLtTxyXPRH0NaMEA0cMC4RBG9Ltx3m961ImteTiEf006evVRRSq";
//   String PublishableKey =
//       "pk_test_51OY4RTCNJbSmAIkSROvJQuUZsbW9LQOu6UsI1ddmp49IKNNf59FpuJyN47lWSA1jHO5NfBpUexOUCzGrTr94jheb00yluh0od5";
//  Future<dynamic> createCheckOutSession(
//   List<dynamic> productItems,
//   totalAmount,
// ) async {
//   try {
//     final url = Uri.parse("https://api.stripe.com/v1/checkout/sessions");
//     String lineItems = "";
//     int index = 0;

//     productItems.forEach((val) {
//       var productPrice = (val["productPrice"] * 100).round().toString();
//       lineItems +=
//           "&line_items[$index][price_data][product_data][name]=${val['productName']}";
//       lineItems +=
//           "&line_items[$index][price_data][unit_amount] =${productPrice}";
//       lineItems += "&line_items[$index][price_data][currency]=USD";
//       lineItems +=
//           "&line_items[$index][quantity]=${val['qty'].toString()}";
//       index++;
//     });

//     final response = await http.post(
//       url,
//       body:
//           'success_url=http://checkout.stripe.dev/success&mode=payment$lineItems',
//       headers: {
//         'Authorization': 'Bearer $secretKey',
//         'Content-Type': "application/x-www-form-urlencoded"
//       },
//     );

//     final decodedResponse = json.decode(response.body);

//     // Check if the response contains the 'id' key
//     if (decodedResponse != null && decodedResponse["id"] != null) {
//       return decodedResponse["id"];
//     } else {
//       throw Exception(
//           "Failed to create checkout session. Response: $decodedResponse");
//     }
//   } catch (e) {
//     print("Error in createCheckOutSession: $e");
//     throw Exception("Failed to create checkout session. Error: $e");
//   }
// }

//   Future<dynamic> stripePaymentCheckout(
//     productItems,
//     subTotal,
//     context,
//     mounted, {
//     onSuccess,
//     onCancel,
//     onError,
//   }) async {
//     final String sessionId = await createCheckOutSession(
//       productItems,
//       subTotal,
//     );
//     final result = await redirectToCheckout(
//       context: context,
//       sessionId: sessionId,
//       publishableKey: PublishableKey,
//       successUrl: "https://checkout.stripe.dev/success",
//       canceledUrl: "https://checkout.stripe.dev/cancel",
//     );
//     if (mounted) {
//       final text = result.when(
//         redirected: () => 'Redirected Successfully',
//         success: () => onSuccess,
//         canceled: () => onCancel,
//         error: (e) => onError,
//       );
//       return text;
//     }
//   }
// }
