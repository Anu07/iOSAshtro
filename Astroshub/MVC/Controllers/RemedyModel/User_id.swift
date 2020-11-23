/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct User_id : Mappable {
	var remedy_uniqueid : String?
	var remedy_name : String?
	var remedy_contact_no : String?
	var remedy_email : String?
	var remedy_dob : String?
	var remedy_time_of_birth : String?
	var remedy_place : String?
	var remedy_message : String?
	var asked_redemy_download : String?
	var status : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		remedy_uniqueid <- map["remedy_uniqueid"]
		remedy_name <- map["remedy_name"]
		remedy_contact_no <- map["remedy_contact_no"]
		remedy_email <- map["remedy_email"]
		remedy_dob <- map["remedy_dob"]
		remedy_time_of_birth <- map["remedy_time_of_birth"]
		remedy_place <- map["remedy_place"]
		remedy_message <- map["remedy_message"]
		asked_redemy_download <- map["asked_redemy_download"]
		status <- map["status"]
	}

}