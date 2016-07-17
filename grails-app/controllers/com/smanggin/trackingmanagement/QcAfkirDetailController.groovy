package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * QcAfkirDetailController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class QcAfkirDetailController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = QcAfkirDetail.createCriteria().list(params){}
        [qcAfkirDetailInstanceList: results, qcAfkirDetailInstanceTotal: results.totalCount]
    }

    def create() {
        [qcAfkirDetailInstance: new QcAfkirDetail(params)]
    }

    def save() {
        def qcAfkirDetailInstance = new QcAfkirDetail(params)
        if (!qcAfkirDetailInstance.save(flush: true)) {
            render(view: "create", model: [qcAfkirDetailInstance: qcAfkirDetailInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'qcAfkirDetail.label', default: 'QcAfkirDetail'), qcAfkirDetailInstance.id])
        redirect(action: "show", id: qcAfkirDetailInstance.id)
    }

    def show() {
        def qcAfkirDetailInstance = QcAfkirDetail.get(params.id)
        if (!qcAfkirDetailInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'qcAfkirDetail.label', default: 'QcAfkirDetail'), params.id])
            redirect(action: "list")
            return
        }

        [qcAfkirDetailInstance: qcAfkirDetailInstance]
    }

    def edit() {
        def qcAfkirDetailInstance = QcAfkirDetail.get(params.id)
        if (!qcAfkirDetailInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'qcAfkirDetail.label', default: 'QcAfkirDetail'), params.id])
            redirect(action: "list")
            return
        }

        [qcAfkirDetailInstance: qcAfkirDetailInstance]
    }

    def update() {
        def qcAfkirDetailInstance = QcAfkirDetail.get(params.id)
        if (!qcAfkirDetailInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'qcAfkirDetail.label', default: 'QcAfkirDetail'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (qcAfkirDetailInstance.version > version) {
                qcAfkirDetailInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'qcAfkirDetail.label', default: 'QcAfkirDetail')] as Object[],
                          "Another user has updated this QcAfkirDetail while you were editing")
                render(view: "edit", model: [qcAfkirDetailInstance: qcAfkirDetailInstance])
                return
            }
        }

        qcAfkirDetailInstance.properties = params

        if (!qcAfkirDetailInstance.save(flush: true)) {
            render(view: "edit", model: [qcAfkirDetailInstance: qcAfkirDetailInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'qcAfkirDetail.label', default: 'QcAfkirDetail'), qcAfkirDetailInstance.id])
        redirect(action: "show", id: qcAfkirDetailInstance.id)
    }

    def delete() {
        def qcAfkirDetailInstance = QcAfkirDetail.get(params.id)
        if (!qcAfkirDetailInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'qcAfkirDetail.label', default: 'QcAfkirDetail'), params.id])
            redirect(action: "list")
            return
        }

        try {
            qcAfkirDetailInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'qcAfkirDetail.label', default: 'QcAfkirDetail'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'qcAfkirDetail.label', default: 'QcAfkirDetail'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        
        def qcAfkirDetailInstance = (params.id) ? QcAfkirDetail.get(params.id) : new QcAfkirDetail()
        
        if (!qcAfkirDetailInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'qcAfkirDetail.label', default: 'QcAfkirDetail'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (qcAfkirDetailInstance.version > version) {
                    qcAfkirDetailInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'qcAfkirDetail.label', default: 'QcAfkirDetail')] as Object[],
                              "Another user has updated this QcAfkirDetail while you were editing")
                    render([success: false, messages: qcAfkirDetailInstance.errors] as JSON)
                    return
                }
            }            
        }
        

        qcAfkirDetailInstance.properties = params
        qcAfkirDetailInstance.createdBy = session.user
        qcAfkirDetailInstance.qcAfkir = QcAfkir.findByServerId(params.qcAfkirId)
        qcAfkirDetailInstance.code = params.code
        def gallon = Gallon.findByCode(params.code)

        if(gallon){
            qcAfkirDetailInstance.gallon = gallon
            qcAfkirDetailInstance.gallon.supplier = Supplier.findByServerId(params.supplierId)
            qcAfkirDetailInstance.gallon.yearExisting = params.year
            qcAfkirDetailInstance.gallon.monthExisting = params.month
        }else{
            
                qcAfkirDetailInstance.gallon = newGallon(params)
            
        }
        
        

        if (!qcAfkirDetailInstance.save(flush: true)) {
            println qcAfkirDetailInstance.errors
            render([success: false, messages: qcAfkirDetailInstance.errors] as JSON)
            return
        }


                        
        render([success: true,totalScan:qcAfkirDetailInstance.qcAfkir.qcAfkirDetails.size()] as JSON)    
    }

    def jlist() {
        if(params.masterField){
            def c = QcAfkirDetail.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }else if(params.qcAfkirId){
            def pid = QcAfkirDetail.createCriteria().list {
                qcAfkir {
                    eq('serverId',params.qcAfkirId)
                }
            }
            def results = []
            pid.each {
                results << [it.code, it.dateCreated]
            }
            render([data: results] as JSON)
        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render QcAfkirDetail.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def qcAfkirDetailInstance = QcAfkirDetail.get(id)
        if (!qcAfkirDetailInstance)
            render([success: false] as JSON)
        else {
            try {
                qcAfkirDetailInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def qcAfkirDetailInstance = QcAfkirDetail.get(params.id)
        if (!qcAfkirDetailInstance) {
            render(
                message : "qcAfkirDetail.not.found",
            ) as JSON

        }
        else {
            render([qcAfkirDetailInstance : qcAfkirDetailInstance ] as JSON)
        }
    }

    def scanRejectedItem(){
        def qcAfkirDetailInstance = (params.id) ? QcAfkirDetail.get(params.id) : new QcAfkirDetail()
        def qcAfkir = QcAfkir.findByServerId(params.qcAfkirId)
        def gallon = Gallon.findByCode(params.code)
        println " gallon " + gallon
        
        def qcAfkirDetailByCode =  QcAfkirDetail.createCriteria().list(){
            eq('qcAfkir',qcAfkir)
            eq('code',params.code)
        }

        println " qcAfkirDetailByCode "+ qcAfkirDetailByCode
        if(qcAfkirDetailByCode){
            render([success: false,unique:true] as JSON)    
        }else{

            if(gallon){
                if(gallon.supplier && gallon.yearExisting && gallon.monthExisting){
                    
                    if (!qcAfkirDetailInstance) {                     
                    def error = [message: message(code: 'default.not.found.message', args: [message(code: 'qcAfkirDetail.label', default: 'QcAfkirDetail'), params.id])]
                    render([success: false, messages: [errors:[error]] ] as JSON)       
                    return
                    }
                    
                    if (params.version)
                    {
                        def version = params.version.toLong()
                        if (version != null) {
                            if (qcAfkirDetailInstance.version > version) {
                                qcAfkirDetailInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                                          [message(code: 'qcAfkirDetail.label', default: 'QcAfkirDetail')] as Object[],
                                          "Another user has updated this QcAfkirDetail while you were editing")
                                render([success: false, messages: qcAfkirDetailInstance.errors] as JSON)
                                return
                            }
                        }            
                    }
                    
                    qcAfkirDetailInstance.properties = params
                    qcAfkirDetailInstance.createdBy = session.user
                    qcAfkirDetailInstance.qcAfkir = qcAfkir
                    qcAfkirDetailInstance.gallon = Gallon.findByCode(params.code)
                    qcAfkirDetailInstance.code = params.code

                    if (!qcAfkirDetailInstance.save(flush: true)) {
                        println qcAfkirDetailInstance.errors
                        render([success: false, messages: qcAfkirDetailInstance.errors] as JSON)
                        return
                    }
                                    
                    render([success: true,totalScan:qcAfkirDetailInstance.qcAfkir.qcAfkirDetails.size()] as JSON)    
                }else{
                    render([success: false] as JSON)                    
                }
            }else{
               render([success: false] as JSON)    
            }
        }    
    }

    def newGallon(params){
        def gallonInstance = new Gallon()
        gallonInstance.code = params.code
        gallonInstance.createdBy = session.user
        gallonInstance.item=Item.findByServerId(params.itemId)
        gallonInstance.type = true
        gallonInstance.yearExisting = params.year
        gallonInstance.monthExisting =params.month
        gallonInstance.writeOff= false

        if (!gallonInstance.save(flush: true)) {
            println gallonInstance.errors
            render([success: false, messages: gallonInstance.errors] as JSON)
            return null
        }else{
            return gallonInstance
        }

    }
}
