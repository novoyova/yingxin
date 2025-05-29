abstract final class AppStrings {
  static const appName = 'YuanRung';

  // Splash
  static const splashTitle = '員榮醫院\n護理紀錄輔助系統';

  // Auth
  static const authTitle = '護理師登入';
  static const authUserIdTextFieldLabel = '帳號';
  static const authUserIdTextFieldHint = '請僅使用英文字母或數字';
  static const authErrorEmptyUserId = '請輸入帳號';
  static const authErrorShortUserId = '帳號長度至少為6';
  static const authErrorInvalidUserId = '請僅使用英文字母或數字';
  static const authButtonLogin = '登入';

  // NursingAssessment
  static const nursingAssessmentTabTitle = '歷程記錄';
  static const nursingAssessmentTabEmpty = '無歷程記錄';

  static const nursingAssessmentTileToday = '今天';
  static const nursingAssessmentTileYesterday = '昨天';
  static const nursingAssessmentTileDeleteDialogTitle = '刪除歷程記錄';
  static const nursingAssessmentTileDeleteDialogContent = '確定要刪除這歷程記錄嗎？';
  static const nursingAssessmentTileDeleteDialogButtonDelete = '刪除';
  static const nursingAssessmentTileDeleteDialogButtonCancel = '取消';
  static const nursingAssessmentTileDeleteDialogErrorDownloadFailed = '下載因音檔失敗';

  static const nursingAssessmentBottomTitle = '編輯歷程記錄 ';
  static const nursingAssessmentBottomNoteTextFieldLabel = '辨識結果 ';
  static const nursingAssessmentBottomCorrectedTextFieldLabel = '修正辨識結果 ';
  static const nursingAssessmentBottomButtonSave = '儲存';
  static const nursingAssessmentBottomButtonCancel = '取消';
  static const nursingAssessmentBottomButtonSpeechStart = '開始錄音';
  static const nursingAssessmentBottomButtonSpeechStop = '結束錄音';
  static const nursingAssessmentBottomButtonSpeechTranscribe = '辨識中...';
  static const nursingAssessmentBottomSheetErrorTranscribeFailed = '辨識失敗';
  static const nursingAssessmentBottomSheetErrorUserNotFound = '護理師ID不存在，請重新登入';
  static const nursingAssessmentBottomSheetCreateFailed = '新增失敗';
  static const nursingAssessmentBottomSheetUpdateFailed = '更新失敗';
}
