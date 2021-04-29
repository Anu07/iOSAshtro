/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Reviews : Mappable {
	var review_id : String?
	var review_rating : String?
	var review_comment : String?
	var username : String?
	var email : String?
	var phone_number : String?
	var created_at : String?
	var customer_image_url : String?
	var customer_image : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		review_id <- map["review_id"]
		review_rating <- map["review_rating"]
		review_comment <- map["review_comment"]
		username <- map["username"]
		email <- map["email"]
		phone_number <- map["phone_number"]
		created_at <- map["created_at"]
		customer_image_url <- map["customer_image_url"]
		customer_image <- map["customer_image"]
	}

}