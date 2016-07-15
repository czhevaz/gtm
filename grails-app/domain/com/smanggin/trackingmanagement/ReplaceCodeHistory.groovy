package com.smanggin.trackingmanagement

/**
 * ReplaceCodeHistory
 * A domain class describes the data object and it's mapping to the database
 */
class ReplaceCodeHistory {

	/* Default (injected) attributes of GORM */
	def globalService

	String serverId

	Date	dateCreated
	Date	lastUpdated
	String 	createdBy
	String 	updatedBy

	String oldNumber
	String newNumber
	String reason
	Gallon gallon
	Plant plant
	Item item
	
	static	belongsTo	= [Gallon]	// tells GORM to cascade commands: e.g., delete this object if the "parent" is deleted.
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
		gallon nullable:true		
		plant nullable:true
		updatedBy nullable:true
		item nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }
	
}
