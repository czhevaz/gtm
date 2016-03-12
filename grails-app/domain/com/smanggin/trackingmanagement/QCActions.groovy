package com.smanggin.trackingmanagement

class QCActions {

    String actionID
    String description

    static constraints = {
        actionID unique: true, nullable: false
        description nullable: false
    }
}
