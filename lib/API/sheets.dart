import 'package:google_sheet_api/Model/result_model.dart';
import 'package:google_sheet_api/Model/student_model.dart';
import 'package:gsheets/gsheets.dart';

class SheetAPI{
  static const sheetCredentials = r'''
  {
  "type": "service_account",
  "project_id": "earnest-stock-343113",
  "private_key_id": "304c5d500272fe4a8e7a2275924911c7cdcdcb2c",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDEHyx8PVpWoim6\ncJiK8xnAMJKjeRKRPhcCcUoiEquWUOikFPPFoPz65sP8erj87oUK0DHfuk0JnPx4\nPtQyDKnBCKcN4XG/OQ7vot1ZRtFyGimYKBWGZW7+moL1GfCLEK6FdLzG76y1+hR6\ntOzC52S7ZIKRs/w0+FLH/XXWgtWsiSTCccMAZkOUzEJROYHYCU8jMfEAPc4MUVgw\n368VA6wTrKBTcaFaQxiRTvNLAm1rMpLQp4ZTHpVNSLSbcIYj1wn+0+NnguJpV3cn\nQ3FIHRHKZzIvT8k+O82wIKG254YERVpilF0k7nihwnTPNgvaiTQfpWhyWC3Sv/T3\ncLKAhvRlAgMBAAECggEAR1ThTLTR8TWdAMMoME2YHZdtFkkYcDxJiSlkYb0xrIP0\nAY3fVg+mQ6mAOgn204P7XsH3idyMXYU8LI4JhsSlT2DSxdEsGnVp0c4GPQzta9dJ\nLp7RqWamNrNDE1uiaiogl8isSpzsz+lL3o+El6UqtZ+qf80bW7bAAR5WaDWA+vXp\nql81jDT7eqOPBBKsza2B7XkTTUzXTicyVThdLxcqgQoc7Fb94kbkpOroGjB8hv5w\n6GiLQVDFr+v0/c4Z//Zq1LyzS4rNxYsQDVtf7dq2phlD2hyjC9kQGTXiHLZPSV5y\nNahuCjfEdb+ZCv1PSOr1f6tWFmUusODztyX+4CO+BwKBgQDgmF8M3s+ljc4MJ9fK\nK9qHie2e6bO+0FLKOnj5s4iw/zEBtJKrHEY/kNo7YF6h5JeFhZ6OrmIVNRSkMgxv\ngSTJnSpXAZcU1WuKyIDWgs7IKCS3acLGqvTrMMipAYidrQeh4Ad35CgIky86h9h7\nk942/CEyGcTRfHoJI+Kxm2LlVwKBgQDfi5C05wNS6WClVWb4d7L/InO763BWI4ds\nUMT3ugFMJx2AYhLcFneuEkMUJjJU7RHCpcQBUPRhMwepRNZCosyZOD/Jn5DrUWwc\n6OFswOKEzTQuFdIIg7w1DpS6iNl/VeVoAMjsdpbSHeZ1Tc+bXitfqMGvMCdDa4EV\n/ske4nXCowKBgQDYLNEQKkXjK6JvwMnLJnqoivHUS01fFFUboTxf25ZuBrK82Xly\niTx0YpArJo7vdH8DXaFH5EEz+Gttv16I1Nz70fK23Cj3PJTOeD7KOg2eSkVM5Nc9\nMb+bwNDjGz7LxYfbHy8RDuIZntGOnMKZ77GravLorjTrDczIj2nbWZzO8QKBgQCh\nwV2eaSLwlcrHF/sAg6zUDNvt+Lk6u068w90i3EcgEZW5Vj4LX36OSMydAd6dsUWO\nsWAZC7kptEEw7IyVfzPJEvilLn8wp6QxbxnfFdtS+SFuz39BhgFj6v8X0vp+t2re\nTOMWp+EOfXBLJVi6NfPwri4oVBG1KU8o2UoyvO81PQKBgQCw+flVXZlDeFAhkbz8\nPYlGlV2eQt7ZfRZqoq66INU0CK8R2FLC8UlNZF95XhkiKUK7rFSDkiBJ6AXjHJ12\nOo1wnd24jxubzP/IAgOq5s/IJPpw2jKtnHW79FDSpzj+qpxalq7rf3A37NGF351U\nY06S5WOzGYudQqaE+ehxpe0kiQ==\n-----END PRIVATE KEY-----\n",
  "client_email": "googlesheets@earnest-stock-343113.iam.gserviceaccount.com",
  "client_id": "118150198234279474838",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/googlesheets%40earnest-stock-343113.iam.gserviceaccount.com"
  }
  ''';

  static const spreadSheetId = '1euljRipzTGYt3FU5jPxmHDTwOg9OQx68xri5DPG7yVE';
  static final gSheets = GSheets(sheetCredentials);

  static Worksheet? data;
  static Worksheet? result;
  static Spreadsheet? spreadSheet;


  static Future init() async{
    spreadSheet = await gSheets.spreadsheet(spreadSheetId);
    data = await getWorkSheet(title : "DATA");
  }

  static Future getWorkSheet({required String title}) async{
    try{
      return await spreadSheet!.addWorksheet(title);
    }catch(e){
      return spreadSheet!.worksheetByTitle(title);
    }
  }
  static Future createWorkSheet() async{
    result = await getWorkSheet(title: "RESULT");
    final headerRow = ResultFields.getAllFields();
    result!.values.insertRow(1, headerRow);
  }

  static Future getResultSheet({required String title}) async{
    try{
      return await spreadSheet!.addWorksheet(title);
    }catch(e){
      return spreadSheet!.worksheetByTitle(title);
    }
  }

  static Future<List<StudentModel>?> getAll() async{
    if(data == null) return <StudentModel>[];
    final students = await data!.values.map.allRows();
    return students == null ? <StudentModel>[] : students.map(StudentModel.fromJson).toList();
  }

  static Future insertData(List<Map<String, dynamic>> list) async{
    if(result == null) return;
    result!.values.map.appendRows(list);
  }



}