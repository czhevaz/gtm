package com.smanggin.trackingmanagement

class ProcessQC {

    Number sequenceNo
    Date date1
    Date date2

    static constraints = {
        sequenceNo nullable: true
        date1 nullable: true
        date2 nullable: true
    }
}
