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
        def results = QcAfkir.createCriteria().list(params){}
        [qcAfkirInstanceList: results, qcAfkirInstanceTotal: results.totalCount]
    }

    def create() {
        def trGroupList =  globalService.trGroupList(session.defaultPlantId,session.trType)
        [qcAfkirInstance: new QcAfkir(params),trGroupList:trGroupList]
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

        println qcvalJoin
        [qcAfkirInstance: qcAfkirInstance,qcvalJoin:qcvalJoin]
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
}
