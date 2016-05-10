package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * ItemController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class ItemController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = Item.createCriteria().list(params){}
        [itemInstanceList: results, itemInstanceTotal: results.totalCount]
    }

    def create() {
        [itemInstance: new Item(params)]
    }

    def save() {
        def itemInstance = new Item(params)
        if (!itemInstance.save(flush: true)) {
            render(view: "create", model: [itemInstance: itemInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'item.label', default: 'Item'), itemInstance.serverId])
        redirect(action: "show", id: itemInstance.serverId)
    }

    def show() {
        def itemInstance = Item.findByServerId(params.serverId)
        if (!itemInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'item.label', default: 'Item'), params.id])
            redirect(action: "list")
            return
        }

        [itemInstance: itemInstance]
    }

    def edit() {
        def itemInstance = Item.findByServerId(params.serverId)
        if (!itemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'item.label', default: 'Item'), params.id])
            redirect(action: "list")
            return
        }

        [itemInstance: itemInstance]
    }

    def update() {
        def itemInstance = Item.findByServerId(params.serverId)
        if (!itemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'item.label', default: 'Item'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (itemInstance.version > version) {
                itemInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'item.label', default: 'Item')] as Object[],
                          "Another user has updated this Item while you were editing")
                render(view: "edit", model: [itemInstance: itemInstance])
                return
            }
        }

        itemInstance.properties = params

        if (!itemInstance.save(flush: true)) {
            render(view: "edit", model: [itemInstance: itemInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'item.label', default: 'Item'), itemInstance.id])
        redirect(action: "show", id: itemInstance.id)
    }

    def delete() {
        def itemInstance = Item.get(params.id)
        if (!itemInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'item.label', default: 'Item'), params.id])
            redirect(action: "list")
            return
        }

        try {
            itemInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'item.label', default: 'Item'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'item.label', default: 'Item'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def itemInstance = (params.id) ? Item.get(params.id) : new Item()
        
        if (!itemInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'item.label', default: 'Item'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (itemInstance.version > version) {
                    itemInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'item.label', default: 'Item')] as Object[],
                              "Another user has updated this Item while you were editing")
                    render([success: false, messages: itemInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        itemInstance.properties = params
                       
        if (!itemInstance.save(flush: true)) {
            render([success: false, messages: itemInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = Item.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render Item.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def itemInstance = Item.get(id)
        if (!itemInstance)
            render([success: false] as JSON)
        else {
            try {
                itemInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def itemInstance = Item.get(params.id)
        if (!itemInstance) {
            render(
                message : "item.not.found",
            ) as JSON

        }
        else {
            render([itemInstance : itemInstance ] as JSON)
        }
    }
}
