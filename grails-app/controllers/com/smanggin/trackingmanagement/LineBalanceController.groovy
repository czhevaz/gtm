package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * LineBalanceController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class LineBalanceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = LineBalance.createCriteria().list(params){}
        [lineBalanceInstanceList: results, lineBalanceInstanceTotal: results.totalCount]
    }

    def create() {
        [lineBalanceInstance: new LineBalance(params)]
    }

    def save() {
        def lineBalanceInstance = new LineBalance(params)
        if (!lineBalanceInstance.save(flush: true)) {
            render(view: "create", model: [lineBalanceInstance: lineBalanceInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'lineBalance.label', default: 'LineBalance'), lineBalanceInstance.id])
        redirect(action: "show", id: lineBalanceInstance.id)
    }

    def show() {
        def lineBalanceInstance = LineBalance.get(params.id)
        if (!lineBalanceInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'lineBalance.label', default: 'LineBalance'), params.id])
            redirect(action: "list")
            return
        }

        [lineBalanceInstance: lineBalanceInstance]
    }

    def edit() {
        def lineBalanceInstance = LineBalance.get(params.id)
        if (!lineBalanceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'lineBalance.label', default: 'LineBalance'), params.id])
            redirect(action: "list")
            return
        }

        [lineBalanceInstance: lineBalanceInstance]
    }

    def update() {
        def lineBalanceInstance = LineBalance.get(params.id)
        if (!lineBalanceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'lineBalance.label', default: 'LineBalance'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (lineBalanceInstance.version > version) {
                lineBalanceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'lineBalance.label', default: 'LineBalance')] as Object[],
                          "Another user has updated this LineBalance while you were editing")
                render(view: "edit", model: [lineBalanceInstance: lineBalanceInstance])
                return
            }
        }

        lineBalanceInstance.properties = params

        if (!lineBalanceInstance.save(flush: true)) {
            render(view: "edit", model: [lineBalanceInstance: lineBalanceInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'lineBalance.label', default: 'LineBalance'), lineBalanceInstance.id])
        redirect(action: "show", id: lineBalanceInstance.id)
    }

    def delete() {
        def lineBalanceInstance = LineBalance.get(params.id)
        if (!lineBalanceInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'lineBalance.label', default: 'LineBalance'), params.id])
            redirect(action: "list")
            return
        }

        try {
            lineBalanceInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'lineBalance.label', default: 'LineBalance'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'lineBalance.label', default: 'LineBalance'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def lineBalanceInstance = (params.id) ? LineBalance.get(params.id) : new LineBalance()
        
        if (!lineBalanceInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'lineBalance.label', default: 'LineBalance'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (lineBalanceInstance.version > version) {
                    lineBalanceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'lineBalance.label', default: 'LineBalance')] as Object[],
                              "Another user has updated this LineBalance while you were editing")
                    render([success: false, messages: lineBalanceInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        lineBalanceInstance.properties = params
                       
        if (!lineBalanceInstance.save(flush: true)) {
            render([success: false, messages: lineBalanceInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        println " params " +params
        if(params.masterField){
            def c = LineBalance.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.serverId',params.masterField.id)    
            }
            render results as JSON

        }else if(params.lineServerId){
            def c = LineBalance.createCriteria()
            
            def results = c.list {
                line{
                    eq('serverId',params.lineServerId)
                }
            }

            render results as JSON            
        }else if (params.closeshift) {
            def line = Line.findByServerId(params.lineId)
            def shift = Shift.findByServerId(params.shiftId)
            def results = calculateLineBalance(line,shift)

            render ([qty : results ] as JSON)
            
        }
        else
        {
            //params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render LineBalance.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def lineBalanceInstance = LineBalance.get(id)
        if (!lineBalanceInstance)
            render([success: false] as JSON)
        else {
            try {
                lineBalanceInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def lineBalanceInstance = LineBalance.get(params.id)
        if (!lineBalanceInstance) {
            render(
                message : "lineBalance.not.found",
            ) as JSON

        }
        else {
            render([lineBalanceInstance : lineBalanceInstance ] as JSON)
        }
    }

    def calculateLineBalance(line,shift){
        println "line" + line?.name
        println " shift" + shift?.name
        def balance =LineBalance.createCriteria().list(){
            eq('line',line)
            eq('shift',shift)
            projections{
                //groupProperty('shift')
                sum('inQty','inQty')
                sum('outQty','outQty')
            }

        }

        println "balance "+ balance
        def qtyEnd =  balance[0][0] - balance[0][1]
        
        return qtyEnd
    }
}
