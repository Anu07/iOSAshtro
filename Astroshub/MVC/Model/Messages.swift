//
//  Messages.swift
//  AppTemplate
//
//  Created by admin on 15/01/19.
//  Copyright © 2019 dotsquare. All rights reserved.
//

import Foundation

enum Messages : String {
    case USERNAME_EMPTY     = "Username field can not be blank."
    case NAME_EMPTY         = "Please enter  name."
    case FNAME_EMPTY        = "Please enter first name."
    case LNAME_EMPTY        = "Please enter last name."
    case PHONE_EMPTY        = "Please enter mobile number."
    case PHONE_AMOUNT       = "Please enter amount."
    case DATE_EMPTY         = "Please select date and time."
    case PHONE_RANGE        = "Please enter phone number greater than 4 digit."
    case EMAIL_EMPTY        = "Email field can not be blank."
    case VALIDEMAIL_EMPTY   = "Please enter valid Email ID"
    case EMAIL_INVALID      = "Email is invalid, Please check and fill again."
    case PASSWORD_EMPTY     = "Password field can not be blank."
    case CITY_EMPTY         = "Password select Country"
    case PASSWORD_MATCH     = "Password and confirm password doesn't match."
    case TERMS_CONDITION    = "Please agree to all Terms & Conditions and Privacy policy of Astroshubh."
    case PHONE_DOB          = "Please select DOB."
    case PHONE_GENDER       = "Please select Gender."
    case PHONE_POB          = "Please enter Pob."
    case PHONE_ProblemArea  = "Please enter Problem Area."
    case PHONE_DATE         = "Please select Date."
    case PHONE_TIME         = "Please select Time"
    case PHONE_OTP          = "Please enter Otp."
    case PHONE_PRICE        = "Please enter Price."
    case PHONE_LOCATION     = "Please select Location."
    case PHONE_COUNTRY      = "Please select Country."
    case PHONE_BIRTH        = "Please enter Birth Palace."
    case PHONE_REPORTNAME   = "Please enter Report Name."
    //Password
    case OLD_PASSWORD_EMPTY     = "Old password field can not be blank."
    case NEW_PASSWORD_EMPTY     = "New password field can not be blank."
    case CONFIRM_PASSWORD_EMPTY = "Confirm password field can not be blank."
    case PASSWORD_DIFFERENT     = "New password did not match with confirm password."
    case VERIFICATION_CODE      = "Please enter verificaton code"
    case PASSWORD_LENTH         = "Password must be equal or greater than 6 digit."
    case LOGOUT                 = "Are you sure you want to logout"
    
    //Profile
    case GENDER_BLANK        = "Please select gender."
    case DATESELECTION        = "Please Select Date."
    
    case BlogsTitle        = "Please Enter Blog Title."
    case BlogsCategory     = "Please Enter Blog Category."
    case BlogsTag         = "Please Enter Blog Tag."
    case BlogsContent         = "Please Enter Blog Description."
    case KYCDOCUTYPE         = "Please Select Document Type"
    case KYCDOCUTYPEIMAGES         = "Please Upload Blogs Images"
    case BlogsImagessssss         = "Please Select Blog Image"
    case DESCRIPTION         = "Please Enter  Description."
    
    
    case SUBJECT_EMPTY         = "Please enter  subject."
   
   
    case ENQUIRY_EMPTY         = "Please enter Enquiry Message."
    case MESSAGE_EMPTY         = "Please enter Message."
}


public enum MessageError: String {
    
    case USER_FIRST_NAME   = "Please enter first name."
    case USER_LAST_NAME    = "Please enter last name."
    case USER_NAME         = "Please enter name."
    case EMAIL_EMPTY       = "Please enter email address."
    case EMAIL_INVALID     = "Please enter correct email address."
    case PHONE_EMPTY       = "Please enter mobile number."
    case PHONE_INVALID     = "Please enter correct mobile number."
    
    case PASSWORD_OLD_EMPTY = "Please enter old password."
    case PASSWORD_EMPTY    = "Please enter password."
    case CONFIRM_PASSWORD_EMPTY    = "Please enter confirm password."
    case PASSWORD_MATCH    = "Password should be same."
    case PASSWORD_LENGTH   = "Password should be minimum 6 digits"
    
    case INTERNET_ERROR    = "Please check your internet connection"
    case GENDER_ERROR    = "Please select your gender"
    case DOB_ERROR    = "Please enter your date of birth"
    
    case VERIFICATION_CODE = "Please enter verificaton code"
    case LOCATION = "Please enter your location"
    case ABOUT    = "Please enter about you"
    case INTERESTAREA = "Please select at least one interest area"
}

public enum AlertButton: String {
    case OK     = "OK"
    case CANCEL = "Cancel"
    case YES    = "Yes"
    case NO     = "No"
    case CAMERA = "Camera"
    case PHOTOS = "Photo Library"
}

