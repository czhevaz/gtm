package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * QcAfkirController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class QcAfkirController {
    def globalService 
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        if(params.trType){
            session.trType = params.trType 
        }
        def results = QcAfkir.createCriteria().list(params){
            transactionGroup{
                eq('transactionType',params.trType)
            }
        }
        [qcAfkirInstanceList: results, qcAfkirInstanceTotal: results.totalCount]
    }

    def create() {
        
            params.trType = session.trType 
        
        println "session" +session.trType
        println params.trType
        def trGroupList =  globalService.trGroupList(session.defaultPlantId,session.trType)
        [qcAfkirInstance: new QcAfkir(params),trGroupList:trGroupList,params:params]
    }

    def save() {

        def qcAfkirInstance = new QcAfkir()
        qcAfkirInstance.properties = params
        qcAfkirInstance.createdBy= session.user
       
        qcAfkirInstance.plant = Plant.findByServerId(params.plant?.serverId)
        qcAfkirInstance.workCenter = WorkCenter.findByServerId(params?.workCenter?.serverId)
        qcAfkirInstance.transactionGroup =TransactionGroup.findByServerId(params?.transactionGroup?.serverId)
        qcAfkirInstance.item = Item.findByServerId(params?.item?.serverId)
        qcAfkirInstance.shift = Shift.findByServerId(params?.shift?.serverId)
        qcAfkirInstance.qCQuestions = QCQuestions.findByServerId(params.qCQuestions.serverId)


        if (!qcAfkirInstance.save(flush: true)) {
            render(view: "create", model: [qcAfkirInstance: qcAfkirInstance])
            return
        }

        println " Insert Value "
        
        if(qcAfkirInstance.qCQuestions.parameterType == 2){

            println " parameterType =  2"
            params."option_${qcAfkirInstance.qCQuestions.sequenceNo}".each{ option->
                def qcp = QCOptions.findByServerId(option)

                def qcDetailInstance = new QCDetail()
                qcDetailInstance.qcMaster = qcAfkirInstance.qCQuestions.qCMaster
                qcDetailInstance.qcQuestions = qcAfkirInstance.qCQuestions
                qcDetailInstance.qcOptions = qcp
                qcDetailInstance.results = qcp?.description
                qcDetailInstance.createdBy = session.user
                qcDetailInstance.reffDocClass = 'QcAfkir'
                qcDetailInstance.refDocId = qcAfkirInstance.serverId
                if(!qcDetailInstance.save(flush:true)){
                println "erorr" +qcDetailInstance.errors
                }
            }
    
        }else{

            println " parameterType !=2"
        
            def qcp = QCOptions.findByServerId(params."option_${qcAfkirInstance.qCQuestions.sequenceNo}")

            println "qcp "+qcp
            def qcDetailInstance  = new QCDetail()
            qcDetailInstance.qcMaster = qcAfkirInstance.qCQuestions.qCMaster
            qcDetailInstance.qcQuestions = qcAfkirInstance.qCQuestions
            qcDetailInstance.qcOptions = qcp
            qcDetailInstance.results = qcp?qcp?.description:params."option_${qcAfkirInstance.qCQuestions.sequenceNo}"
            qcDetailInstance.createdBy = session.user
            qcDetailInstance.reffDocClass = 'QcAfkir'
            qcDetailInstance.refDocId = qcAfkirInstance.serverId
            if(!qcDetailInstance .save(flush:true)){
                println "erorr" +qcDetailInstance.errors
            }
    
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), qcAfkirInstance.number])
        redirect(action: "show", params: ['serverId':qcAfkirInstance.serverId])
    }

    def show() {
        def qcAfkirInstance = QcAfkir.findByServerId(params.serverId)
        if (!qcAfkirInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), params.id])
            redirect(action: "list")
            return
        }


        def qcval = QCDetail.createCriteria().list(){
            eq('reffDocClass','QcAfkir')\
            eq('refDocId',qcAfkirInstance.serverId)
            eq('qcQuestions',qcAfkirInstance.qCQuestions)
        }

        def qcvalJoin = qcval.results.join(',')

        def yearList=globalService.yearList()
        def monthList=globalService.monthList()

        [qcAfkirInstance: qcAfkirInstance,qcvalJoin:qcvalJoin,yearList:yearList,monthList:monthList]
    }

    def edit() {
        def qcAfkirInstance = QcAfkir.findByServerId(params.serverId)

        if (!qcAfkirInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), params.id])
            redirect(action: "list")
            return
        }
        def trGroupList =  globalService.trGroupList(session.defaultPlantId,session.trType)
        [qcAfkirInstance: qcAfkirInstance,trGroupList:trGroupList]
    }

    def update() {
        def qcAfkirInstance = QcAfkir.findByServerId(params.serverId)
        if (!qcAfkirInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (qcAfkirInstance.version > version) {
                qcAfkirInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'qcAfkir.label', default: 'QcAfkir')] as Object[],
                          "Another user has updated this QcAfkir while you were editing")
                render(view: "edit", model: [qcAfkirInstance: qcAfkirInstance])
                return
            }
        }
        
        qcAfkirInstance.updatedBy= session.user
       
        qcAfkirInstance.plant = Plant.findByServerId(params.plant?.serverId)
        qcAfkirInstance.workCenter = WorkCenter.findByServerId(params?.workCenter?.serverId)
        qcAfkirInstance.transactionGroup =TransactionGroup.findByServerId(params?.transactionGroup?.serverId)
        qcAfkirInstance.item = Item.findByServerId(params?.item?.serverId)
        qcAfkirInstance.shift = Shift.findByServerId(params?.shift?.serverId)
        qcAfkirInstance.qCQuestions = QCQuestions.findByServerId(params.qCQuestions?.serverId)

        if (!qcAfkirInstance.save(flush: true)) {
            render(view: "edit", model: [qcAfkirInstance: qcAfkirInstance])
            return
        }
        
        //insert qc Detail 
        
        if(qcAfkirInstance.transactionGroup.transactionType == '4'){
            /* write off gallon*/
            println " <<<<<<< write Off >>>>>>> "    
            writeOff(qcAfkirInstance.qcAfkirDetails)

        }
		flash.message = message(code: 'default.updated.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), qcAfkirInstance.serverId])
        redirect(action: "edit", params:[serverId:qcAfkirInstance.serverId])
    }

    def delete() {
        def qcAfkirInstance = QcAfkir.get(params.id)
        if (!qcAfkirInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), params.id])
            redirect(action: "list")
            return
        }

        try {
            qcAfkirInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def qcAfkirInstance = (params.id) ? QcAfkir.get(params.id) : new QcAfkir()
        
        if (!qcAfkirInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (qcAfkirInstance.version > version) {
                    qcAfkirInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'qcAfkir.label', default: 'QcAfkir')] as Object[],
                              "Another user has updated this QcAfkir while you were editing")
                    render([success: false, messages: qcAfkirInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        qcAfkirInstance.properties = params
                       
        if (!qcAfkirInstance.save(flush: true)) {
            render([success: false, messages: qcAfkirInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = QcAfkir.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render QcAfkir.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def qcAfkirInstance = QcAfkir.get(id)
        if (!qcAfkirInstance)
            render([success: false] as JSON)
        else {
            try {
                qcAfkirInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def qcAfkirInstance = QcAfkir.get(params.id)
        if (!qcAfkirInstance) {
            render(
                message : "qcAfkir.not.found",
            ) as JSON

        }
        else {
            render([qcAfkirInstance : qcAfkirInstance ] as JSON)
        }
    }

    def writeOff(qcAfkirDetails){
        def res =true
        qcAfkirDetails.each{
          
            def item = Gallon.findByServerId(it.gallon?.serverId)
            println "gallon>>>>>>> " + item
            item.writeOff = 1
            item.updatedBy = session.user
            
            println " horasssss "


            if(!item.save(flush:true)){
                println "save Gallon errors " +  it.gallon.errors
                res = false
            }
            
        }
        return res
    }

    def report(){
        def view = params.report        
        if(params.report){
            render(view: "${view}")
        }
    }
    
    def rejectedAnalysis(){
        def startDate = globalService.correctDateTime(params.startDate)
        def endDate = globalService.correctDateTime(params.endDate)
        def filterDate = globalService.filterDate(startDate, endDate)
        def process = Process.findByServerId(params.processServerId)
        def plant = Plant.findByServerId(params.plantServerId)
        
        def line = Line.createCriteria().list(){
            le('serverId','${params.line2}')
            ge('serverId','${params.line}')
        }

        def qcAfkirQuestions = QcAfkir.createCriteria().listDistinct(){
            eq('plant',plant)
            projections {
                groupProperty("qCQuestions")
            }
        }

    
        def line1 = Line.findByServerId(params.line1ServerId)
        def listLine = []

        def mapLine=[:]
        mapLine.put('lineName','Line 1')
        def listQuestion = []
        def listValQs=[]
        
        def workCenter = WorkCenter.createCriteria().list(){
            eq('line',line1)    
            eq('plant',plant)
       
        }

        qcAfkirQuestions.each{question ->
            def mapQuestion=[:]
            mapQuestion.put('questionName',question.parameterDesc)
            def qcOptions = QCOptions.findAllByQCQuestions(question)
            def lisOption=[]
            
            qcOptions.each{ option->
                def mapOption=[:]
                mapOption.put('optionName',option?.description)
                mapOption.put('optionId',option?.serverId)
                def qcDetails=countTotalItem(workCenter,option,filterDate,question)
                listValQs.push(qcDetails)
                lisOption.push(mapOption)
            }

            if(lisOption.size() == 0){
                def qcDetails=countTotalItem(workCenter,null,filterDate,question) 
                listValQs.push(qcDetails)
            }
            mapQuestion.put('lisOption',lisOption) 

            listQuestion.push(mapQuestion)
        }
        
        mapLine.put('listQuestion',listQuestion)
        mapLine.put('listValQs',listValQs)
        listLine.push(mapLine)
        
        render([success:true ,results:listLine] as JSON)            
    }    

    def countTotalItem(workCenter,qcOptions,filterDate,qcQuestion){
        
        def qcDetails = QCDetail.createCriteria().list(){       
            eq('qcQuestions',qcQuestion)
            if(qcOptions){
                eq('qcOptions',qcOptions)    
            }else{
                isNull('qcOptions')   
            }     
            
        }

        def listAfkir=[]
        qcDetails.each{
            if(it.reffDocClass == 'QcAfkir'){
                def refDocId = it.refDocId
               // println "refDocId " +it.refDocId
                def qcAfkirs = QcAfkir.createCriteria().list(){
                    eq('serverId',refDocId)  
                }    
                if(qcAfkirs){
                    listAfkir.push(qcAfkirs[0])    
                }
                
            }
        }
        
        
        def count=0
        if(listAfkir.size() > 0){

            def qcAfkirDetails = QcAfkirDetail.createCriteria().list(){
            'in'('qcAfkir',listAfkir)
            }
            println "listAfkir true" +listAfkir
            count = qcAfkirDetails.size() 
        }
        
        return count
        
    }

    def actionWriteOff(){
        def qcAfkirInstance = QcAfkir.findByServerId(params.serverId)
        if (!qcAfkirInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (qcAfkirInstance.version > version) {
                qcAfkirInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'qcAfkir.label', default: 'QcAfkir')] as Object[],
                          "Another user has updated this QcAfkir while you were editing")
                render(view: "edit", model: [qcAfkirInstance: qcAfkirInstance])
                return
            }
        }
        
        qcAfkirInstance.updatedBy= session.user
       
        if (!qcAfkirInstance.save(flush: true)) {
            render(view: "edit", model: [qcAfkirInstance: qcAfkirInstance])
            return
        }
        
        //insert qc Detail 
        
        if(qcAfkirInstance.transactionGroup.transactionType == '4'){
            /* write off gallon*/
            println " <<<<<<< write Off >>>>>>> "    
            writeOff(qcAfkirInstance.qcAfkirDetails)

        }
        flash.message = message(code: 'default.updated.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), qcAfkirInstance.serverId])
        redirect(action: "create", params:[serverId:qcAfkirInstance.serverId])

    }

    def reportWriteOff(){
        def startDate = globalService.correctDateTime(params.startDate)
        def endDate = globalService.correctDateTime(params.endDate)       
        
        def qcWriteOff = QcAfkir.createCriteria().list(){
            transactionGroup{
                eq('transactionType','4')    
            }            
        } 

        def gallon = QcAfkirDetail.createCriteria().list(){
            'in'('qcAfkir',qcWriteOff)
            
        }


        render([success:true ,results:qcWriteOff] as JSON)            
    }
}
