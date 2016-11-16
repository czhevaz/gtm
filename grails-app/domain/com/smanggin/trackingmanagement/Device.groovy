package com.smanggin.trackingmanagement

/**
 * Device
 * A domain class describes the data object and it's mapping to the database
 */
class Device {

	def globalService
	
	String serverId
	String ipAddress
	Line line
	Plant plant
	Item item
	TransactionGroup transactionGroup
	Boolean status // 0 = not connect server ,1 = connect server
	Boolean active // 0 = not active , 1 = active

	/* Default (injected) attributes of GORM */
//	Long	id
//	Long	version
	
	/* Automatic timestamping of GORM */
//	Date	dateCreated
//	Date	lastUpdated
	
	static	belongsTo	= [Line,Plant]	// tells GORM to cascade commands: e.g., delete this object if the "parent" is deleted.
//	static	hasOne		= []	// tells GORM to associate another domain object as an owner in a 1-1 mapping
//	static	hasMany		= []	// tells GORM to associate other domain objects for a 1-n or n-m mapping
//	static	mappedBy	= []	// specifies which property should be used in a mapping 
	
    static	mapping = {
    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

    	version true
    }
    
	static	constraints = {
		transactionGroup nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }
	
	/*
	 * Methods of the Domain Class
	 */
//	@Override	// Override toString for a nicer / more descriptive UI 
//	public String toString() {
//		return "${name}";
//	}
}
