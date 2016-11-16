package com.smanggin.trackingmanagement



class DeletedDuplicateNumberJob {
    static triggers = {
      simple repeatInterval: 360000l // execute job once in 5 seconds
    }

    def globalService
    def execute() {
        globalService.deleteAutomatis()
        println "XXXXXXXXXXXXXXXXXXXXXX START DELETED DUPLICATE XXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    }
}
