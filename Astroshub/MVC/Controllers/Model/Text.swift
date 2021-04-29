/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Text : Mappable {
	var asked_query_uniqueid : String?
	var asked_query_name : String?
	var asked_query_contact_no : String?
	var asked_query_email : String?
	var asked_query_dob : String?
	var asked_query_time_of_birth : String?
	var asked_query_place : String?
	var asked_query_message : String?
	var asked_query_download : String?
	var status : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		asked_query_uniqueid <- map["asked_query_uniqueid"]
		asked_query_name <- map["asked_query_name"]
		asked_query_contact_no <- map["asked_query_contact_no"]
		asked_query_email <- map["asked_query_email"]
		asked_query_dob <- map["asked_query_dob"]
		asked_query_time_of_birth <- map["asked_query_time_of_birth"]
		asked_query_place <- map["asked_query_place"]
		asked_query_message <- map["asked_query_message"]
		asked_query_download <- map["asked_query_download"]
		status <- map["status"]
	}

}