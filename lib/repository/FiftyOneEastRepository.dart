import 'dart:convert';
import 'package:fiftyoneeast/models/change_password_respmodel.dart';
import 'package:fiftyoneeast/models/change_password_rqstmodel.dart';
import 'package:fiftyoneeast/models/fetch_active_coupons_respmodel.dart';
import 'package:fiftyoneeast/models/fetch_active_coupons_restmodel.dart';
import 'package:fiftyoneeast/models/fetch_complaint_respmodel.dart';
import 'package:fiftyoneeast/models/fetch_complaint_rqstmodel.dart';
import 'package:fiftyoneeast/models/fetch_customer_details_respmodel.dart';
import 'package:fiftyoneeast/models/fetch_customer_details_rqstmodel.dart';
import 'package:fiftyoneeast/models/fetch_retro_claim_respmodel.dart';
import 'package:fiftyoneeast/models/fetch_retro_claim_rqstmodel.dart';
import 'package:fiftyoneeast/models/forgot_password_respmodel.dart';
import 'package:fiftyoneeast/models/forgot_password_rqstmodel.dart';
import 'package:fiftyoneeast/models/get_comm_preff_respmodel.dart';
import 'package:fiftyoneeast/models/get_comm_preff_rqstmodel.dart';
import 'package:fiftyoneeast/models/gift_card_rqstmodel.dart';
import 'package:fiftyoneeast/models/gift_card_respmodel.dart';
import 'package:fiftyoneeast/models/login_respmodel.dart';
import 'package:fiftyoneeast/models/login_rqstmodel.dart';
import 'package:fiftyoneeast/models/loyality_points_respmodel.dart';
import 'package:fiftyoneeast/models/loyality_points_rqstmodel.dart';
import 'package:fiftyoneeast/models/purchase_history_respmodel.dart';
import 'package:fiftyoneeast/models/purchase_history_rqstmodel.dart';
import 'package:fiftyoneeast/models/save_complaint_respmodel.dart';
import 'package:fiftyoneeast/models/save_complaint_rqstmodel.dart';
import 'package:fiftyoneeast/models/save_retro_claim_respmodel.dart';
import 'package:fiftyoneeast/models/save_retro_claim_rqstmodel.dart';
import 'package:fiftyoneeast/models/set_new_password_respmodel.dart';
import 'package:fiftyoneeast/models/set_new_password_rqstmodel.dart';
import 'package:fiftyoneeast/models/sign_up_respmodel.dart';
import 'package:fiftyoneeast/models/sign_up_rqstmodel.dart';
import 'package:fiftyoneeast/models/store_location_respmodel.dart';
import 'package:fiftyoneeast/models/tiers_respmodel.dart';
import 'package:fiftyoneeast/models/token_validation_respmodel.dart';
import 'package:fiftyoneeast/models/token_validation_rqstmodel.dart';
import 'package:fiftyoneeast/models/update_comm_preff_respmodel.dart';
import 'package:fiftyoneeast/models/update_comm_preff_rqstmodel.dart';
import 'package:fiftyoneeast/models/update_customer_details_respmodel.dart';
import 'package:fiftyoneeast/models/update_customer_details_rqstmodel.dart';
import 'package:fiftyoneeast/models/validate_mobile_number_respmodel.dart';
import 'package:fiftyoneeast/models/validate_mobile_number_rqstmodel.dart';
import 'package:fiftyoneeast/networking/api_provider.dart';
import 'package:fiftyoneeast/util/PreferenceUtils.dart';

class FiftyOneEastRepository
{
  ApiProvider _provider = ApiProvider();
  Map<String,String> headers = {'Content-Type':'application/json'};


  /*Future<chuckCategories> fetchChuckCategoryData() async
  {
    final response = await _provider.get("jokes/categories");
    return chuckCategories.fromJson(response);
  }*/


  //----- login
  Future<LoginResponseModel> login(LoginRequestModel request) async
  {
    final requestBody = jsonEncode(request);
    final response = await _provider.post("authenticate", body:requestBody, headers: headers,);
    return LoginResponseModel.fromJson(response);
  }

