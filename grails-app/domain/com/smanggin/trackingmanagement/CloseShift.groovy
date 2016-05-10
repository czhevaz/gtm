package com.smanggin.trackingmanagement

/**
 * CloseShift
 * A domain class describes the data object and it's mapping to the database
 */
class CloseShift {
	def globalService 
	/* Default (injected) attributes of GORM */

/* Automatic timestamping of GORM */
	Date	dateCreated
	Date	lastUpdated

	String serverId
	Date closeDate
	Plant plant
	Shift shift
	Line  line
	Float yieldBySystem
	Float yieldByUser

	static	belongsTo	= [Shift,Line]	// tells GORM to cascade commands: e.g., delete this object if the "parent" is deleted.
//	static	hasOne		= []	// tells GORM to associate another domain object as an owner in a 1-1 mapping
//	static	hasMany		= []	// tells GORM to associate other domain objects for a 1-n or n-m mapping
//	static	mappedBy	= []	// specifies which property should be used in a mapping 
	
    static	mapping = {
    	 id name : 'serverId',
            type: 'string',
            generator: 'assigned'

    }
    
	static	constraints = {
		plant nullable:true
    }
	
	def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }
}
