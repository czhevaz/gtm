package com.smanggin.trackingmanagement

/**
 * CreateNewItemService
 * A service class encapsulates the core business logic of a Grails application
 */
class CreateNewItemService {

    static transactional = true

    def serviceMethod() {
    	def productionIn = ProductionInDetail.createCriteria().list(){
    		isNull('gallon')
    	}

    }
}
