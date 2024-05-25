class AppLinks {
  // Tokens
  static const String token = 'c9a894b89a574790ddab62ee5b79c1a6';
  // static const String razorPay = 'rzp_live_7f3SaVtDiGrGyY';
  static const String razorPay = 'rzp_test_iSKyxmFXFqsHVw';
  static const String agoraAppId = 'ca13f428a90d406a98686dee0107a38a';
  static const String messagingApi =
      'AAAAaLQLrko:APA91bFhUbEA3wI1r9ozBOGV78KG7FvbTuyudyMvvN5gOVesNxpNd5Ev4XpBMd5-heR8GynXIAFPLr03pMfv_A1cBi51Z6cyUh6Llx4Oy8-gXqrvxVKyMZ-pWGRey_i7KXxidUHvh4c_';
  // Base Urls
  static const String baseUrl = 'https://www.teleprac.com/';
  static const String api = '$baseUrl/api';
  static const String files = '$baseUrl/uploads';
  static const String blog = '$baseUrl/blog/blog-details';
  // Auth
  static const String signIn = '$api/signin';
  static const String signUp = '$api/signup';
  static const String forgotPassword = '$api/forgot_password';
  static const String generateOtp = '$api/api/generateotp';
  static const String verifyOtp = '$api/api/verify_otp';
  static const String changePassword = '$api/change_password';
  // Home
  static const String home = '$api/home';
  static const String notifications = '$api/notifications_list';
  static const String doctors = '$api/doctor_list';
  static const String specializations = '$api/specialization_list';
  static const String offers = '$api/offers_list';
  static const String blogs = '$api/blogs_list';
  static const String contactUs = '$api/contact_us';
  // Cart
  static const String placeOrder = '$api/placeOrder';
  static const String addToCart = '$api/add_cart';
  static const String updateCart = '$api/cart_list_update';
  static const String getCartItems = '$api/cart_list';
  // Dashboard
  static const String appointmentsList = '$api/appointments_list';
  static const String makeOutgoingCall = '$api/make_outgoing_call';
  static const String makeIncomingCall = '$api/make_incoming_call';
  static const String getSchedule = '$api/get_schedule';
  static const String addSchedule = '$api/add_schedule';
  static const String prescriptionsList = '$api/prescription_list';
  static const String prescriptionDetails = '$api/prescription_detail';
  static const String prescriptionCheckout = '$api/add_custom_cart';
  static const String labAppointmentsList = '$api/lab_appointments';
  static const String recommendedTests = '$api/customlabtest_list';
  static const String invoicesList = '$api/api/invoice_list';
  static const String invoiceDetails = '$api/pharmacy_invoice_details';
  static const String favouritesList = '$api/favourities_list';
  static const String chatsList = '$api/chat_users';
  static const String chatMessages = '$api/conversation';
  static const String sendMessage = '$api/send_message';
  static const String ordersList = '$api/order_list';
  static const String orderDetails = '$api/order_details';
  static const String orderTrack = '$api/orderTrack';
  static const String myFamily = '$api/family_list';
  static const String addFamilyMember = '$api/add_family';
  static const String myPatients = '$api/my_patients';
  static const String myReviews = '$api/reviews_list';
  static const String addReview = '$api/add_reviews';
  static const String addPrescription = '$api/prescription_insert';
  static const String addTest = '$api/customlabtest_insert';
  static const String medicalHistory = '$api/medical_records_list';
  static const String uploadMedicalHistory = '$api/upload_medical_record';
  static const String labReports = '$api/lab_appointments_for_dr';
  static const String myProducts = '$api/my_products_list';
  static const String addProduct = '$api/create_product';
  static const String editProduct = '$api/api/edit_product';
  static const String getDoctorAccountDetails = '$api/api/get_account_details';
  static const String addDoctorAccountDetails = '$api/api/add_account_details';
  static const String doctorAccounts = '$api/api/doctor_accounts_list';
  static const String paymentRequest = '$api/api/paymentrequest';

  // Doctor Screen
  static const String doctorDetails = '$api/doctor_details';
  static const String addToFavourites = '$api/add_favourities';
  // Appointments Screen
  static const String availableSlots = '$api/get_token';
  static const String bookFollowUp = '$api/book_followup';
  static const String needApp = '$api/need_new_appointment';
  static const String checkout = '$api/checkout';
  static const String nextAvailableAppointment = '$api/nextavialable';
  static const String notifyNextAppointment = '$api/notify_next';
  // Labs Screen
  static const String labsList = '$api/lab_list';
  static const String labDetails = '$api/lab_details';
  static const String testsList = '$api/all_lab_testlist';
  static const String testDetails = '$api/lab_test_details';
  static const String bookTest = '$api/checkout_lab';
  // Pharmacy Screen
  static const String pharmaciesList = '$api/search_pharmacy';
  static const String pharmacyDetails = '$api/get_phamacy_details';
  static const String pharmacyCategories =
      '$api/api/pharmacy_product_and_category_list_without_products';
  static const String selectedPharmacyProducts =
      '$api/pharmacy_product_and_category_list';
  static const String pharmacyProducts = '$api/get_all_products';
  // Profile
  static const String locationsApi = '$api/master';
  static const String patientProfile = '$api/patient_profile';
  static const String updatePatientProfile = '$api/update_patient_profile';
  static const String updateDoctorProfile = '$api/update_doctor_profile';
  static const String updatePharmacyProfile =
      '$api/api/update_pharamcy_profile';
}
