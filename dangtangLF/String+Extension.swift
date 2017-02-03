
// String 扩展

import Foundation

public extension String {
    //判断手机号是否合法
    static func isValidmobile(string: String) -> Bool{
        //判断是否是手机号
        let patternString = "^1[3|4|5|8][0-9]\\d{8}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", patternString)
        return predicate.evaluateWithObject(string)
    }
    
    //判断密码是否合法
    static func isValuePassword(string: String) -> Bool{
        //验证密码 6-16 为字母或数字
        let patterString = "^[0-9A-Za-z]{6,16}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", patterString)
        return predicate.evaluateWithObject(string)
    }
}