package com.smanggin.trackingmanagement
import org.joda.time.contrib.hibernate.PersistentLocalTimeAsTime
import org.joda.time.LocalTime
/**
 * Shift
 * A domain class describes the data object and it's mapping to the database
 */
class Shift {

	def globalService 

	Date	dateCreated
	Date	lastUpdated

	String name
	String description
	LocalTime   startDate
	LocalTime   endDate

	String serverId
	Plant plant

	String toString() { return name } 	
	
	static	belongsTo	= [Plant]	// tells GORM to cascade commands: e.g., delete this object if the "parent" is deleted.
//	static	hasOne		= []	// tells GORM to associate another domain object as an owner in a 1-1 mapping
//	static	hasMany		= []	// tells GORM to associate other domain objects for a 1-n or n-m mapping
//	static	mappedBy	= []	// specifies which property should be used in a mapping 
	
    static	mapping = {
    	version false
    	id name : 'serverId',
            type: 'string',
            generator: 'assigned'
        startDate type: PersistentLocalTimeAsTime
        endDate type: PersistentLocalTimeAsTime
    }
    
	static	constraints = {
    }
	
	def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }

    // business logic would belong to a service class
    LocalTime plusMinutes(int minutes) {
        localTime.plusMinutes(minutes)
    }

    LocalTime plusHours(int minutes) {
        localTime.plusHours(minutes)
    }

}


