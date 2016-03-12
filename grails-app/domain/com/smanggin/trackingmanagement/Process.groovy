package com.smanggin.trackingmanagement

class Process {

    String processID
    String processCode
    String processName

    static constraints = {
        processID blank: false
        processCode blank: false, unique: true, nullable: false
        processName blank: false, nullable: false
    }
}
