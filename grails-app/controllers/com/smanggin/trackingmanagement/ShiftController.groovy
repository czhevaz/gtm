package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import org.joda.time.LocalTime

/**
 * ShiftController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class ShiftController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        //params.max = Math.min(params.max ? params.int('max') : 10, 100)
        params.order = params.order ?: 'asc' 
        params.sort = params.sort ?: 'dateCreated' 
        
        def results = Shift.createCriteria().list(params){}
        [shiftInstanceList: results, shiftInstanceTotal: results.totalCount]
    }

    def create() {
        [shiftInstance: new Shift(params)]
    }

    def save() {
        
        def shiftInstance = new Shift(params)
        shiftInstance.plant = Plant.findByServerId(params.plant.serverId)
        shiftInstance.startDate = new LocalTime(params.startDate_hour.toInteger(),params.startDate_minute.toInteger())
        shiftInstance.endDate = new LocalTime(params.endDate_hour.toInteger(),params.endDate_minute.toInteger())
        if (!shiftInstance.save(flush: true)) {
            render(view: "create", model: [shiftInstance: shiftInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'shift.label', default: 'Shift'), shiftInstance.id])
        redirect(action: "show", id: shiftInstance.id)
    }

    def show() {
        def shiftInstance = Shift.get(params.id)
        if (!shiftInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'shift.label', default: 'Shift'), params.id])
            redirect(action: "list")
            return
        }

        [shiftInstance: shiftInstance]
    }

    def edit() {
        def shiftInstance = Shift.get(params.id)
        if (!shiftInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'shift.label', default: 'Shift'), params.id])
            redirect(action: "list")
            return
        }

        [shiftInstance: shiftInstance]
    }

    def update() {
        def shiftInstance = Shift.get(params.id)
        if (!shiftInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'shift.label', default: 'Shift'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (shiftInstance.version > version) {
                shiftInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'shift.label', default: 'Shift')] as Object[],
                          "Another user has updated this Shift while you were editing")
                render(view: "edit", model: [shiftInstance: shiftInstance])
                return
            }
        }

        shiftInstance.properties = params

        if (!shiftInstance.save(flush: true)) {
            render(view: "edit", model: [shiftInstance: shiftInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'shift.label', default: 'Shift'), shiftInstance.id])
        redirect(action: "show", id: shiftInstance.id)
    }

    def delete() {
        def shiftInstance = Shift.get(params.id)
        if (!shiftInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'shift.label', default: 'Shift'), params.id])
            redirect(action: "list")
            return
        }

        try {
            shiftInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'shift.label', default: 'Shift'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'shift.label', default: 'Shift'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def shiftInstance = (params.id) ? Shift.get(params.id) : new Shift()
        
        if (!shiftInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'shift.label', default: 'Shift'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (shiftInstance.version > version) {
                    shiftInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'shift.label', default: 'Shift')] as Object[],
                              "Another user has updated this Shift while you were editing")
                    render([success: false, messages: shiftInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        shiftInstance.properties = params
                       
        if (!shiftInstance.save(flush: true)) {
            render([success: false, messages: shiftInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = Shift.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render Shift.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def shiftInstance = Shift.get(id)
        if (!shiftInstance)
            render([success: false] as JSON)
        else {
            try {
                shiftInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def shiftInstance = Shift.get(params.id)
        if (!shiftInstance) {
            render(
                message : "shift.not.found",
            ) as JSON

        }
        else {
            render([shiftInstance : shiftInstance ] as JSON)
        }
    }
}
