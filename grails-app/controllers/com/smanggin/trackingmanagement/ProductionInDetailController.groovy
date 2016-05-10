package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * ProductionInDetailController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class ProductionInDetailController {

    def globalService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        //params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = ProductionInDetail.createCriteria().list(params){}
        [productionInDetailInstanceList: results, productionInDetailInstanceTotal: results.totalCount]
    }

    def create() {
        [productionInDetailInstance: new ProductionInDetail(params)]
    }

    def save() {
        def productionInDetailInstance = new ProductionInDetail(params)
        if (!productionInDetailInstance.save(flush: true)) {
            render(view: "create", model: [productionInDetailInstance: productionInDetailInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'productionInDetail.label', default: 'ProductionInDetail'), productionInDetailInstance.serverId])
        redirect(action: "show", id: productionInDetailInstance.serverId)
    }

    def show() {
        def productionInDetailInstance = ProductionInDetail.get(params.id)
        if (!productionInDetailInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'productionInDetail.label', default: 'ProductionInDetail'), params.id])
            redirect(action: "list")
            return
        }

        [productionInDetailInstance: productionInDetailInstance]
    }

    def edit() {
        def productionInDetailInstance = ProductionInDetail.get(params.id)
        if (!productionInDetailInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'productionInDetail.label', default: 'ProductionInDetail'), params.id])
            redirect(action: "list")
            return
        }

        [productionInDetailInstance: productionInDetailInstance]
    }

    def update() {
        def productionInDetailInstance = ProductionInDetail.get(params.id)
        if (!productionInDetailInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'productionInDetail.label', default: 'ProductionInDetail'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (productionInDetailInstance.version > version) {
                productionInDetailInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'productionInDetail.label', default: 'ProductionInDetail')] as Object[],
                          "Another user has updated this ProductionInDetail while you were editing")
                render(view: "edit", model: [productionInDetailInstance: productionInDetailInstance])
                return
            }
        }

        productionInDetailInstance.properties = params

        if (!productionInDetailInstance.save(flush: true)) {
            render(view: "edit", model: [productionInDetailInstance: productionInDetailInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'productionInDetail.label', default: 'ProductionInDetail'), productionInDetailInstance.serverId])
        redirect(action: "show", id: productionInDetailInstance.serverId)
    }

    def delete() {
        def productionInDetailInstance = ProductionInDetail.get(params.id)
        if (!productionInDetailInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'productionInDetail.label', default: 'ProductionInDetail'), params.id])
            redirect(action: "list")
            return
        }

        try {
            productionInDetailInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'productionInDetail.label', default: 'ProductionInDetail'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'productionInDetail.label', default: 'ProductionInDetail'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        /*def productionInDetailInstance = (params.id) ? ProductionInDetail.get(params.id) : new ProductionInDetail()
        
        if (!productionInDetailInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'productionInDetail.label', default: 'ProductionInDetail'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (productionInDetailInstance.version > version) {
                    productionInDetailInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'productionInDetail.label', default: 'ProductionInDetail')] as Object[],
                              "Another user has updated this ProductionInDetail while you were editing")
                    render([success: false, messages: productionInDetailInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        productionInDetailInstance.properties = params
                       
        if (!productionInDetailInstance.save(flush: true)) {
            render([success: false, messages: productionInDetailInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)*/
        println " params " + params
        def productionInDetailInstance = new ProductionInDetail()

        if (params.code && params.serverId) {

            def gallonInstance = Gallon.findByCode(params.code)
            def productionInHeader = ProductionInHeader.findByServerId(params.serverId)
            

            if (gallonInstance) {
                def production = ProductionInDetail.createCriteria().list(){
                    eq('productionInHeader',productionInHeader)
                    eq('gallon',gallonInstance)
                }
                
                if (production.size() > 0) {
                   
                    render([success: false] as JSON)
                } else {
                    productionInDetailInstance.productionInHeader = ProductionInHeader.get(params.serverId)
                    productionInDetailInstance.gallon = Gallon.get(gallonInstance.serverId)
                    productionInDetailInstance.createdBy = session.user
                    productionInDetailInstance.updatedBy = session.user

                    if (!productionInDetailInstance.save(flush: true)) {
                        println "errors " +productionInDetailInstance.errors
                        render([success: false] as JSON)
                        return
                    }
                    def pdi = ProductionInDetail.createCriteria().list(){
                        eq('productionInHeader',productionInHeader)
                    
                    }   
                    def count =pdi?.size()
                    render([success: true,count:count] as JSON)
                }
            }
        }

    }

    def jlist() {
        def pid = null
        def results = []
        if(params.masterField) {
            pid = ProductionInDetail.createCriteria().list {
                productionInHeader {
                    eq('serverId',params.masterField)
                }
            }
            pid.each {
                results << [it.gallon?.code, it.dateCreated]
            }
            render([data: results] as JSON)
        } else {
            pid = ProductionInDetail.list()
            pid.each {
                results << [it.gallon?.code, it.dateCreated]
            }
            render([data: results] as JSON)
        }

    }

    def jdelete(Long id) {
        def productionInDetailInstance = ProductionInDetail.get(id)
        if (!productionInDetailInstance)
            render([success: false] as JSON)
        else {
            try {
                productionInDetailInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def productionInDetailInstance = ProductionInDetail.get(params.id)
        if (!productionInDetailInstance) {
            render(
                message : "productionInDetail.not.found",
            ) as JSON

        }
        else {
            render([productionInDetailInstance : productionInDetailInstance ] as JSON)
        }
    }

    def reportProductionIn() {
        def startDate = globalService.correctDateTime(params.startDate)
        def endDate = globalService.correctDateTime(params.endDate)
        // def filterDate = globalService.filterDate(startDate, endDate)
        def line1 = Line.findByServerId(params.line1ServerId)
        // def line2 = Line.findByServerId(params.line2Code)
        def plant = Plant.findByServerId(params.plantServerId)

        def results = ProductionInHeader.createCriteria().list {
            workCenter {
                eq('line', line1)
            }
        }

        println " results" + results

        def list = []

        results.each{
            def map = [:]
            map.put('gallonCode', it.productionInDetails?.gallon?.code)
            map.put('date', it.date)
            list.push(map)
        }

        render([success: true, results: list] as JSON)
    }
}
