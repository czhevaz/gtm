package com.smanggin.trackingmanagement

class Line {

    String lineID
    String lineCode
    String lineName

    static constraints = {
        lineID blank: false
        lineCode blank: false, unique: true, nullable: false
        lineName blank: false, nullable: false
    }
}
