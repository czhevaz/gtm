package com.smanggin.trackingmanagement

class Gallon {

    String gallonCode
    Boolean writeOff

    static constraints = {
        gallonCode blank: false
        writeOff nullable: false
    }

}
