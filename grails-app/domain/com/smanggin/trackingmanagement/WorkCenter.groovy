package com.smanggin.trackingmanagement

class WorkCenter {

	def globalService

	String serverId
    String name
    Plant plant
    Line line
    Process process
    Long sequenceNo

    String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated

	String toString() { return name }

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
        plant nullable:true
        line nullable:true
        process nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }
}
