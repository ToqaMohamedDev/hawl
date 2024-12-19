import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SharePer{
   static  saveData(String token,String tokenValue)async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      sharedPreferences.setString(token, tokenValue);
  }
   static Future<String> getData(String token)async{
    SharedPreferences sharedPreferences=  await SharedPreferences.getInstance();
    if(sharedPreferences.getString(token) != null){
     return sharedPreferences.getString(token).toString();
    }else{
      return "NA";
    }
  }
}