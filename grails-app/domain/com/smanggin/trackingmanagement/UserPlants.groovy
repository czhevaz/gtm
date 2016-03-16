package com.smanggin.trackingmanagement

class UserPlants {

	def globalService

	String serverId
	User user 
	Plant plant
	Boolean isDefault

	String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated

	static	belongsTo	= [ Plant, User]

	static	mapping = {
    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

       

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
