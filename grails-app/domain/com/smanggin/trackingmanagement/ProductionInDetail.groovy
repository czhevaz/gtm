package com.smanggin.trackingmanagement

class ProductionInDetail {

	def globalService
	
	String serverId
	ProductionInHeader productionInHeader
	Gallon gallon

	String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated

	static	belongsTo	= [ ProductionInHeader, Gallon]

	static	mapping = {
    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

    	version true
    }

    static constraints = {
    	updatedBy nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }
}
