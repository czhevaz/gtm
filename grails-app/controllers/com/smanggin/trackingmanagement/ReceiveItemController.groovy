package com.smanggin.trackingmanagement


import java.util.regex.Pattern
import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * ReceiveItemController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class ReceiveItemController {
    def globalService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
       // params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = ReceiveItem.createCriteria().list(params){}
        [receiveItemInstanceList: results, receiveItemInstanceTotal: results.totalCount]
    }

    def create() {
        def trGroupList =  globalService.trGroupList(null,'3')
        [receiveItemInstance: new ReceiveItem(params),trGroupList:trGroupList]
    }

    def save() {
        def receiveItemInstance = new ReceiveItem(params)
        receiveItemInstance.createdBy = session.user
        receiveItemInstance.supplier = Supplier.findByServerId(params.supplier.serverId)
        receiveItemInstance.item = Item.findByServerId(params.item.serverId)
        receiveItemInstance.transactionGroup=TransactionGroup.findByServerId(params.transactionGroup?.serverId)

       // receiveItemInstance.plant=Plant.findByServerId(params.plant?.serverId)
        //def startNumber = params.startNumber?.toLong() 
        //def endNumber = params.endNumber?.toLong() 

       
        if (!receiveItemInstance.save(flush: true)) {
            render(view: "create", model: [receiveItemInstance: receiveItemInstance])
            return
        }

         /*(startNumber..endNumber).each{
            generateItemNumber(receiveItemInstance,it)
            def gallonInstance = new Gallon()
            gallonInstance.code =generateItemNumber(receiveItemInstance,it) 
            gallonInstance.writeOff = false
            gallonInstance.createdBy = session.user
            gallonInstance.item = receiveItemInstance?.item
            gallonInstance.receiveItem = receiveItemInstance
            if(!gallonInstance.save(flush: true)){
                println " errors " + gallonInstance.errors
            }
        }*/


		flash.message = message(code: 'default.created.message', args: [message(code: 'receiveItem.label', default: 'ReceiveItem'), receiveItemInstance.serverId])
        redirect(action: "show", params:[serverId:receiveItemInstance.serverId])
    }

    def show() {
        def receiveItemInstance = ReceiveItem.findByServerId(params.serverId)
        if (!receiveItemInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'receiveItem.label', default: 'ReceiveItem'), params.id])
            redirect(action: "list")
            return
        }

        [receiveItemInstance: receiveItemInstance]
    }

    def edit() {
        def receiveItemInstance = ReceiveItem.get(params.id)
        if (!receiveItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'receiveItem.label', default: 'ReceiveItem'), params.id])
            redirect(action: "list")
            return
        }

        def trGroupList =  globalService.trGroupList(session.defaultPlantId,'3')
        [receiveItemInstance: receiveItemInstance]
    }

    def update() {
        def receiveItemInstance = ReceiveItem.get(params.id)
        if (!receiveItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'receiveItem.label', default: 'ReceiveItem'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (receiveItemInstance.version > version) {
                receiveItemInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'receiveItem.label', default: 'ReceiveItem')] as Object[],
                          "Another user has updated this ReceiveItem while you were editing")
                render(view: "edit", model: [receiveItemInstance: receiveItemInstance])
                return
            }
        }

        receiveItemInstance.properties = params

        if (!receiveItemInstance.save(flush: true)) {
            render(view: "edit", model: [receiveItemInstance: receiveItemInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'receiveItem.label', default: 'ReceiveItem'), receiveItemInstance.id])
        redirect(action: "show", id: receiveItemInstance.id)
    }

    def delete() {
        def receiveItemInstance = ReceiveItem.get(params.id)
        if (!receiveItemInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'receiveItem.label', default: 'ReceiveItem'), params.id])
            redirect(action: "list")
            return
        }

        try {
            receiveItemInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'receiveItem.label', default: 'ReceiveItem'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'receiveItem.label', default: 'ReceiveItem'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def receiveItemInstance = (params.id) ? ReceiveItem.get(params.id) : new ReceiveItem()
        
        if (!receiveItemInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'receiveItem.label', default: 'ReceiveItem'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (receiveItemInstance.version > version) {
                    receiveItemInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'receiveItem.label', default: 'ReceiveItem')] as Object[],
                              "Another user has updated this ReceiveItem while you were editing")
                    render([success: false, messages: receiveItemInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        receiveItemInstance.properties = params
                       
        if (!receiveItemInstance.save(flush: true)) {
            render([success: false, messages: receiveItemInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = ReceiveItem.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render ReceiveItem.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def receiveItemInstance = ReceiveItem.get(id)
        if (!receiveItemInstance)
            render([success: false] as JSON)
        else {
            try {
                receiveItemInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def receiveItemInstance = ReceiveItem.get(params.id)
        if (!receiveItemInstance) {
            render(
                message : "receiveItem.not.found",
            ) as JSON

        }
        else {
            render([receiveItemInstance : receiveItemInstance ] as JSON)
        }
    }

    def generateItemNumber(ReceiveItem receiveItemInstance, Long runningNumber){
        def batch_number_format = 'supplierCode/line/shift/prodDate:yyyyMM/runningNo'
        def separator = '/'
        def segments = batch_number_format.split(Pattern.quote(separator))
        def runningNo = sprintf('%04d',runningNumber)

        def number = ""
        segments.each{ 
            number += translateField(it,receiveItemInstance,runningNo) + separator
        }

        return number[0..-2]
    }

    def translateField(String s,ReceiveItem receiveItemInstance, String runningNo)
    {
        def segment = s.split(Pattern.quote(":"))

        def field 
        if (segment[0]=="supplierCode"){
            field = receiveItemInstance?.supplier?.code
        }else if(segment[0]=="prodDate"){
            def format=segment[1]
            field = receiveItemInstance?.productionDate?.format(format)
        }else if(segment[0]=="line"){
            field = receiveItemInstance?.productionLine?.toString()
        }else if(segment[0]=="shift"){
            field = receiveItemInstance?.shift?.toString()
        }else if(segment[0]=="runningNo"){
            field = runningNo
        }

        return field
    }

}
