package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * ItemBalanceController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class ItemBalanceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = ItemBalance.createCriteria().list(params){}
        [itemBalanceInstanceList: results, itemBalanceInstanceTotal: results.totalCount]
    }

    def create() {
        [itemBalanceInstance: new ItemBalance(params)]
    }

    def save() {
        def itemBalanceInstance = new ItemBalance(params)
        if (!itemBalanceInstance.save(flush: true)) {
            render(view: "create", model: [itemBalanceInstance: itemBalanceInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'itemBalance.label', default: 'ItemBalance'), itemBalanceInstance.id])
        redirect(action: "show", id: itemBalanceInstance.id)
    }

    def show() {
        def itemBalanceInstance = ItemBalance.get(params.id)
        if (!itemBalanceInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'itemBalance.label', default: 'ItemBalance'), params.id])
            redirect(action: "list")
            return
        }

        [itemBalanceInstance: itemBalanceInstance]
    }

    def edit() {
        def itemBalanceInstance = ItemBalance.get(params.id)
        if (!itemBalanceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'itemBalance.label', default: 'ItemBalance'), params.id])
            redirect(action: "list")
            return
        }

        [itemBalanceInstance: itemBalanceInstance]
    }

    def update() {
        def itemBalanceInstance = ItemBalance.get(params.id)
        if (!itemBalanceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'itemBalance.label', default: 'ItemBalance'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (itemBalanceInstance.version > version) {
                itemBalanceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'itemBalance.label', default: 'ItemBalance')] as Object[],
                          "Another user has updated this ItemBalance while you were editing")
                render(view: "edit", model: [itemBalanceInstance: itemBalanceInstance])
                return
            }
        }

        itemBalanceInstance.properties = params

        if (!itemBalanceInstance.save(flush: true)) {
            render(view: "edit", model: [itemBalanceInstance: itemBalanceInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'itemBalance.label', default: 'ItemBalance'), itemBalanceInstance.id])
        redirect(action: "show", id: itemBalanceInstance.id)
    }

    def delete() {
        def itemBalanceInstance = ItemBalance.get(params.id)
        if (!itemBalanceInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'itemBalance.label', default: 'ItemBalance'), params.id])
            redirect(action: "list")
            return
        }

        try {
            itemBalanceInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'itemBalance.label', default: 'ItemBalance'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'itemBalance.label', default: 'ItemBalance'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def itemBalanceInstance = (params.id) ? ItemBalance.get(params.id) : new ItemBalance()
        
        if (!itemBalanceInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'itemBalance.label', default: 'ItemBalance'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (itemBalanceInstance.version > version) {
                    itemBalanceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'itemBalance.label', default: 'ItemBalance')] as Object[],
                              "Another user has updated this ItemBalance while you were editing")
                    render([success: false, messages: itemBalanceInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        itemBalanceInstance.properties = params
                       
        if (!itemBalanceInstance.save(flush: true)) {
            render([success: false, messages: itemBalanceInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = ItemBalance.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render ItemBalance.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def itemBalanceInstance = ItemBalance.get(id)
        if (!itemBalanceInstance)
            render([success: false] as JSON)
        else {
            try {
                itemBalanceInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def itemBalanceInstance = ItemBalance.get(params.id)
        if (!itemBalanceInstance) {
            render(
                message : "itemBalance.not.found",
            ) as JSON

        }
        else {
            render([itemBalanceInstance : itemBalanceInstance ] as JSON)
        }
    }
}
