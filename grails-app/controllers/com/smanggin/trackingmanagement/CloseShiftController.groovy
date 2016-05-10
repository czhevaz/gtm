package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * CloseShiftController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class CloseShiftController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = CloseShift.createCriteria().list(params){}
        [closeShiftInstanceList: results, closeShiftInstanceTotal: results.totalCount]
    }

    def create() {
        [closeShiftInstance: new CloseShift(params)]
    }

    def save() {
        def closeShiftInstance = new CloseShift(params)
        closeShiftInstance.shift = Shift.findByServerId(params.shift?.serverId)
        closeShiftInstance.line = Line.findByServerId(params.line?.serverId)
        closeShiftInstance.plant = Plant.findByServerId(params.plant?.serverId)

        if (!closeShiftInstance.save(flush: true)) {
            render(view: "create", model: [closeShiftInstance: closeShiftInstance])
            return
        }

        insertLineBalance(closeShiftInstance)

		flash.message = message(code: 'default.created.message', args: [message(code: 'closeShift.label', default: 'CloseShift'), closeShiftInstance.id])
        redirect(action: "show", id: closeShiftInstance.id)
    }

    def show() {
        def closeShiftInstance = CloseShift.get(params.id)
        if (!closeShiftInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'closeShift.label', default: 'CloseShift'), params.id])
            redirect(action: "list")
            return
        }

        [closeShiftInstance: closeShiftInstance]
    }

    def edit() {
        def closeShiftInstance = CloseShift.get(params.id)
        if (!closeShiftInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'closeShift.label', default: 'CloseShift'), params.id])
            redirect(action: "list")
            return
        }

        [closeShiftInstance: closeShiftInstance]
    }

    def update() {
        def closeShiftInstance = CloseShift.get(params.id)
        if (!closeShiftInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'closeShift.label', default: 'CloseShift'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (closeShiftInstance.version > version) {
                closeShiftInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'closeShift.label', default: 'CloseShift')] as Object[],
                          "Another user has updated this CloseShift while you were editing")
                render(view: "edit", model: [closeShiftInstance: closeShiftInstance])
                return
            }
        }

        closeShiftInstance.properties = params

        if (!closeShiftInstance.save(flush: true)) {
            render(view: "edit", model: [closeShiftInstance: closeShiftInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'closeShift.label', default: 'CloseShift'), closeShiftInstance.id])
        redirect(action: "show", id: closeShiftInstance.id)
    }

    def delete() {
        def closeShiftInstance = CloseShift.get(params.id)
        if (!closeShiftInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'closeShift.label', default: 'CloseShift'), params.id])
            redirect(action: "list")
            return
        }

        try {
            closeShiftInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'closeShift.label', default: 'CloseShift'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'closeShift.label', default: 'CloseShift'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def closeShiftInstance = (params.id) ? CloseShift.get(params.id) : new CloseShift()
        
        if (!closeShiftInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'closeShift.label', default: 'CloseShift'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (closeShiftInstance.version > version) {
                    closeShiftInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'closeShift.label', default: 'CloseShift')] as Object[],
                              "Another user has updated this CloseShift while you were editing")
                    render([success: false, messages: closeShiftInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        closeShiftInstance.properties = params
                       
        if (!closeShiftInstance.save(flush: true)) {
            render([success: false, messages: closeShiftInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = CloseShift.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render CloseShift.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def closeShiftInstance = CloseShift.get(id)
        if (!closeShiftInstance)
            render([success: false] as JSON)
        else {
            try {
                closeShiftInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def closeShiftInstance = CloseShift.get(params.id)
        if (!closeShiftInstance) {
            render(
                message : "closeShift.not.found",
            ) as JSON

        }
        else {
            render([closeShiftInstance : closeShiftInstance ] as JSON)
        }
    }

    def calculateLineBalance(line,shift){
        def balance =LineBalance.createCriteria().list(){
            eq('line',line)
            eq('shift',shift)
            projections{
                sum('inQty','inQty')
                sum('outQty','outQty')
            }

        }

        def qtyEnd =  balance[1] - balance[2]
        return qtyEnd
    }

    def insertLineBalance(closeShiftInstance){
        params.order = params.order ?: 'desc' 
        params.sort = params.sort ?: 'dateCreated' 
        
        def last = LineBalance.createCriteria().list(params){
           maxResults(1)
        }

        def lineBalance = new LineBalance()
        lineBalance.plant = closeShiftInstance.plant
        lineBalance.line = closeShiftInstance.line
        lineBalance.date = new Date()
        lineBalance.beginQty = last?.endQty[0]?:0
        lineBalance.inQty = 0
        lineBalance.outQty = closeShiftInstance.yieldBySystem
        lineBalance.endQty = lineBalance.beginQty - lineBalance.outQty
        lineBalance.createdBy =session.user
        lineBalance.shift = closeShiftInstance.shift

        if(!lineBalance.save(flush:true)){
            println "errors " + lineBalance.errors
        }


    }
}