  //--- Create Account or sign
  Future<SignUpResponseModel> signUp(SignUpRequestModel request) async
  {
    final requestBody = jsonEncode(request);
    final response =  await _provider.post("signup", body:requestBody, headers: headers,);
    return SignUpResponseModel.fromJson(response);
  }

  //--- Fetch customer details
  Future<FetchCustomerDetailsResponseModel> fetchProfile(FetchCustomerDetailsRequestModel request) async
  {
    final requestBody = jsonEncode(request);
    final response =  await _provider.post("fetchProfile", body:requestBody, headers: headers,);
    return FetchCustomerDetailsResponseModel.fromJson(response);
  }

  //--- update customer details
  Future<UpdateCustomerDetailsResponseModel> updateProfile(UpdateCustomerDetailsRequestModel request) async
  {
    await PreferenceUtils.getInstance();

    Map<dynamic, dynamic> custInfo = PreferenceUtils.getObject(PreferenceUtils.KEY_CUSTOMER_INFO);

    if(custInfo.isNotEmpty)
      {
        LoginResponseModel userInfo  = LoginResponseModel.fromJson(custInfo);
        //var token = custInfo["token"];
        //var token = userInfo.data.token;
        var token = userInfo.token;
        print(custInfo["token"]);

        headers = {'Content-Type':'application/json', 'Authorization': 'Bearer $token',};
      }

    final requestBody = jsonEncode(request);
    final response =  await _provider.post("updateProfile", body:requestBody, headers: headers,);
    return UpdateCustomerDetailsResponseModel.fromJson(response);
  }

  //--- validated  number
  Future<ValidateMobileResponseModel> validateNumber(ValidateMobileRequestModel request) async
  {
    final requestBody = jsonEncode(request);
    final response =  await _provider.post("validatenumber", body:requestBody, headers: headers,);
    return ValidateMobileResponseModel.fromJson(response);
  }

  //--- forgotPassword
  Future<ForgotPasswordResponseModel> forgotPassword(ForgotPasswordRequestModel request) async
  {
    final requestBody = jsonEncode(request);
    final response =  await _provider.post("forgotPassword", body:requestBody, headers: headers,);
    return ForgotPasswordResponseModel.fromJson(response);
  }

  //--- change Password
  Future<ChangePasswordResponseModel> changePassword(ChangePasswordRequestModel request) async
  {
    await PreferenceUtils.getInstance();

    Map<dynamic, dynamic> custInfo = PreferenceUtils.getObject(PreferenceUtils.KEY_CUSTOMER_INFO);

    if(custInfo.isNotEmpty)
    {
      LoginResponseModel userInfo  = LoginResponseModel.fromJson(custInfo);
      //var token = custInfo["token"];
      var token = userInfo.token;
      print(custInfo["token"]);

      headers = {'Content-Type':'application/json', 'Authorization': 'Bearer $token',};
    }

    final requestBody = jsonEncode(request);
    final response =  await _provider.post("changePassword", body:requestBody, headers: headers,);
    return ChangePasswordResponseModel.fromJson(response);
  }

  //--- setNewPassword
  Future<SetNewPasswordResponseModel> setNewPassword(SetNewPasswordRequestModel request) async
  {
    /*await PreferenceUtils.getInstance();

    Map<dynamic, dynamic> custInfo = PreferenceUtils.getObject(PreferenceUtils.KEY_CUSTOMER_INFO);

    if(custInfo.isNotEmpty)
    {
      LoginResponseModel userInfo  = LoginResponseModel.fromJson(custInfo);
      //var token = custInfo["token"];
      var token = userInfo.data.token;
      print(custInfo["token"]);

      headers = {'Content-Type':'application/json', 'Authorization': 'Bearer $token',};
    }*/

    final requestBody = jsonEncode(request);
    final response =  await _provider.post("setNewPassword", body:requestBody, headers: headers,);
    return SetNewPasswordResponseModel.fromJson(response);
  }

  //--- update communication prefernce
  Future<UpdateCommunicationPreferenceResponseModel> updateCommpref(UpdateCommunicationPreferenceRequestModel request) async
  {
    final requestBody = jsonEncode(request);
    final response =  await _provider.post("more/updateCommpref", body:requestBody, headers: headers,);
    return UpdateCommunicationPreferenceResponseModel.fromJson(response);
  }

