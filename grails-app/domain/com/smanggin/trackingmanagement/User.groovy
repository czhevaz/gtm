package com.smanggin.trackingmanagement

class User {

    String userID
    String password
    String email
    String mobileNo1
    String mobileNo2

    static constraints = {
        userID blank: false, unique: true
        password size: 5..15, blank: false
        email email: true, blank: false
        mobileNo1 blank: true
        mobileNo2 blank: true
    }

    static mapping = {
        table('user_account')
    }
}
