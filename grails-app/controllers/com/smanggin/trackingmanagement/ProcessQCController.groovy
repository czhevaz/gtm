package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * ProcessQCController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class ProcessQCController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = ProcessQC.createCriteria().list(params){}
        [processQCInstanceList: results, processQCInstanceTotal: results.totalCount]
    }

    def create() {
        [processQCInstance: new ProcessQC(params)]
    }

    def save() {
        def processQCInstance = new ProcessQC(params)
        if (!processQCInstance.save(flush: true)) {
            render(view: "create", model: [processQCInstance: processQCInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'processQC.label', default: 'ProcessQC'), processQCInstance.id])
        redirect(action: "show", id: processQCInstance.id)
    }

    def show() {
        def processQCInstance = ProcessQC.get(params.id)
        if (!processQCInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'processQC.label', default: 'ProcessQC'), params.id])
            redirect(action: "list")
            return
        }

        [processQCInstance: processQCInstance]
    }

    def edit() {
        def processQCInstance = ProcessQC.get(params.id)
        if (!processQCInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'processQC.label', default: 'ProcessQC'), params.id])
            redirect(action: "list")
            return
        }

        [processQCInstance: processQCInstance]
    }

    def update() {
        def processQCInstance = ProcessQC.get(params.id)
        if (!processQCInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'processQC.label', default: 'ProcessQC'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (processQCInstance.version > version) {
                processQCInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'processQC.label', default: 'ProcessQC')] as Object[],
                          "Another user has updated this ProcessQC while you were editing")
                render(view: "edit", model: [processQCInstance: processQCInstance])
                return
            }
        }

        processQCInstance.properties = params

        if (!processQCInstance.save(flush: true)) {
            render(view: "edit", model: [processQCInstance: processQCInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'processQC.label', default: 'ProcessQC'), processQCInstance.id])
        redirect(action: "show", id: processQCInstance.id)
    }

    def delete() {
        def processQCInstance = ProcessQC.get(params.id)
        if (!processQCInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'processQC.label', default: 'ProcessQC'), params.id])
            redirect(action: "list")
            return
        }

        try {
            processQCInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'processQC.label', default: 'ProcessQC'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'processQC.label', default: 'ProcessQC'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def processQCInstance = (params.id) ? ProcessQC.get(params.id) : new ProcessQC()
        
        if (!processQCInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'processQC.label', default: 'ProcessQC'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (processQCInstance.version > version) {
                    processQCInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'processQC.label', default: 'ProcessQC')] as Object[],
                              "Another user has updated this ProcessQC while you were editing")
                    render([success: false, messages: processQCInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        processQCInstance.properties = params
                       
        if (!processQCInstance.save(flush: true)) {
            render([success: false, messages: processQCInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = ProcessQC.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render ProcessQC.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def processQCInstance = ProcessQC.get(id)
        if (!processQCInstance)
            render([success: false] as JSON)
        else {
            try {
                processQCInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def processQCInstance = ProcessQC.get(params.id)
        if (!processQCInstance) {
            render(
                message : "processQC.not.found",
            ) as JSON

        }
        else {
            render([processQCInstance : processQCInstance ] as JSON)
        }
    }
}
