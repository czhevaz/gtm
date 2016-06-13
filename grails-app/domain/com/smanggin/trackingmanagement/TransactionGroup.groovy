package com.smanggin.trackingmanagement

class TransactionGroup {

	def globalService

	String serverId
	String name
	String transactionType /* 0 == production in & 1 == QC & 2== production out & 3 == receiving & 4 == afkir*/
	String prefix
	String numberingMethod
	Integer width
	Plant plant

	String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated

	String toString() { return name }

	static	belongsTo	= [Plant]	// tells GORM to cascade commands: e.g., delete this object if the "parent" is deleted.
	static  hasMany = [productionInHeaders:ProductionInHeader, qCHeaders:QCHeader]

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
