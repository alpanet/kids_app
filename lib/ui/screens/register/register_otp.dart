import 'package:auto_route/auto_route.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kids_app/services/dio_client.dart';
import 'package:kids_app/theme.dart';
import 'package:kids_app/ui/components/button_component.dart';
import 'package:kids_app/ui/components/countdown_component.dart';
import 'package:kids_app/ui/components/otp_component.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class RegisterOtp extends StatefulWidget {
  const RegisterOtp({
    super.key,
    @PathParam('phoneNumber') required this.phoneNumber,
    @PathParam('is_login') required this.is_login,
  });
  final String phoneNumber;
  final bool is_login;

  @override
  // ignore: library_private_types_in_public_api
  _RegisterOtpState createState() => _RegisterOtpState();
}

class _RegisterOtpState extends State<RegisterOtp> {
  bool _isButtonEnabled = false;
  late CountDownController _countdownController;
  String _otpString = "";
  @override
  void initState() {
    super.initState();
    _countdownController = CountDownController();
  }

  void _onTimerComplete() {
    setState(() {
      _isButtonEnabled = true;
    });
  }

  Future<void> _onResendPressed() async {
    setState(() {
      _isButtonEnabled = false;
      _otpString = "";
    });
    try {
      final response = await dioClient.dio.post('/sms-auth/send-code', data: {
        "phoneNumber": widget.phoneNumber,
        "is_login": widget.is_login
      });

      if (response.statusCode == 200) {
        _countdownController.restart(duration: 100);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Bilgileri kontrol edin: ${response.data}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hata oluştu: $e")),
      );
    }
  }

  Future<void> _onProceedPressed() async {
    String otp = _otpString;
    try {
      final response = await dioClient.dio.post('/sms-auth/verify-code', data: {
        "phoneNumber": widget.phoneNumber,
        "verificationCode": otp,
        "is_login": widget.is_login
      });
      if (widget.is_login) {
        if (response.statusCode == 200) {
          final data = response.data;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', data['accessToken']);
          await prefs.setString('refresh_token', data['refreshToken']);
          context.router.replaceNamed('mainpage');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Bilgileri kontrol edin: ${response.data}")),
          );
        }
      } else {
        if (response.statusCode == 200) {
          final data = response.data;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', data['accessToken']);
          await prefs.setString('refresh_token', data['refreshToken']);
          context.router.replaceNamed('mainpage');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Bilgileri kontrol edin: ${response.data}")),
          );
        }
      }
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Giriş başarısız: ${e.response?.data["message"]}")),
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Center(
              child: Text(
                'Hesap Doğrulama',
                style: AppTheme.generalTitle,
                textAlign: TextAlign.center,
              ),
            ),
            CountdownComponent(
              controller: _countdownController,
              onCompleteCallback: _onTimerComplete,
            ),
            OtpInputComponent(
              onOtpChanged: (otp) {
                setState(() {
                  _otpString = otp;
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ButtonComponent(
                color: AppTheme.thirdBackgoundColor,
                text: "Tekrar Gönder",
                enabled: _isButtonEnabled,
                onPressed: _isButtonEnabled ? _onResendPressed : null,
              ),
              const SizedBox(height: 10),
              ButtonComponent(text: "İleri", onPressed: _onProceedPressed),
            ],
          ),
        ),
      ),
    );
  }
}
