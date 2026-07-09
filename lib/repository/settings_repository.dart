import 'package:isar/isar.dart';
import 'package:botanisht/models/isar_app_settings.dart';

/// Reads/writes the single [AppSettings] row from the shared Isar instance.
class SettingsRepository {
  late final Isar _isar;

  SettingsRepository() {
    _isar = Isar.getInstance('plant')!;
  }

  /// Returns the persisted settings, or sensible defaults when none exist yet.
  Future<AppSettings> getSettings() async {
    final existing = await _isar.appSettings.where().findFirst();
    return existing ?? AppSettings();
  }

  /// Persists settings, reusing the existing row id so we never accumulate
  /// multiple settings documents.
  Future<void> saveSettings(AppSettings settings) async {
    await _isar.writeTxn(() async {
      final existing = await _isar.appSettings.where().findFirst();
      settings.id = existing?.id ?? settings.id;
      await _isar.appSettings.put(settings);
    });
  }
}
