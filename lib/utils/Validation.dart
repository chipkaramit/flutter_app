

class Validation
{
  //---- validate First Name
  String validateFName(String strFName)
  {
    if(strFName.length==0)
    {
      return "Enter First Name";
    }
    else
      return null;
  }


  //---- validate Last Name
  String validateLName(String strLName)
  {
    if(strLName.length==0)
    {
      return "Enter Last Name";
    }
    else
      return null;
  }

  ///---- Email validation
  String validateEmail(String strEmail)
  {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    if (!regex.hasMatch(strEmail))
      return 'Please Enter Valid Email';
    else
      return null;
  }

  //---- Password validation
  String validatePassword(String strPassword)
  {
    if(strPassword.length ==0)
      return "Please Enter Password";
    else if(strPassword.length <6)
      return "Your password should be more then 6 char long";
    else
      return null;
  }

  //---- Mobile validation
  String validateMobile(String strMobile)
  {
    if(strMobile.length ==0)
      return "Please Enter Mobile Number";
    else if(strMobile.length <10)
      return "Your Mobile no should be 10 digit";
    else
      return null;
  }
}