package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * LineController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class LineController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = Line.createCriteria().list(params){}
        [lineInstanceList: results, lineInstanceTotal: results.totalCount]
    }

    def create() {
        [lineInstance: new Line(params)]
    }

    def save() {
        def lineInstance = new Line(params)
        if (!lineInstance.save(flush: true)) {
            render(view: "create", model: [lineInstance: lineInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'line.label', default: 'Line'), lineInstance.id])
        redirect(action: "show", id: lineInstance.id)
    }

    def show() {
        def lineInstance = Line.findByServerId(params.serverId)
        if (!lineInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'line.label', default: 'Line'), params.id])
            redirect(action: "list")
            return
        }

        [lineInstance: lineInstance]
    }

    def edit() {
        def lineInstance = Line.get(params.id)
        if (!lineInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'line.label', default: 'Line'), params.id])
            redirect(action: "list")
            return
        }

        [lineInstance: lineInstance]
    }

    def update() {
        def lineInstance = Line.get(params.id)
        if (!lineInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'line.label', default: 'Line'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (lineInstance.version > version) {
                lineInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'line.label', default: 'Line')] as Object[],
                          "Another user has updated this Line while you were editing")
                render(view: "edit", model: [lineInstance: lineInstance])
                return
            }
        }

        lineInstance.properties = params

        if (!lineInstance.save(flush: true)) {
            render(view: "edit", model: [lineInstance: lineInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'line.label', default: 'Line'), lineInstance.id])
        redirect(action: "show", id: lineInstance.id)
    }

    def delete() {
        def lineInstance = Line.get(params.id)
        if (!lineInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'line.label', default: 'Line'), params.id])
            redirect(action: "list")
            return
        }

        try {
            lineInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'line.label', default: 'Line'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'line.label', default: 'Line'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def lineInstance = (params.id) ? Line.get(params.id) : new Line()
        
        if (!lineInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'line.label', default: 'Line'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (lineInstance.version > version) {
                    lineInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'line.label', default: 'Line')] as Object[],
                              "Another user has updated this Line while you were editing")
                    render([success: false, messages: lineInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        lineInstance.properties = params
                       
        if (!lineInstance.save(flush: true)) {
            render([success: false, messages: lineInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = Line.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render Line.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def lineInstance = Line.get(id)
        if (!lineInstance)
            render([success: false] as JSON)
        else {
            try {
                lineInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def lineInstance = Line.get(params.id)
        if (!lineInstance) {
            render(
                message : "line.not.found",
            ) as JSON

        }
        else {
            render([lineInstance : lineInstance ] as JSON)
        }
    }
}
