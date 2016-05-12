package com.smanggin.trackingmanagement

class LineBalance {

	def globalService

	String serverId
	Plant plant
	Line line
	Date date
	Float beginQty
	Float inQty
	Float outQty
	Float endQty

	String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated

	Shift shift
	String triggerId
	String triggerClass
	Item item

	static	belongsTo	= [ Plant, Line, Shift]

	static	mapping = {
    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

    	version false
    }

    static constraints = {
    	updatedBy nullable:true
    	shift nullable:true
    	triggerId nullable:true
    	triggerClass nullable:true
    	item nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }
}
