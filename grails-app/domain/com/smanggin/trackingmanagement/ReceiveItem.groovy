package com.smanggin.trackingmanagement

/**
 * ReceiveItem
 * A domain class describes the data object and it's mapping to the database
 */
class ReceiveItem {

	
	/* Automatic timestamping of GORM */
	def globalService 

	Plant plant
	String number
	Date receivedDate
	TransactionGroup transactionGroup

	Date	dateCreated
	Date	lastUpdated

	String serverId
	Supplier supplier

	Item item

	Long shift
	Date productionDate
	Long productionLine
	String groupShift

	Long startNumber
	Long endNumber

	String createdBy
	String updatedBy
	
	static	belongsTo	= [Supplier, TransactionGroup]	// tells GORM to cascade commands: e.g., delete this object if the "parent" is deleted.
//	static	hasOne		= []	// tells GORM to associate another domain object as an owner in a 1-1 mapping
	static	hasMany		= []	// tells GORM to associate other domain objects for a 1-n or n-m mapping
//	static	mappedBy	= []	// specifies which property should be used in a mapping 
	
    static	mapping = {
    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

    	version true
    }
    
	static	constraints = {
		updatedBy nullable:true
		item nullable:true
		number nullable:true
		transactionGroup nullable:true
		plant nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }
	
	def beforeInsert() {
		Integer count = ReceiveItem.countByTransactionGroup(transactionGroup)+1
		Integer width = transactionGroup.width
		String  prefix = transactionGroup.prefix

		String c = sprintf("%0${width}d",count)
		Date now = new Date()
		number = prefix+'/'+now.format(transactionGroup.numberingMethod)+'/'+c
	}
}
