package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * ProcessController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class ProcessController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = Process.createCriteria().list(params){}
        [processInstanceList: results, processInstanceTotal: results.totalCount]
    }

    def create() {
        [processInstance: new Process(params)]
    }

    def save() {
        def processInstance = new Process(params)
        if (!processInstance.save(flush: true)) {
            render(view: "create", model: [processInstance: processInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'process.label', default: 'Process'), processInstance.id])
        redirect(action: "show", id: processInstance.id)
    }

    def show() {
        def processInstance = Process.findByServerId(params.serverId)
        if (!processInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'process.label', default: 'Process'), params.id])
            redirect(action: "list")
            return
        }

        [processInstance: processInstance]
    }

    def edit() {
        def processInstance = Process.get(params.id)
        if (!processInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'process.label', default: 'Process'), params.id])
            redirect(action: "list")
            return
        }

        [processInstance: processInstance]
    }

    def update() {
        def processInstance = Process.get(params.id)
        if (!processInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'process.label', default: 'Process'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (processInstance.version > version) {
                processInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'process.label', default: 'Process')] as Object[],
                          "Another user has updated this Process while you were editing")
                render(view: "edit", model: [processInstance: processInstance])
                return
            }
        }

        processInstance.properties = params

        if (!processInstance.save(flush: true)) {
            render(view: "edit", model: [processInstance: processInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'process.label', default: 'Process'), processInstance.id])
        redirect(action: "show", id: processInstance.id)
    }

    def delete() {
        def processInstance = Process.get(params.id)
        if (!processInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'process.label', default: 'Process'), params.id])
            redirect(action: "list")
            return
        }

        try {
            processInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'process.label', default: 'Process'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'process.label', default: 'Process'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def processInstance = (params.id) ? Process.get(params.id) : new Process()
        
        if (!processInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'process.label', default: 'Process'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (processInstance.version > version) {
                    processInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'process.label', default: 'Process')] as Object[],
                              "Another user has updated this Process while you were editing")
                    render([success: false, messages: processInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        processInstance.properties = params
                       
        if (!processInstance.save(flush: true)) {
            render([success: false, messages: processInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = Process.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render Process.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def processInstance = Process.get(id)
        if (!processInstance)
            render([success: false] as JSON)
        else {
            try {
                processInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def processInstance = Process.get(params.id)
        if (!processInstance) {
            render(
                message : "process.not.found",
            ) as JSON

        }
        else {
            render([processInstance : processInstance ] as JSON)
        }
    }
}
