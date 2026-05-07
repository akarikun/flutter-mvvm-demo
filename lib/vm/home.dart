import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeViewModel extends ChangeNotifier {
  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
  }
}
