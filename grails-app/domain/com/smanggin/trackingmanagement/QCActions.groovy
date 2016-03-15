package com.smanggin.trackingmanagement

class QCActions {

	def globalService

    String serverId
    String description

    String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated

	

	static  hasMany = [qCHeaders:QCHeader]

	static	mapping = {
    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

        description type:'text'
    	version true
    }

    static constraints = {
        serverId unique: true, nullable: false
        description nullable: false
        updatedBy nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }
}
