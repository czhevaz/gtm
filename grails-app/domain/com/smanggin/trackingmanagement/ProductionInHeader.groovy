package com.smanggin.trackingmanagement

class ProductionInHeader {

	def globalService

	String serverId
	String number
	Plant  plant
	TransactionGroup transactionGroup
	Date date
	Float totalGallon

	String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated

	String toString() { return number }

	static	belongsTo	= [ Plant, TransactionGroup]

	static  hasMany = [productionInDetails:ProductionInDetail]

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
