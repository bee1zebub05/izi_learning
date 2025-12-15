class AppMimeGroups {

  // PDF
  static const pdf = {'application/pdf'};
  //Folder PDF
  static const folderPdf = {'folder/pdfs'};

  // WORD (doc/docx + macro + template + rtf)
  static const word = {
    'application/msword',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'application/vnd.ms-word.document.macroenabled.12',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.template',
    'application/vnd.ms-word.template.macroenabled.12',
    'application/rtf',
    'text/rtf',
  };

  // EXCEL (xls/xlsx + macro + template + csv)
  static const excel = {
    'application/vnd.ms-excel',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    'application/vnd.ms-excel.sheet.macroenabled.12',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.template',
    'application/vnd.ms-excel.template.macroenabled.12',
    'text/csv',
    'application/csv',
  };

  // POWERPOINT (ppt/pptx + macro + template + slideshow)
  static const powerpoint = {
    'application/vnd.ms-powerpoint',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    'application/vnd.ms-powerpoint.presentation.macroenabled.12',
    'application/vnd.openxmlformats-officedocument.presentationml.template',
    'application/vnd.ms-powerpoint.template.macroenabled.12',
    'application/vnd.openxmlformats-officedocument.presentationml.slideshow',
    'application/vnd.ms-powerpoint.slideshow.macroenabled.12',
  };

  // TEXT
  static const text = {'text/plain'};

  // IMAGE
  static const image = {'image/', 'image/jpeg'};
  // FOLDER IMAGE
  static const folderImage = {'folder/images'};

  static bool isImage(String mime, {bool allowPrefix = true}) {
    if (mime.isEmpty) return false;
    if (folderImage.contains(mime.toLowerCase())) return true;

    for (final g in image) {
      final key = g.toLowerCase();
      if (allowPrefix && key.endsWith('/') && mime.startsWith(key)) {
        return true;
      }
      if (mime == key) return true;
    }
    return false;
  }

  static bool isImageFolder(String mime) {
    return folderImage.contains(mime.toLowerCase());
  }

  static bool isPdf(String mime) {
    return pdf.contains(mime.toLowerCase());
  }

  static bool isWord(String mime) {
    return word.contains(mime.toLowerCase());
  }

  static bool isExcel(String mime) {
    return excel.contains(mime.toLowerCase());
  }

  static bool isPowerpoint(String mime) {
    return powerpoint.contains(mime.toLowerCase());
  }

  static bool isText(String mime) {
    return text.contains(mime.toLowerCase());
  }

  static bool isOther(String mime) {
    final lower = mime.toLowerCase();
    return !isPdf(lower) &&
        !isWord(lower) &&
        !isExcel(lower) &&
        !isPowerpoint(lower) &&
        !isText(lower) &&
        !isImage(lower);
  }
}
