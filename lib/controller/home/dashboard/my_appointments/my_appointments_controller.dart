import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/functions/replace.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/home/dashboard/appointment/appointment_model.dart';
import 'package:teleprac/model/home/dashboard/appointment/call_data_model.dart';
import 'package:teleprac/routes.dart';
import 'package:timezone/standalone.dart';
import 'package:timezone/data/latest.dart';

class MyAppointmentsController extends GetxController {
  late List myAppointments;
  late TZDateTime now;
  late String currentTime;
  late String myRole;
  MyServices myServices = Get.find();
  Crud crud = Crud();
  @override
  onInit() async {
    myAppointments = Get.arguments['appointmentsList'];
    initializeTimeZones();
    Location indianTimeZone = getLocation('Asia/Kolkata');
    now = TZDateTime.now(indianTimeZone);
    currentTime = DateFormat("h:mm a")
        .format(Jiffy(now.toString().split('.')[0]).dateTime);
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        now = TZDateTime.now(indianTimeZone);
        currentTime = DateFormat("h:mm a")
            .format(Jiffy(now.toString().split('.')[0]).dateTime);
        update();
      },
    );
    myRole = myServices.sharedPreferences.getString('role')!;
    super.onInit();
  }

  call({
    required AppointmentModel appointmentModel,
    required String callType,
  }) async {
    loading();
    var res = await isCallRunning(
      appointmentModel: appointmentModel,
      callType: callType,
    );
    if (res is CallDataModel) {
      Get.offNamed(
        AppRoutes.callScreen,
        arguments: {
          'callData': res,
          'callType': callType,
          'appointmentEndTime': appointmentModel.endTime,
          'patient_id': appointmentModel.patientUserId,
          'doctor_id': appointmentModel.doctorUserId,
        },
      );
    } else if (res is AdditionalKeyData) {
      Get.offNamed(
        AppRoutes.callScreen,
        arguments: {
          'agoraData': res,
          'callType': callType,
          'appointmentEndTime': appointmentModel.endTime,
          'patient_id': appointmentModel.patientUserId,
          'doctor_id': appointmentModel.doctorUserId,
        },
      );
    } else {
      Get.back();
      Fluttertoast.showToast(
        msg: 'Something Went Wrong',
        backgroundColor: AppColors.secondaryColor,
        textColor: AppColors.black,
      );
    }
  }

  isCallRunning({
    required AppointmentModel appointmentModel,
    required String callType,
  }) async {
    CollectionReference calls = FirebaseFirestore.instance.collection('calls');
    DocumentReference currentAppointmentCall =
        calls.doc(appointmentModel.id.toString());
    DocumentSnapshot data = await currentAppointmentCall.get();

    if (data.data() == null) {
      var res = await callRequest(
        appointmentModel: appointmentModel,
        callType: callType,
        isRunning: false,
      );

      if (res is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(res);
        CallDataModel callDataModel =
            CallDataModel.fromJson(responseModel.data);

        if (responseModel.responseCode == '200') {
          await currentAppointmentCall.set(
            {
              'hasToken': true,
            },
          );
          return callDataModel;
        }
      }
    } else if (data.get('hasToken') == true) {
      var res = await callRequest(
        appointmentModel: appointmentModel,
        callType: callType,
        isRunning: true,
      );

      if (res is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(res);
        AdditionalKeyData additionalCallData =
            AdditionalKeyData.fromJson(responseModel.additionalCallData!);
        if (responseModel.responseCode == '200') {
          return additionalCallData;
        }
      }
    }
  }

  callRequest({
    required AppointmentModel appointmentModel,
    required String callType,
    required bool isRunning,
  }) async {
    var res = await crud.connect(
      link: isRunning ? AppLinks.makeIncomingCall : AppLinks.makeOutgoingCall,
      data: {
        'appoinment_id': appointmentModel.id!,
        'call_type': callType,
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );

    return res.fold((l) => l, (r) => r);
  }

  String formatAppointmentDate({required String date}) {
    String month = date.split(' ')[1];
    String day = date.split(' ')[0];
    String year = date.split(' ')[2];
    String formatedDate = '$year-$month-$day';

    return replace(
      text: formatedDate,
      replace: {
        'Jan': '01',
        'Feb': '02',
        'Mar': '03',
        'Apr': '04',
        'May': '05',
        'Jun': '06',
        'Jul': '07',
        'Aug': '08',
        'Sep': '09',
        'Oct': '10',
        'Nov': '11',
        'Dec': '12',
      },
    );
  }

  String appointmentDateToNowCompare({
    required String currentDate,
    required String appointmentDate,
  }) {
    String compareSympol = replace(
        text: DateTime.parse(currentDate)
            .compareTo(DateTime.parse(appointmentDate)),
        replace: {
          '0': '=',
          '-1': '<',
          '1': '>',
        });
    String result = '$currentDate $compareSympol $appointmentDate';
    return result;
  }
}
