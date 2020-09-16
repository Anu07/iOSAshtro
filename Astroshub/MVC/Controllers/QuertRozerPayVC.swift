////
////  QuertRozerPayVC.swift
////  Astroshub
////
////  Created by Kriscent on 11/03/20.
////  Copyright © 2020 Bhunesh Kahar. All rights reserved.
////
//
//import UIKit
//import Razorpay
//private var KEY_ID = "rzp_test_pDqqc1wovvXUCn" // @"rzp_test_1DP5mmOlF5G5ag";
//private let SUCCESS_TITLE = "Yay!"
//private let SUCCESS_MESSAGE = "Your payment was successful. The payment ID is %@"
//private let FAILURE_TITLE = "Uh-Oh!"
//private let FAILURE_MESSAGE = "Your payment failed due to an error.\nCode: %d\nDescription: %@"
//private let EXTERNAL_METHOD_TITLE = "Umm?"
//private let EXTERNAL_METHOD_MESSAGE = """
//    You selected %@, which is not supported by Razorpay at the moment.\nDo \
//    you want to handle it separately?
//    """
//private let OK_BUTTON_TITLE = "OK"
//class QuertRozerPayVC: UIViewController {
//
//    func onPaymentError(_ code: Int32, description str: String)
//    {
//        let alertController = UIAlertController(title: "FAILURE", message: str, preferredStyle: UIAlertController.Style.alert)
//
//        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
//
//        alertController.addAction(cancelAction)
//
//          // self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
//    }
////    var razorpay: Razorpay? = nil
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//              let abcccc1 = Float(100.00)
//              let abcccc = Float(FormQueryPrice)
//
//               let abcccc2 = abcccc * abcccc1
//
//               let options: [String:Any] = [
//                   "amount" : abcccc2,
//                   "description": "Purchase Description",
//                   "image": "http://kriscenttechnohub.com/demo/astroshubh/admin/assets/images/astroshubh_full-log.png",
//                   "name": setCustomername,
//                   "prefill": [
//                   "contact": setCustomerphone,
//                   "email": setCustomeremail
//                   ],
//                   "theme": [
//                       "color": "#FF7B18"
//                   ]
//               ]
//              // razorpay?.open(options)
////               razorpay?.open(options, display: self)
//
//
//        // Do any additional setup after loading the view.
//    }
//    func onPaymentSuccess(_ payment_id: String)
//    {
//       // self.func_rechargeamount()
//        showAlert(withTitle: SUCCESS_TITLE, andMessage: String(format: SUCCESS_MESSAGE, payment_id ))
//    }
//
//    func onPaymentError(_ code: Int, description str: String?) {
//        showAlert(withTitle: FAILURE_TITLE, andMessage: String(format: FAILURE_MESSAGE, code, str ?? ""))
//    }
//
//    func onExternalWalletSelected(_ walletName: String, withPaymentData paymentData: [AnyHashable : Any]?) {
//        showAlert(withTitle: EXTERNAL_METHOD_TITLE, andMessage: String(format: EXTERNAL_METHOD_MESSAGE, walletName ))
//    }
//
//    func showAlert(withTitle title: String?, andMessage message: String?) {
//        if UIDevice.current.systemVersion.compare("8.0", options: .numeric, range: nil, locale: .current) != .orderedAscending {
//            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//            let cancelAction = UIAlertAction(title: OK_BUTTON_TITLE, style: .cancel, handler: nil)
//    //
//    //  The converted code is limited to 1 KB.
//    //  Please Sign Up (Free!) to double this limit.
//    //
//    //  %< ----------------------------------------------------------------------------------------- %<
//
//        }
//    }
//    @IBAction func btn_backAction(_ sender: Any)
//    {
//        self.navigationController?.popViewController(animated: true)
//    }
//
//
//}


import UIKit
import Razorpay

private var KEY_ID = "rzp_test_pDqqc1wovvXUCn" // @"rzp_test_1DP5mmOlF5G5ag";
private let SUCCESS_TITLE = "Yay!"
private let SUCCESS_MESSAGE = "Your payment was successful. The payment ID is %@"
private let FAILURE_TITLE = "Uh-Oh!"
private let FAILURE_MESSAGE = "Your payment failed due to an error.\nCode: %d\nDescription: %@"
private let EXTERNAL_METHOD_TITLE = "Umm?"
private let EXTERNAL_METHOD_MESSAGE = """
    You selected %@, which is not supported by Razorpay at the moment.\nDo \
    you want to handle it separately?
    """
private let OK_BUTTON_TITLE = "OK"
class QuertRozerPayVC: UIViewController {

    func onPaymentError(_ code: Int32, description str: String)
    {
        let alertController = UIAlertController(title: "FAILURE", message: str, preferredStyle: UIAlertController.Style.alert)

        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)

        alertController.addAction(cancelAction)

          // self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
   // var razorpay: Razorpay? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

              let abcccc1 = Float(100.00)
              let abcccc = Float(FormQueryPrice)

               let abcccc2 = abcccc * abcccc1

               let options: [String:Any] = [
                   "amount" : abcccc2,
                   "description": "Purchase Description",
                   "image": "http://kriscenttechnohub.com/demo/astroshubh/admin/assets/images/astroshubh_full-log.png",
                   "name": setCustomername,
                   "prefill": [
                   "contact": setCustomerphone,
                   "email": setCustomeremail
                   ],
                   "theme": [
                       "color": "#FF7B18"
                   ]
               ]
              // razorpay?.open(options)
            //   razorpay?.open(options, display: self)


        // Do any additional setup after loading the view.
    }
    func onPaymentSuccess(_ payment_id: String)
    {
       // self.func_rechargeamount()
        showAlert(withTitle: SUCCESS_TITLE, andMessage: String(format: SUCCESS_MESSAGE, payment_id ))
    }

    func onPaymentError(_ code: Int, description str: String?) {
        showAlert(withTitle: FAILURE_TITLE, andMessage: String(format: FAILURE_MESSAGE, code, str ?? ""))
    }

    func onExternalWalletSelected(_ walletName: String, withPaymentData paymentData: [AnyHashable : Any]?) {
        showAlert(withTitle: EXTERNAL_METHOD_TITLE, andMessage: String(format: EXTERNAL_METHOD_MESSAGE, walletName ))
    }

    func showAlert(withTitle title: String?, andMessage message: String?) {
        if UIDevice.current.systemVersion.compare("8.0", options: .numeric, range: nil, locale: .current) != .orderedAscending {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: OK_BUTTON_TITLE, style: .cancel, handler: nil)
    //
    //  The converted code is limited to 1 KB.
    //  Please Sign Up (Free!) to double this limit.
    //
    //  %< ----------------------------------------------------------------------------------------- %<

        }
    }
    @IBAction func btn_backAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }


}

