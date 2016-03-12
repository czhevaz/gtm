package com.smanggin.trackingmanagement

class QCMaster {

    String qcID
    String qcCode
    String qcName
    Boolean active
    Date dateInActive
    String user

    static constraints = {
        qcID blank: false
        qcCode blank: false, unique: true, nullable: false
        qcName blank: false, nullable: false
        active
        dateInActive
        user blank: true
    }
}
