package com.smanggin.trackingmanagement

class Plant {

    String plantID
    String plantCode
    String plantName
    String plantAddress
    String plantCity
    String plantPostalCode
    String plantCountry
    String plantPhone1
    String plantPhone2
    String plantEmail

    static constraints = {
        plantID blank: false
        plantCode blank: false, nullable: false, unique: true
        plantName blank: false, nullable: false
        plantAddress blank: true
        plantCity blank: true
        plantPostalCode blank: true
        plantCountry blank: true
        plantPhone1 blank: true
        plantPhone2 blank: true
        plantEmail blank: true, email: true
    }
}
