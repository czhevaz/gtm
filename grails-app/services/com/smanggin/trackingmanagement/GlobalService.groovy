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


    def valueQCDetail(qcHeader,qcMaster,qcQuestions){
    	def qcdetail = QCDetail.createCriteria().list(){
    		eq('qcHeader',qcHeader)
    		eq('qcMaster',qcMaster)
    		eq('qcQuestions',qcQuestions)
    	}

    	return qcdetail[0]?.results

    }

    def valueQCDetail2(qcHeader,qcMaster,qcQuestions){
    	def qcdetail = QCDetail.createCriteria().list(){
    		eq('qcHeader',qcHeader)
    		eq('qcMaster',qcMaster)
    		eq('qcQuestions',qcQuestions)
    	}

    	return qcdetail?.results

    }


    def qcOptionsBy(question){
    	def qcOptions = QCOptions.createCriteria().list(){
    		eq('qCQuestions',question)
    	} 

    	return qcOptions
    }
    
    
}
