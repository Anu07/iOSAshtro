/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct AstroList : Mappable {
	var phone_number : String?
	var email : String?
	var verify : String?
	var astrologers_id : String?
	var astrologers_uni_id : String?
	var astrologers_slug : String?
	var astrologers_online_portal : String?
	var astrologers_name : String?
	var astrologers_dob : String?
	var astrologers_gender : String?
	var astrologers_alternative_phone : String?
	var astrologers_address : String?
	var astrologers_city : String?
	var astrologers_state : String?
	var astrologers_pincode : String?
	var astrologers_image : String?
	var astrologers_image_url : String?
	var astrologers_id_proof : String?
	var astrologers_long_biography : String?
	var astrologers_short_biography : String?
	var astrologers_experience : String?
	var astrologers_tag : String?
	var astrologers_pancard : String?
	var astrologers_skills : String?
	var astrologers_language : String?
	var astrologers_category_list : String?
	var astrologers_status : String?
	var astrologers_fees : String?
	var astrologers_position : String?
	var astrolozer_bank_name : String?
	var astrolozer_acc_no : String?
	var astrolozer_acc_type : String?
	var astrolozer_ifsc_code : String?
	var astrolozer_acc_name : String?
	var astro_call_status : String?
	var astro_chat_status : String?
	var astro_call_online_time : String?
	var astro_call_online_date : String?
	var astro_online_chat_time : String?
	var astro_online_chat_date : String?
	var astro_query_status : String?
	var astro_query_status_time : String?
	var astro_report_status : Int?
	var astro_report_status_time : String?
	var current_wallet_amt : Int?
	var astrologer_online_portal : String?
	var created_by : String?
	var created_at : String?
	var updated_by : String?
	var updated_at : String?
	var trash_by : String?
	var trash : Int?
	var call_price_Inr : String?
	var call_price_dollar : String?
	var chat_price_Inr : String?
	var chat_price_dollar : String?
	var discounted_call_price_Inr : Double?
	var discounted_call_price_dollar : Double?
	var discounted_chat_price_Inr : Int?
	var discounted_chat_price_dollar : Double?
	var city_name : String?
	var state_name : String?
	var category_title : String?
	var language_name : String?
	var rating : String?
	var user_fcm_token : String?
	var user_ios_token : String?
	var fcm_user_id : String?
	var fcm_fcm_key : String?
	var self_referal_code : String?
	var reviews : [Reviews]?
	var category_arr : [Category_arr]?
	var avrageRating : String?
	var call_busy_status : String?
	var chat_busy_status : String?
	var chat_notify_status : String?
	var call_notify_status : String?
	var astrologers_available_time : String?
	var package_inr_price : String?
	var package_dollar_price : String?
	var package_description : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		phone_number <- map["phone_number"]
		email <- map["email"]
		verify <- map["verify"]
		astrologers_id <- map["astrologers_id"]
		astrologers_uni_id <- map["astrologers_uni_id"]
		astrologers_slug <- map["astrologers_slug"]
		astrologers_online_portal <- map["astrologers_online_portal"]
		astrologers_name <- map["astrologers_name"]
		astrologers_dob <- map["astrologers_dob"]
		astrologers_gender <- map["astrologers_gender"]
		astrologers_alternative_phone <- map["astrologers_alternative_phone"]
		astrologers_address <- map["astrologers_address"]
		astrologers_city <- map["astrologers_city"]
		astrologers_state <- map["astrologers_state"]
		astrologers_pincode <- map["astrologers_pincode"]
		astrologers_image <- map["astrologers_image"]
		astrologers_image_url <- map["astrologers_image_url"]
		astrologers_id_proof <- map["astrologers_id_proof"]
		astrologers_long_biography <- map["astrologers_long_biography"]
		astrologers_short_biography <- map["astrologers_short_biography"]
		astrologers_experience <- map["astrologers_experience"]
		astrologers_tag <- map["astrologers_tag"]
		astrologers_pancard <- map["astrologers_pancard"]
		astrologers_skills <- map["astrologers_skills"]
		astrologers_language <- map["astrologers_language"]
		astrologers_category_list <- map["astrologers_category_list"]
		astrologers_status <- map["astrologers_status"]
		astrologers_fees <- map["astrologers_fees"]
		astrologers_position <- map["astrologers_position"]
		astrolozer_bank_name <- map["astrolozer_bank_name"]
		astrolozer_acc_no <- map["astrolozer_acc_no"]
		astrolozer_acc_type <- map["astrolozer_acc_type"]
		astrolozer_ifsc_code <- map["astrolozer_ifsc_code"]
		astrolozer_acc_name <- map["astrolozer_acc_name"]
		astro_call_status <- map["astro_call_status"]
		astro_chat_status <- map["astro_chat_status"]
		astro_call_online_time <- map["astro_call_online_time"]
		astro_call_online_date <- map["astro_call_online_date"]
		astro_online_chat_time <- map["astro_online_chat_time"]
		astro_online_chat_date <- map["astro_online_chat_date"]
		astro_query_status <- map["astro_query_status"]
		astro_query_status_time <- map["astro_query_status_time"]
		astro_report_status <- map["astro_report_status"]
		astro_report_status_time <- map["astro_report_status_time"]
		current_wallet_amt <- map["current_wallet_amt"]
		astrologer_online_portal <- map["astrologer_online_portal"]
		created_by <- map["created_by"]
		created_at <- map["created_at"]
		updated_by <- map["updated_by"]
		updated_at <- map["updated_at"]
		trash_by <- map["trash_by"]
		trash <- map["trash"]
		call_price_Inr <- map["call_price_Inr"]
		call_price_dollar <- map["call_price_dollar"]
		chat_price_Inr <- map["chat_price_Inr"]
		chat_price_dollar <- map["chat_price_dollar"]
		discounted_call_price_Inr <- map["discounted_call_price_Inr"]
		discounted_call_price_dollar <- map["discounted_call_price_dollar"]
		discounted_chat_price_Inr <- map["discounted_chat_price_Inr"]
		discounted_chat_price_dollar <- map["discounted_chat_price_dollar"]
		city_name <- map["city_name"]
		state_name <- map["state_name"]
		category_title <- map["category_title"]
		language_name <- map["language_name"]
		rating <- map["rating"]
		user_fcm_token <- map["user_fcm_token"]
		user_ios_token <- map["user_ios_token"]
		fcm_user_id <- map["fcm_user_id"]
        fcm_fcm_key <- map["fcm_fcm_key"]
		self_referal_code <- map["self_referal_code"]
		reviews <- map["reviews"]
		category_arr <- map["category_arr"]
		avrageRating <- map["avrageRating"]
		call_busy_status <- map["call_busy_status"]
		chat_busy_status <- map["chat_busy_status"]
		chat_notify_status <- map["chat_notify_status"]
		call_notify_status <- map["call_notify_status"]
		astrologers_available_time <- map["astrologers_available_time"]
		package_inr_price <- map["package_inr_price"]
		package_dollar_price <- map["package_dollar_price"]
		package_description <- map["package_description"]
	}

}
