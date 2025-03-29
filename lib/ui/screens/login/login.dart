import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:kids_app/theme.dart';
import 'package:kids_app/ui/components/button_component.dart';
import 'package:kids_app/services/dio_client.dart';
import 'package:kids_app/ui/screens/register/register_otp.dart';

@RoutePage()
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> _loginProcess() async {
    String phoneNumber = _phoneController.text.trim();

    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Telefon numarası giriniz.")),
      );
      return;
    }

    try {
      final response = await dioClient.dio.post(
        '/sms-auth/send-code',
        data: {"phoneNumber": phoneNumber, "is_login":true},
      );

      if (response.statusCode == 200) {
        context.router
            .pushNamed('registerOtp/${_phoneController.text}?is_login=true');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Giriş başarısız: ${response.data}")),
        );
      }
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Giriş başarısız: ${e.response?.data["message"]}")),
        );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hata oluştu: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackgoundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 90),
            Text(
              'Kids App\'e Hoş Geldin',
              style: AppTheme.generalTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Lütfen sisteme kayıt olduğunuz telefon numarasını girin',
              style: AppTheme.onboardingSubTitle.copyWith(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            IntlPhoneField(
              focusNode: focusNode,
              decoration: const InputDecoration(
                labelText: 'Telefon Numarası',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              languageCode: "tr",
              initialCountryCode: "TR",
              onChanged: (phone) {
                _phoneController.text = phone.completeNumber;
              },
              onCountryChanged: (country) {
                print('Country changed to: ' + country.name);
              },
              invalidNumberMessage: "Eksik bilgi girişi",
            ),
            const SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                style: AppTheme.onboardingSubTitle.copyWith(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 14,
                ),
                children: [
                  const TextSpan(
                    text: 'Bilgiler ile devam ederseniz ',
                  ),
                  TextSpan(
                    text: 'Kullanıcı sözleşmesini',
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('Kullanıcı sözleşmesini clicked');
                      },
                  ),
                  const TextSpan(
                    text: ' kabul etmiş sayılırsınız.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ButtonComponent(
                text: "Giriş Yap",
                onPressed: _loginProcess,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ButtonComponent(
                text: "Kayıt Ol",
                color: AppTheme.fourthBackgoundColor,
                onPressed: () {
                  context.router.replaceNamed('onboarding');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
