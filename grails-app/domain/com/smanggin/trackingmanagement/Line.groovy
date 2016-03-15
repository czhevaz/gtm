package com.smanggin.trackingmanagement

class Line {

	def globalService

    String serverId
    String code
    String name

   	Plant plant

    String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated

	String toString() { return name }

	static	belongsTo	= [Plant]

	static  hasMany = [lineBalances:LineBalance, workCenters:WorkCenter]

	static	mapping = {
    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

    	version true
    }


    static constraints = {
        serverId blank: false
        code blank: false, unique: true, nullable: false
        name blank: false, nullable: false
        plant nullable: true
        updatedBy nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }
}
