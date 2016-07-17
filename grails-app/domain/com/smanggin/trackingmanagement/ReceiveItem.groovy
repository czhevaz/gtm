package com.smanggin.trackingmanagement

/**
 * ReceiveItem
 * A domain class describes the data object and it's mapping to the database
 */
class ReceiveItem {

	
	/* Automatic timestamping of GORM */
	def globalService 

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

	Long startNumber // not used
	Long endNumber // not used

	String createdBy
	String updatedBy
	String reffNo
	String remarks

	String toString() { return number } 
	
	static transients =['totalItemScan']

	static	belongsTo	= [Supplier, TransactionGroup]	// tells GORM to cascade commands: e.g., delete this object if the "parent" is deleted.
//	static	hasOne		= []	// tells GORM to associate another domain object as an owner in a 1-1 mapping
	static	hasMany		= [gallons:Gallon]	// tells GORM to associate other domain objects for a 1-n or n-m mapping
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

		reffNo nullable:true
		remarks nullable:true

		startNumber nullable:true
		endNumber nullable:true

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

	/*def getTotalItemScan(){
		def gallons = Gallon.findAllByReceiveItem(this) 
		return gallons.count()
	}*/
}
