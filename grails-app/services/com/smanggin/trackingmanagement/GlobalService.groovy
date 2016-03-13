package com.smanggin.trackingmanagement
 import java.util.UUID

/**
 * GlobalService
 * A service class encapsulates the core business logic of a Grails application
 */
class GlobalService {

    static transactional = true

    /* gereate unique id for server ID*/
    def UUIDGenerator(){

    	return UUID.randomUUID().toString();	
    }
    
    
}
