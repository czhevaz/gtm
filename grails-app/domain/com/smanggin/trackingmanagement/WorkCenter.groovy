package com.smanggin.trackingmanagement

class WorkCenter {

	def globalService

	String serverId
    String name
    Plant plant
    Line line
    Process process
    Number sequenceNo

    String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated

	static	belongsTo	= [ Process, Plant, Line]

	static  hasMany = [qCHeaders:QCHeader]

	static	mapping = {
    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

    	version true
    }

    static constraints = {
        name blank: false
        updatedBy nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }
}
