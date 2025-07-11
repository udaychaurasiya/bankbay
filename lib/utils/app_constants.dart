// ignore_for_file: constant_identifier_names
class AppConstants {
  static const String LANGUAGE = "eng";
  static const String APP_NAME = 'BankBay';
  static const String BASE_URL = "https://cruid1.wisdomlife.in/";
  static const String USER_LOGIN = "${BASE_URL}api-emplyee/emp_login_new";
  static const String USER_PIN_LOGIN = "${BASE_URL}api-user/user-pin-login";
  static const String REGISTER_URL = "${BASE_URL}api-user/user-register";
  static const String REGISTER_URL_NEW = "${BASE_URL}api-user/user-register_new";
  static const String VERIFY_URL = "${BASE_URL}api-user/verify-phone-otp";
  static const String RESEND_OTP = "${BASE_URL}api-user/user-resend-phone-otp";
  static const String NEW_PASSWORD = "${BASE_URL}api-user/new_password";
  static const String FORGET_PASSWORD = "${BASE_URL}api-user/forget_password";
  static const String VERIFY_PHONE = "${BASE_URL}api-user/verify-phone-otp";
  static const String VERIFY_EMAIL = "${BASE_URL}api-user/verify-email-otp";
  static const String CUSTOMER_LOAN_LEAD = "${BASE_URL}api-user/customer-loan-lead";
  static const String GENERATE_OTP_API = "${BASE_URL}api-user/genereate-loginpin";
  static const String CHANGE_PASSWORD = "${BASE_URL}api-user/change-password";
  static const String EMPLOYEE_CHANGE_PASSWORD = "${BASE_URL}api-emplyee/emp-change-password";
  static const String OTP_VERIFY_PIN = "${BASE_URL}api-user/verify-otp-loginpin";
  static const String UPLOAD_DOCUMENT_API = "${BASE_URL}api-user/loan-lead-document-upload";
  static const String UPLOAD_SELFIE = "${BASE_URL}api-user/loan-lead-selfie";
  static const String GET_USER_PERMISSION = "${BASE_URL}api-user/get-user-permission";
  static const String GET_MY_LEAD = "${BASE_URL}api-user/get-mylead";
  static const String FRESH_LEAD = "${BASE_URL}api-user/my-fresh-Lead";
  static const String EMPLOYEE_KYC = "${BASE_URL}api-emplyee/emplyee-kyc-update";
  static const String EMPLOYEE_REGISTER = "${BASE_URL}api-emplyee/emplyee-register";
  static const String EMPLOYEE_PAYROLL = "${BASE_URL}api-emplyee/emplyee-payroll-update";
  static const String EMPLOYEE_ACCESS = "${BASE_URL}api-emplyee/emplyee-access-update";
  static const String PROFILE_COMPLETE = "${BASE_URL}api-user/profile-completed";
  static const String UPDATE_PROFILE = "${BASE_URL}api-user/update-profile";
  static const String TEAM_LEAD = "${BASE_URL}api-admin/get-myteam-lead";
  static const String UNASSIGN_LEAD = "${BASE_URL}api-admin/get-unassign-lead";
  static const String GET_APPROVE_ASSIGN = "${BASE_URL}api-admin/get-approve-assign-lead";
  static const String EMP_DOCUMENT_UPLOAD = "${BASE_URL}api-emplyee/emplyee-document-upload";
  static const String EMPLOYEE_APPROVE = "${BASE_URL}api-emplyee/employee-approve-list";
  static const String EMPLOYEE_DIRECT_REQUEST= "${BASE_URL}api-partner/direct-partner-req-list";
  static const String CUSTOMER_DETAILS = "${BASE_URL}api-user/get-customer-details";
  static const String EMPLOYEE_PUSHBACK = "${BASE_URL}api-emplyee/employee-pushback-list";
  static const String ALL_EMPLOYEE = "${BASE_URL}api-emplyee/all-employee-list";
  static const String PARTNER_REQUEST = "${BASE_URL}api-partner/partner-request-list";
  static const String PARTNER_DOCUMENT_UPLOAD = "${BASE_URL}api-partner/partner-document-upload";
  static const String PARTNER_APPROVAL = "${BASE_URL}api-partner/approve-partner-list";
  static const String PARTNER_DIRECT_REQUEST = "${BASE_URL}api-partner/direct-partner-req-list";
  static const String PARTNER_PUSHBACK = "${BASE_URL}api-partner/pushback-partner-list";
  static const String ALL_PARTNER = "${BASE_URL}api-partner/all-partner-list";
  static const String PARTNER_UPDATE_PAYROLL = "${BASE_URL}api-partner/partner-update-payroll";
  static const String PARTNER_ACCESS_UPDATE = "${BASE_URL}api-partner/partner-access-update";
  static const String EMPLOYEE_LOGIN = "${BASE_URL}api-emplyee/employee-login";
  static const String COUNTRY_API = "${BASE_URL}api-admin/get-country";
  static const String STATE_API = "${BASE_URL}api-admin/get-state-by-countryid";
  static const String UPDATE_KYC = "${BASE_URL}api-user/update-kyc";
  static const String GET_NEW_LEAD = "${BASE_URL}api-admin/get-new-lead";
  static const String GET_HOLD_LEAD = "${BASE_URL}api-admin/get-hold-lead";
  static const String GET_LOGIN_LEAD = "${BASE_URL}api-admin/get-login-lead";
  static const String GET_VERIFIED_LEAD = "${BASE_URL}api-admin/get-verified-lead";
  static const String GET_SANCTIONED_LEAD = "${BASE_URL}api-admin/get-sanctioned-lead";
  static const String GET_INC_DUE_LEAD = "${BASE_URL}api-admin/get-inc-due-lead";
  static const String GET_INC_APPROVAL_LEAD = "${BASE_URL}api-admin/get-inc-approval-lead";
  static const String GET_INC_PAID_LEAD = "${BASE_URL}api-admin/get-inc-paid-lead";
  static const String GET_ALL_LEAD = "${BASE_URL}api-admin/get-all-lead";
  static const String GET_LEAD_DETAILS = "${BASE_URL}api-user/get-lead-details";
  static const String LOCK_UNLOCK_LEAD = "${BASE_URL}api-admin/Lock-unlock-lead";
  static const String UPDATE_LEAD_STATUS = "${BASE_URL}api-user/update-lead-status";
  static const String MY_LOAN_HISTORY = "${BASE_URL}api-user/my-loan-apply-history";
  static const String UPDATE_LEAD_DOCUMENT_STATUS = "${BASE_URL}api-admin/update-lead-document-status";
  static const String UPDATE_EMPLOYEE_REQUEST = "${BASE_URL}api-emplyee/update-employee-request";
  static const String EMPLOYEE_REQUEST_LIST = "${BASE_URL}api-emplyee/employee-request-list";
  static const String UPDATE_PARTNER_REQUEST = "${BASE_URL}api-partner/update-partner-request";
  static const String GET_EMPLOYEE_DETAILS = "${BASE_URL}api-emplyee/get-employee-Details";
  static const String CHECK_ASSIGNMENT_APPROVAL_EXIST = "${BASE_URL}api-admin/check-assigment-approval-exist";
  static const String ASSIGNMENT_CHANGE_APPROVAL = "${BASE_URL}api-admin/assignment-change-approval";
  static const String CHECK_OWNER_EXIST = "${BASE_URL}api-admin/check-owner-exist";
  static const String UPDATE_LEAD_ASSIGN_TELE = "${BASE_URL}api-admin/update-lead-assign_tele";
  static const String UPDATE_LEAD_ASSIGN_FOS = "${BASE_URL}api-admin/update-lead-assign_fos";
  static const String UPDATE_INC_DUE = "${BASE_URL}api-admin/update-inc-due";
  static const String USER_PERMISSION_API = "${BASE_URL}api-user/get-user-permission";
  static const String GET_MY_EARNINGS = "${BASE_URL}api-user/get-my-earnings";
  static const String PARTNER_APPROVAL_REQUEST = "${BASE_URL}api-partner/partner-approver-request";
  static const String EMPLOYEE_APPROVAL_REQUEST = "${BASE_URL}api-emplyee/employee-approver-request";
  static const String APP_SHARE_API = "${BASE_URL}api-user/share-app";
  static const String GET_MY_TEAM = "${BASE_URL}api-admin/get-my-team";
  static const String GET_MY_CUST = "${BASE_URL}api-user/get-my-customer";
  static const String EMPLOYEE_PUSHBACK_ABOUT_UPDATE = "${BASE_URL}api-emplyee/emp-basic-details-update";
  static const String UPDATE_ASSIGN_LEAD = "${BASE_URL}api-admin/update-lead-assign";
  static const String CHECK_SUPERVISOR_EXIST = "${BASE_URL}api-admin/check-supervisor-exist";
  static const String UPDATE_LOAN_KYC = "${BASE_URL}api-user/update-loan-kyc";
  static const String UPDATE_DRAFT_LOAN_LEAD = "${BASE_URL}api-user/update-loan-lead";
  static const String EMPLOYEE_PROFILE_UPLOAD = "${BASE_URL}api-emplyee/emp-profile-upload";
  static const String DRAFT_LOAN_LEAD_API = "${BASE_URL}api-user/my-loan-draft-loan";
  static const String UPDATE_FINGERPRINT_LOCK = "${BASE_URL}api-emplyee/update-fingreprint-lock-status";
  static const String GOOGLE_FACEBOOK_SIGN_IN = "${BASE_URL}api-user/google-signup";
  static const String SEARCH_CUSTOMER_API = "${BASE_URL}api-user/search-customer";
  static const String GET_ALL_LEADS_STATUS_API = "${BASE_URL}api-admin/get-lead-by-status";
  static const String VALIDATE_LEAD_STATUS = "${BASE_URL}api-user/validate-lead-status";
  static const String VERIFICATION_LEAD_API = "${BASE_URL}api-admin/get-verified-lead";
  static const String CHECK_DUPLICATE_LEAD = "${BASE_URL}api-user/check-douplicate-lead";
  static const String GET_NOTIFICATIONS_API = "${BASE_URL}api-emplyee/get-notification";
  static const String UPDATE_FCM_TOKEN = "${BASE_URL}api-emplyee/update-fcm-token";
}
