package com.smanggin.trackingmanagement

class QCActions {

	def globalService

    String serverId
    String code
    String description

    String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated

	String toString() { return code }	

	static  hasMany = [qCHeaders:QCHeader]

	static	mapping = {
    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

        description type:'text'
    	version true
    }

    static constraints = {
        code unique: true,nullable:true
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