  //--- get communication prefernce
  Future<GetCommunicationPreferenceResponseModel> commpref(GetCommunicationPreferenceRequestModel request) async
  {
    final requestBody = jsonEncode(request);
    final response =  await _provider.post("more/commpref", body:requestBody, headers: headers,);
    return GetCommunicationPreferenceResponseModel.fromJson(response);
  }

  //--- purchase history
  Future<PurchaseHistoryResponseModel> purchaseHistory(PurchaseHistoryRequestModel request) async
  {
    await PreferenceUtils.getInstance();

    Map<dynamic, dynamic> custInfo = PreferenceUtils.getObject(PreferenceUtils.KEY_CUSTOMER_INFO);

    if(custInfo.isNotEmpty)
    {
      LoginResponseModel userInfo  = LoginResponseModel.fromJson(custInfo);
      //var token = custInfo["token"];
      var token = userInfo.token;
      print(custInfo["token"]);

      headers = {'Content-Type':'application/json', 'Authorization': 'Bearer $token',};
    }

    final requestBody = jsonEncode(request);
    final response =  await _provider.post("purchaseHistory", body:requestBody, headers: headers,);
    return PurchaseHistoryResponseModel.fromJson(response);
  }

  //--- Loyality Points
  Future<LoyalityPointsResponseModel> loyaltyPoints(LoyalityPointsRequestModel request) async
  {
    await PreferenceUtils.getInstance();

    Map<dynamic, dynamic> custInfo = PreferenceUtils.getObject(PreferenceUtils.KEY_CUSTOMER_INFO);

    if(custInfo.isNotEmpty)
    {
      LoginResponseModel userInfo  = LoginResponseModel.fromJson(custInfo);
      //var token = custInfo["token"];
      var token = userInfo.token;
      print(custInfo["token"]);

      headers = {'Content-Type':'application/json', 'Authorization': 'Bearer $token',};
    }


    final requestBody = jsonEncode(request);
    final response =  await _provider.post("loyaltyPoints", body:requestBody, headers: headers,);
    return LoyalityPointsResponseModel.fromJson(response);
  }

  // stores
  Future<StoreLocationResponseModel> stores() async
  {
    final response =  await _provider.get("more/stores");
    return StoreLocationResponseModel.fromJson(response);
  }

  //----- get active coupons / offer details
  Future<FetchActiveCouponsResponseModel> fetchActiveCoupons(FetchActiveCouponsRequestModel request) async
  {
    await PreferenceUtils.getInstance();

    Map<dynamic, dynamic> custInfo = PreferenceUtils.getObject(PreferenceUtils.KEY_CUSTOMER_INFO);

    if(custInfo.isNotEmpty)
    {
      LoginResponseModel userInfo  = LoginResponseModel.fromJson(custInfo);
      //var token = custInfo["token"];
      var token = userInfo.token;
      print(custInfo["token"]);

      headers = {'Content-Type':'application/json', 'Authorization': 'Bearer $token',};
    }


    final requestBody = jsonEncode(request);
    final response =  await _provider.post("fetchActiveCoupons", body:requestBody, headers: headers,);
    return FetchActiveCouponsResponseModel.fromJson(response);
  }

  //---- get tier
  Future<TiersModel> tiers() async
  {
    final response =  await _provider.get("more/tiers");
    return TiersModel.fromJson(response);
  }

  //----- get gift Card
  Future<GiftCardResponseModel> fetchGiftCard(GiftCardRequestModel request) async
  {
    await PreferenceUtils.getInstance();

    Map<dynamic, dynamic> custInfo = PreferenceUtils.getObject(PreferenceUtils.KEY_CUSTOMER_INFO);

    if(custInfo.isNotEmpty)
    {
      LoginResponseModel userInfo  = LoginResponseModel.fromJson(custInfo);
      //var token = custInfo["token"];
      var token = userInfo.token;
      print(custInfo["token"]);

      headers = {'Content-Type':'application/json', 'Authorization': 'Bearer $token',};
    }


    final requestBody = jsonEncode(request);
    final response =  await _provider.post("fetchGiftCard", body:requestBody, headers: headers,);
    return GiftCardResponseModel.fromJson(response);
  }

