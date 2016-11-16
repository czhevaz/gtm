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
        if(defaultPlantId){
          plant{
            eq('serverId',defaultPlantId)
          }
        }
        
        eq('transactionType',trType)
      }

      return trGroup
    }

    def monthList(){
        def month = [1,2,3,4,5,6,7,8,9,10,11,12]
        return month
    }    

    def yearList(){
       Calendar cal = Calendar.getInstance();
       cal.setTime(new Date());
       int year = cal.get(Calendar.YEAR)
      
        def z = 0
        def list=[]
        while (z < 5) {
            list.push(year)
            z++
            year--
        }
        println list
        return list
          
    }

    def deleteAutomatis(){
      println "delete() "
      def date = new Date()
      def findDeleted = ProductionInDetail.createCriteria().list(){
        eq('isChecked',false)
        projections{
          groupProperty('number')
        }
      }

      println "findDeleted" +findDeleted

      findDeleted.each{ detail ->

        println " detail "+detail
        def findNumber = ProductionInDetail.createCriteria().list(){
          eq('number',detail)
          eq('isChecked',false)
        }
        println "findNumber" +findNumber
        if(findNumber.size() > 1){  
          def i=0
          println i
          
          findNumber.each{no ->
            if(i==0){
              no.isChecked = true
              no.save(flush:true)
              println " update number "
            }else{
              println " delete number"
              no.delete(flush:true)
            }

            i++
          }
        }else{
          findNumber.each{no ->
              no.isChecked = true
              no.save(flush:true)
              println " update number "
          }
        }
      }
    }
}
