package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * WorkCenterController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class WorkCenterController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = WorkCenter.createCriteria().list(params){}
        [workCenterInstanceList: results, workCenterInstanceTotal: results.totalCount]
    }

    def create() {
        [workCenterInstance: new WorkCenter(params)]
    }

    def save() {
        def workCenterInstance = new WorkCenter(params)
        if (!workCenterInstance.save(flush: true)) {
            render(view: "create", model: [workCenterInstance: workCenterInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'workCenter.label', default: 'WorkCenter'), workCenterInstance.id])
        redirect(action: "show", id: workCenterInstance.id)
    }

    def show() {
        def workCenterInstance = WorkCenter.get(params.id)
        if (!workCenterInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'workCenter.label', default: 'WorkCenter'), params.id])
            redirect(action: "list")
            return
        }

        [workCenterInstance: workCenterInstance]
    }

    def edit() {
        def workCenterInstance = WorkCenter.get(params.id)
        if (!workCenterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'workCenter.label', default: 'WorkCenter'), params.id])
            redirect(action: "list")
            return
        }

        [workCenterInstance: workCenterInstance]
    }

    def update() {
        def workCenterInstance = WorkCenter.get(params.id)
        if (!workCenterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'workCenter.label', default: 'WorkCenter'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (workCenterInstance.version > version) {
                workCenterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'workCenter.label', default: 'WorkCenter')] as Object[],
                          "Another user has updated this WorkCenter while you were editing")
                render(view: "edit", model: [workCenterInstance: workCenterInstance])
                return
            }
        }

        workCenterInstance.properties = params

        if (!workCenterInstance.save(flush: true)) {
            render(view: "edit", model: [workCenterInstance: workCenterInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'workCenter.label', default: 'WorkCenter'), workCenterInstance.id])
        redirect(action: "show", id: workCenterInstance.id)
    }

    def delete() {
        def workCenterInstance = WorkCenter.get(params.id)
        if (!workCenterInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'workCenter.label', default: 'WorkCenter'), params.id])
            redirect(action: "list")
            return
        }

        try {
            workCenterInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'workCenter.label', default: 'WorkCenter'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'workCenter.label', default: 'WorkCenter'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def workCenterInstance = (params.id) ? WorkCenter.get(params.id) : new WorkCenter()
        
        if (!workCenterInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'workCenter.label', default: 'WorkCenter'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (workCenterInstance.version > version) {
                    workCenterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'workCenter.label', default: 'WorkCenter')] as Object[],
                              "Another user has updated this WorkCenter while you were editing")
                    render([success: false, messages: workCenterInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        workCenterInstance.properties = params
                       
        if (!workCenterInstance.save(flush: true)) {
            render([success: false, messages: workCenterInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = WorkCenter.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render WorkCenter.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def workCenterInstance = WorkCenter.get(id)
        if (!workCenterInstance)
            render([success: false] as JSON)
        else {
            try {
                workCenterInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def workCenterInstance = WorkCenter.get(params.id)
        if (!workCenterInstance) {
            render(
                message : "workCenter.not.found",
            ) as JSON

        }
        else {
            render([workCenterInstance : workCenterInstance ] as JSON)
        }
    }
}
