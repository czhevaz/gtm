package com.smanggin.trackingmanagement

/**
 * Item
 * A domain class describes the data object and it's mapping to the database
 */
class Item {

	def globalService 
	/* Automatic timestamping of GORM */
	Date	dateCreated
	Date	lastUpdated

	String serverId
	String name
	String description
	
	String toString() { return name } 	
//	static	belongsTo	= []	// tells GORM to cascade commands: e.g., delete this object if the "parent" is deleted.
//	static	hasOne		= []	// tells GORM to associate another domain object as an owner in a 1-1 mapping
	static	hasMany		= [gallons:Gallon]	// tells GORM to associate other domain objects for a 1-n or n-m mapping
//	static	mappedBy	= []	// specifies which property should be used in a mapping 
	
    static	mapping = {
    	 id name : 'serverId',
            type: 'string',
            generator: 'assigned'

    }
    
	static	constraints = {

    }
	
	def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }
}
