import 'dart:developer' as developer;
import 'dart:io' show Platform;
import 'memory_tests.dart';

class MemoryProtection {
 static bool checkDevToolsConnection() {
   try {
     return Platform.environment.containsKey('FLUTTER_TOOLS_VM_SERVICE_PORT');
   } catch (e) {
     return false;
   }
 }

 static void secureDispose(dynamic object) {
   if (object is SecureBook) {
     object.dispose();
   }
   object = null;
 }

 static bool checkMemoryExposure() {
   try {
     if (checkDevToolsConnection()) {
       print('Warning: DevTools connected, potential memory exposure');
        print('FLUTTER_TOOLS_VM_SERVICE_PORT: ${Platform.environment['FLUTTER_TOOLS_VM_SERVICE_PORT']}');

     }else{
       print("DevTools not connected");
     }
     return false;
   } catch (e) {
     return true;
   }
 }
}