  //--- Save complaint
  Future<SaveComplaintResponseModel> saveComplaint(SaveComplaintRequestModel request) async
  {
    await PreferenceUtils.getInstance();

    Map<dynamic, dynamic> custInfo = PreferenceUtils.getObject(PreferenceUtils.KEY_CUSTOMER_INFO);

    if(custInfo.isNotEmpty)
    {
      LoginResponseModel userInfo  = LoginResponseModel.fromJson(custInfo);
      //var token = custInfo["token"];
      var token = userInfo.token;
      print(custInfo["token"]);

      headers = {'Content-Type':'application/json', 'Authorization': 'Bearer $token',};
    }

    final requestBody = jsonEncode(request);
    final response =  await _provider.post("saveComplaint", body:requestBody, headers: headers,);
    return SaveComplaintResponseModel.fromJson(response);
  }

  //--- fetch complaint
  Future<FetchComplaintResponseModel> fetchComplaint(FetchComplaintRequestModel request) async
  {
    await PreferenceUtils.getInstance();

    Map<dynamic, dynamic> custInfo = PreferenceUtils.getObject(PreferenceUtils.KEY_CUSTOMER_INFO);

    if(custInfo.isNotEmpty)
    {
      LoginResponseModel userInfo  = LoginResponseModel.fromJson(custInfo);
      //var token = custInfo["token"];
      var token = userInfo.token;
      print(custInfo["token"]);

      headers = {'Content-Type':'application/json', 'Authorization': 'Bearer $token',};
    }

    final requestBody = jsonEncode(request);
    final response =  await _provider.post("fetchComplaint", body:requestBody, headers: headers,);
    return FetchComplaintResponseModel.fromJson(response);
  }

  //--- Save Retro claim
  Future<SaveRetroClaimResponseModel> saveRetroClaim(SaveRetroClaimRequestModel request) async
  {
    await PreferenceUtils.getInstance();

    Map<dynamic, dynamic> custInfo = PreferenceUtils.getObject(PreferenceUtils.KEY_CUSTOMER_INFO);

    if(custInfo.isNotEmpty)
    {
      LoginResponseModel userInfo  = LoginResponseModel.fromJson(custInfo);
      //var token = custInfo["token"];
      var token = userInfo.token;
      print(custInfo["token"]);

      headers = {'Content-Type':'application/json', 'Authorization': 'Bearer $token',};
    }

    final requestBody = jsonEncode(request);
    final response =  await _provider.post("saveRetroClaim", body:requestBody, headers: headers,);
    return SaveRetroClaimResponseModel.fromJson(response);
  }

  //--- fetch retro claim
  Future<FetchRetroClaimResponseModel> fetchRetroClaim(FetchRetroClaimRequestModel request) async
  {
    await PreferenceUtils.getInstance();

    Map<dynamic, dynamic> custInfo = PreferenceUtils.getObject(PreferenceUtils.KEY_CUSTOMER_INFO);

    if(custInfo.isNotEmpty)
    {
      LoginResponseModel userInfo  = LoginResponseModel.fromJson(custInfo);
      //var token = custInfo["token"];
      var token = userInfo.token;
      print(custInfo["token"]);

      headers = {'Content-Type':'application/json', 'Authorization': 'Bearer $token',};
    }

    final requestBody = jsonEncode(request);
    final response =  await _provider.post("fetchRetroClaim", body:requestBody, headers: headers,);
    return FetchRetroClaimResponseModel.fromJson(response);
  }

  //----- get token verification
  Future<TokenValidationResponseModel> tokenValidation(TokenValidationRequestModel request) async
  {
    await PreferenceUtils.getInstance();

    Map<dynamic, dynamic> custInfo = PreferenceUtils.getObject(PreferenceUtils.KEY_CUSTOMER_INFO);

    if(custInfo.isNotEmpty)
    {
      LoginResponseModel userInfo  = LoginResponseModel.fromJson(custInfo);
      //var token = custInfo["token"];
      var token = userInfo.token;
      print(custInfo["token"]);

      headers = {'Content-Type':'application/json', 'Authorization': 'Bearer $token',};
    }


    final requestBody = jsonEncode(request);
    final response =  await _provider.post("tokenValidation", body:requestBody, headers: headers,);
    return TokenValidationResponseModel.fromJson(response);
  }
}