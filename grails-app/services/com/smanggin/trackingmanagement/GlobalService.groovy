package com.smanggin.trackingmanagement
 import java.util.UUID
import java.text.*
/**
 * GlobalService
 * A service class encapsulates the core business logic of a Grails application
 */
class GlobalService {

    def grailsApplication
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

    def filterDate(startDate,endDate){
        def vd= []
        Calendar cal = Calendar.getInstance();
           cal.setTime(startDate);
           cal.set(Calendar.HOUR_OF_DAY, 0);
           cal.set(Calendar.MINUTE, 0);
           cal.set(Calendar.SECOND, 0);
           Date start = cal.getTime();

        Calendar calx = Calendar.getInstance();
           calx.setTime(endDate);
           calx.set(Calendar.HOUR_OF_DAY, 23);
           calx.set(Calendar.MINUTE, 59);
           calx.set(Calendar.SECOND, 59);
           Date end = calx.getTime();

        return [start:start,end:end] 
    }

    static correctDateTime(String input){
    	DateFormat df = new SimpleDateFormat( 'yyyy-MM-dd HH:mm:ss' )
        Date d = df.parse(input)
        return d
    }

    def findByDomainClass(triggerClass,triggerId){
      def domainClassName = "com.smanggin.trackingmanagement."+triggerClass
      println domainClassName
      def domainClassInstance = grailsApplication.getDomainClass(domainClassName).clazz
      def domain = domainClassInstance.findByServerId(triggerId)
      return domain
      
    }
    
    /* filter TrGroup By plant */
    def trGroupList(defaultPlantId,trType){

      def trGroup = TransactionGroup.createCriteria().list(){
        plant{
          eq('serverId',defaultPlantId)
        }
        eq('transactionType',trType)
      }

      return trGroup
    }    
}
