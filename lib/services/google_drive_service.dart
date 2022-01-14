class GoogleDriveService {
  static final RegExp sharingLinkPattern =
      RegExp('https://drive\\.google\\.com/file/d/([\\w\\n-]+)/.*');

  final String apiKey;

  GoogleDriveService({required this.apiKey});

  String? toDirectLink(String sharingLink) {
    final match = sharingLinkPattern.matchAsPrefix(sharingLink);
    if (match == null) return null;

    final hash = match.group(1);
    return 'https://www.googleapis.com/drive/v3/files/$hash?alt=media&key=$apiKey';
  }
}
