package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * ReplaceCodeHistoryController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class ReplaceCodeHistoryController {
    def globalService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        //params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = ReplaceCodeHistory.createCriteria().list(params){}
        [replaceCodeHistoryInstanceList: results, replaceCodeHistoryInstanceTotal: results.totalCount]
    }

    def create() {
        def yearList = globalService.yearList()
        def monthList = globalService.monthList()
        [replaceCodeHistoryInstance: new ReplaceCodeHistory(params),yearList:yearList,monthList:monthList]
    }

    def save() {
        def replaceCodeHistoryInstance = new ReplaceCodeHistory(params)
        
        replaceCodeHistoryInstance.properties = params
        replaceCodeHistoryInstance.plant = Plant.findByServerId(params.plant.serverId)
        replaceCodeHistoryInstance.gallon = Gallon.findByCode(params.oldNumber)
        
        replaceCodeHistoryInstance.createdBy = session.user
        replaceCodeHistoryInstance.updatedBy = session.user
        if(replaceCodeHistoryInstance.gallon){

            replaceCodeHistoryInstance.gallon.code = params.newNumber
            if (!replaceCodeHistoryInstance.save(flush: true)) {
                render(view: "create", model: [replaceCodeHistoryInstance: replaceCodeHistoryInstance])
                return
            }

            flash.message = message(code: 'default.created.message', args: [message(code: 'replaceCodeHistory.label', default: 'change number'), replaceCodeHistoryInstance.code])
            redirect(action: "show", params: [serverId:replaceCodeHistoryInstance.serverId])
        }else{
            flash.error = message(code: 'default.not.found.message', args: [message(code: 'gallon.label', default: 'gallon'), params.oldNumber])
            redirect(action: "show", params: [serverId:replaceCodeHistoryInstance.serverId])
        }

        
    }

    def show() {
        def replaceCodeHistoryInstance = ReplaceCodeHistory.get(params.id)
        if (!replaceCodeHistoryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'replaceCodeHistory.label', default: 'ReplaceCodeHistory'), params.id])
            redirect(action: "list")
            return
        }

        [replaceCodeHistoryInstance: replaceCodeHistoryInstance]
    }

    def edit() {
        def replaceCodeHistoryInstance = ReplaceCodeHistory.get(params.id)
        if (!replaceCodeHistoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'replaceCodeHistory.label', default: 'ReplaceCodeHistory'), params.id])
            redirect(action: "list")
            return
        }

        [replaceCodeHistoryInstance: replaceCodeHistoryInstance]
    }

    def update() {
        def replaceCodeHistoryInstance = ReplaceCodeHistory.get(params.id)
        if (!replaceCodeHistoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'replaceCodeHistory.label', default: 'ReplaceCodeHistory'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (replaceCodeHistoryInstance.version > version) {
                replaceCodeHistoryInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'replaceCodeHistory.label', default: 'ReplaceCodeHistory')] as Object[],
                          "Another user has updated this ReplaceCodeHistory while you were editing")
                render(view: "edit", model: [replaceCodeHistoryInstance: replaceCodeHistoryInstance])
                return
            }
        }

        replaceCodeHistoryInstance.properties = params

        if (!replaceCodeHistoryInstance.save(flush: true)) {
            render(view: "edit", model: [replaceCodeHistoryInstance: replaceCodeHistoryInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'replaceCodeHistory.label', default: 'ReplaceCodeHistory'), replaceCodeHistoryInstance.id])
        redirect(action: "show", id: replaceCodeHistoryInstance.id)
    }

    def delete() {
        def replaceCodeHistoryInstance = ReplaceCodeHistory.get(params.id)
        if (!replaceCodeHistoryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'replaceCodeHistory.label', default: 'ReplaceCodeHistory'), params.id])
            redirect(action: "list")
            return
        }

        try {
            replaceCodeHistoryInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'replaceCodeHistory.label', default: 'ReplaceCodeHistory'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'replaceCodeHistory.label', default: 'ReplaceCodeHistory'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def replaceCodeHistoryInstance = (params.id) ? ReplaceCodeHistory.get(params.id) : new ReplaceCodeHistory()
        
        if (!replaceCodeHistoryInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'replaceCodeHistory.label', default: 'ReplaceCodeHistory'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (replaceCodeHistoryInstance.version > version) {
                    replaceCodeHistoryInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'replaceCodeHistory.label', default: 'ReplaceCodeHistory')] as Object[],
                              "Another user has updated this ReplaceCodeHistory while you were editing")
                    render([success: false, messages: replaceCodeHistoryInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        replaceCodeHistoryInstance.properties = params
        replaceCodeHistoryInstance.plant = Plant.findByServerId(params.plantId)
        replaceCodeHistoryInstance.createdBy = session.user
        replaceCodeHistoryInstance.updatedBy = session.user
        def gallon = Gallon.findByCode(params.oldNumber)
        
        if(gallon){
            replaceCodeHistoryInstance.gallon = gallon
        }else{
            println "123456"
            replaceCodeHistoryInstance.gallon = newGallon(params)
        }
        

                       
        if (!replaceCodeHistoryInstance.save(flush: true)) {
            render([success: false, messages: replaceCodeHistoryInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = ReplaceCodeHistory.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }else if(params.replaceCode){
            def c = ReplaceCodeHistory.createCriteria().list(){
                eq('createdBy',session.user)
            }

            def results = []
            c.each {
                results << [it.oldNumber,it.newNumber, it.dateCreated]
            }

            render([data: results] as JSON)
        
        }else{
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render ReplaceCodeHistory.list(params) as JSON       
        }
        
    }   

    def jdelete(Long id) {
        def replaceCodeHistoryInstance = ReplaceCodeHistory.get(id)
        if (!replaceCodeHistoryInstance)
            render([success: false] as JSON)
        else {
            try {
                replaceCodeHistoryInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def replaceCodeHistoryInstance = ReplaceCodeHistory.get(params.id)
        if (!replaceCodeHistoryInstance) {
            render(
                message : "replaceCodeHistory.not.found",
            ) as JSON

        }
        else {
            render([replaceCodeHistoryInstance : replaceCodeHistoryInstance ] as JSON)
        }
    }

    def newGallon(params){
        def gallonInstance = new Gallon()
        gallonInstance.code = params.newNumber
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

    def scanReplaceCodeItem(){
        def replaceCodeHistoryInstance = (params.id) ? ReplaceCodeHistory.get(params.id) : new ReplaceCodeHistory()
        def gallon = Gallon.findByCode(params.oldNumber)
        
        if(gallon){
            if(gallon.supplier && gallon.yearExisting && gallon.monthExisting){
                
                replaceCodeHistoryInstance.properties = params
                replaceCodeHistoryInstance.plant = Plant.findByServerId(params.plantId)
                replaceCodeHistoryInstance.gallon = gallon
                replaceCodeHistoryInstance.createdBy = session.user
                replaceCodeHistoryInstance.updatedBy = session.user

                if (!replaceCodeHistoryInstance.save(flush: true)) {
                    println replaceCodeHistoryInstance.errors
                    render([success: false, messages: replaceCodeHistoryInstance.errors] as JSON)
                    return
                }
                                
                render([success: true] as JSON)    
            }else{
                render([success: false] as JSON)                    
            }
        }else{
           render([success: false] as JSON)    
        }
    }
}
