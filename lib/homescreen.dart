import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';


class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  
  State<Homescreen> createState() => _HomescreenState();
}
 bool isBiometricsAvailable = false;
 
 
class _HomescreenState extends State<Homescreen> {
 Future<bool> checkBiometrics() async {
  final localAuth = LocalAuthentication();
  bool canCheckBiometrics = await localAuth.canCheckBiometrics;
  return canCheckBiometrics;
}
Future<bool> authenticateWithBiometrics() async {
  final localAuth = LocalAuthentication();
  bool authenticated = false;

  try {
    authenticated = await localAuth.authenticate(
      localizedReason: 'Authenticate to unlock',
      
      
    );
  } catch (e) {
    print(e);
  }

  return authenticated;
} @override
  void initState() {
    super.initState();
    checkBiometrics().then((value) {
      setState(() {
        isBiometricsAvailable = value;
      });
    });
  }

  void _authenticate() async {
    bool authenticated = await authenticateWithBiometrics();
    if (authenticated) {
      // User successfully authenticated with biometrics
      // Navigate to the main content of your app or perform the desired action.
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fingerprint Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (isBiometricsAvailable)
              ElevatedButton(
                onPressed: () {
                  
                },
                child: Text('Unlock with Fingerprint'),
              ),
            if (!isBiometricsAvailable)
              Text('Biometric authentication is not available on this device.'),
          ],
        ),
      ),
    );

    
  }
}