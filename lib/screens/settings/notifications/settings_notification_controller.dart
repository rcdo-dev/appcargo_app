part of 'settings_notifications.dart';

class SettingsNotificationController {
  bool notifyNearbyRequests;
  bool notifyCompanyContact;
  bool notifyCargoClubOffers;
  bool notifyNewRequests;

  SettingsNotificationController(
      NotificationConfiguration notificationConfiguration) {
    this.notifyNearbyRequests = notificationConfiguration.notifyNearbyRequests;
    this.notifyCompanyContact = notificationConfiguration.notifyCompanyContact;
    this.notifyCargoClubOffers =
        notificationConfiguration.notifyCargoClubOffers;
    this.notifyNewRequests = notificationConfiguration.notifyNewRequests;
  }

  NotificationConfiguration getNotificationConfiguration() {
    return new NotificationConfiguration(
      notifyCargoClubOffers: notifyCargoClubOffers,
      notifyCompanyContact: notifyCompanyContact,
      notifyNearbyRequests: notifyNearbyRequests,
      notifyNewRequests: notifyNewRequests,
    );
  }
}
