import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';



const Color themeColorDeep =Colors.orangeAccent;
Text GrayText(String txt) {
  return Text(txt,
    style: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: Colors.black45,
    ),

  );
}


Text BlackText(String txt) {
  return Text(txt,
    style: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: Colors.black38,
    ),

  );
}


class UserInfoData{
  String? userDocId;
  String? email;
  String? name;
  int? age;
  String? level;
  String? occupation;
  String? nativeLang;
  String? country;
  String? town;
  String? homeCountry;
  String? homeTown;
  String? gender;
  String? placeWannaGo;
  String? greeting;
  String? description;

  UserInfoData();

  void setUserDocId(String userDocId){
  this.userDocId=userDocId;
}

  void setEmail(String email){
    this.email=email;
  }

  void setName(String name){
    this.name=name;
  }

  void setAge(int age){
    this.age=age;
  }

  void setLevel(String level){
    this.level=level;
  }

  void setOccupation(String occupation){
    this.occupation=occupation;
  }

  void setNativeLang(String nativeLang){
    this.nativeLang=nativeLang;
  }
  void setCountry(String country){
    this.country=country;
  }
  void setTown(String town){
    this.town=town;
  }

  void setHomeCountry(String homeCountry){
    this.homeCountry=homeCountry;
  }
  void setHomeTown(String homeTown){
    this.homeTown=homeTown;
  }

  void setGender(String gender){
    this.gender=gender;
  }

  void setPlaceWannaGo(String placeWannaGo){
    this.placeWannaGo=placeWannaGo;
  }

  void setGreeting(String greeting){
    this.greeting=greeting;
  }

  void setDescription(String description){
    this.description=description;
  }


  String? getUserDocId(){
    return userDocId;
  }

  String? getEmail(){
    return email;
  }
  String? getName(){
    return name;
  }

  int? getAge(){
    return age;
  }

  String? getLevel(){
    return level;
  }

  String? getOccupation(){
    return occupation;
  }

  String? getNativeLang(){
    return nativeLang;
  }

  String? getCountry(){
    return country;
  }

  String? getTown(){
    return town;
  }

  String? getHomeCountry(){
    return homeCountry;
  }

  String? getHomeTown(){
    return homeTown;
  }

  String? getGender(){
    return gender;
  }
  String? getPlaceWannaGo(){
    return placeWannaGo;
  }

  String? getGreeting(){
    return greeting;
  }

  String? getDescription(){
    return description;
  }

}