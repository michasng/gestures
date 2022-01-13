class GoogleDriveService {
  static final RegExp sharingLinkPattern =
      RegExp('https://drive\\.google\\.com/file/d/([\\w\\n]+)/.*');

  final String apiKey;

  GoogleDriveService({required this.apiKey});

  String? toDirectLink(String sharingLink) {
    // AIzaSyBVjAU58Izq4tLrpUCxbqyyt2iOFroJc88
    // https://drive.google.com/file/d/1aQZT7PNf_GI3XdeAK7rBFaU_KFRH46mF/view?usp=sharing;
    // https://www.googleapis.com/drive/v3/files/1aQZT7PNf_GI3XdeAK7rBFaU_KFRH46mF?alt=media&key=AIzaSyBVjAU58Izq4tLrpUCxbqyyt2iOFroJc88

    final match = sharingLinkPattern.matchAsPrefix(sharingLink);
    if (match == null) return null;

    final hash = match.group(1);
    return 'https://www.googleapis.com/drive/v3/files/$hash?alt=media&key=$apiKey';
  }
}
