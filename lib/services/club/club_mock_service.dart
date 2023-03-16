import 'package:app_cargo/domain/referrals/referrals.dart';

import 'club_service.dart';

class ClubMockService implements ClubService {
  @override
  Future<void> sendReferences(Referrals referrals) {
    return Future.delayed(Duration(seconds: 1));
  }
}
