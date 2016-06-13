package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import groovy.time.*
/**
 * GallonController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class GallonController {
    def globalService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        //params.max = Math.min(params.max ? params.int('max') : 10, 100)
        if(params.itemId){
            def item = Item.findByServerId(params.itemId)
            session.trackedItem=item.name
        }
        def results = Gallon.createCriteria().list(params){
            if(params.itemId){
                def item1 = Item.findByServerId(params.itemId)
                eq('item',item1)
            }
            
        }
        [gallonInstanceList: results, gallonInstanceTotal: results.totalCount]
    }

    def create() {
        [gallonInstance: new Gallon(params)]
    }

    def save() {
        def gallonInstance = new Gallon()
        gallonInstance.properties = params
        gallonInstance.createdBy = session.user
        gallonInstance.item=Item.findByServerId(params.item?.serverId)
       
        if (!gallonInstance.save(flush: true)) {
            render(view: "create", model: [gallonInstance: gallonInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'gallon.label', default: 'Gallon'), gallonInstance.id])
        redirect(action: "show", id: gallonInstance.id)
    }

    def show() {
        def gallonInstance = Gallon.get(params.id)
        if (!gallonInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'gallon.label', default: 'Gallon'), params.id])
            redirect(action: "list")
            return
        }

        [gallonInstance: gallonInstance]
    }

    def edit() {
        def gallonInstance = Gallon.get(params.id)
        if (!gallonInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'gallon.label', default: 'Gallon'), params.id])
            redirect(action: "list")
            return
        }

        [gallonInstance: gallonInstance]
    }

    def update() {
        def gallonInstance = Gallon.get(params.id)
        if (!gallonInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'gallon.label', default: 'Gallon'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (gallonInstance.version > version) {
                gallonInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'gallon.label', default: 'Gallon')] as Object[],
                          "Another user has updated this Gallon while you were editing")
                render(view: "edit", model: [gallonInstance: gallonInstance])
                return
            }
        }

        gallonInstance.properties = params

        if (!gallonInstance.save(flush: true)) {
            render(view: "edit", model: [gallonInstance: gallonInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'gallon.label', default: 'Gallon'), gallonInstance.id])
        redirect(action: "show", id: gallonInstance.id)
    }

    def delete() {
        def gallonInstance = Gallon.get(params.id)
        if (!gallonInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'gallon.label', default: 'Gallon'), params.id])
            redirect(action: "list")
            return
        }

        try {
            gallonInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'gallon.label', default: 'Gallon'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'gallon.label', default: 'Gallon'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def gallonInstance = (params.id) ? Gallon.get(params.id) : new Gallon()
        
        if (!gallonInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'gallon.label', default: 'Gallon'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (gallonInstance.version > version) {
                    gallonInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'gallon.label', default: 'Gallon')] as Object[],
                              "Another user has updated this Gallon while you were editing")
                    render([success: false, messages: gallonInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        gallonInstance.properties = params
                       
        if (!gallonInstance.save(flush: true)) {
            render([success: false, messages: gallonInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = Gallon.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else if(params.receiveId)
        {
            def c = Gallon.createCriteria()
            def pid = c.list {
                receiveItem{
                    eq('serverId',params.receiveId)        
                }
                
            }
            def results = []
            pid.each {
                results << [it.code, it.dateCreated]
            }
            render([data: results] as JSON)
        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render Gallon.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def gallonInstance = Gallon.get(id)
        if (!gallonInstance)
            render([success: false] as JSON)
        else {
            try {
                gallonInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def gallonInstance = Gallon.get(params.id)
        if (!gallonInstance) {
            render(
                message : "gallon.not.found",
            ) as JSON

        }
        else {
            render([gallonInstance : gallonInstance ] as JSON)
        }
    }

    def report(){
        def view

        if(params.newGallon){
            view = "newGallon"
            render(view: "${view}")
        } else if(params.gallonHistory) {
            view = "gallonHistory"
            render(view: "${view}")
        } else if (params.lineBalance) {
            view = "lineBalance"
            render(view: "${view}")
        }
    }

    def newGallon() {
        return ''
    }

    def gallonHistory(){
        println " params " +params
        def startDate = globalService.correctDateTime(params.startDate)
        def endDate = globalService.correctDateTime(params.endDate)
        def filterDate = globalService.filterDate(startDate, endDate)

        def gallon = Gallon.findByCode(params.gallonCode)
        def productionin = ProductionInDetail.createCriteria().list(){
            eq('gallon',gallon)

            /*productionInHeader{
                le('date',filterDate.start)
                ge('date',filterDate.end)
            }*/
        }        

        def gallonMap =[:]
        def list=[]

        productionin.each{
            def map = [:]
            map.put('date',it.dateCreated)
            map.put('plant',it.productionInHeader?.plant?.name)
            map.put('line',it.productionInHeader?.workCenter?.line?.name)
            map.put('workcenter',it.productionInHeader?.workCenter?.name)
            map.put('transactionGroup',it.productionInHeader?.transactionGroup?.name)
            map.put('number',it.productionInHeader?.number)
            map.put('in',1)
            map.put('out',0)
            def duration = TimeCategory.minus(it.dateCreated,gallon.dateCreated)
            println " duration" +duration
            map.put('duration',duration.toString())
           // map.put('cycletime',)
           list.push(map)
        }

        def qCHeader = QCHeader.createCriteria().list(){
            eq('gallon',gallon)
            /*le('date',filterDate.start)
            ge('date',filterDate.end)*/
        }

        qCHeader.each{
            def map = [:]
            map.put('date',it.dateCreated)
            map.put('plant',it.plant?.name)
            map.put('line',it.workCenter?.line?.name)
            map.put('workcenter',it?.workCenter?.name)
            map.put('transactionGroup',it.transactionGroup?.name)
            map.put('number',it.number)
            map.put('in',0)
            map.put('out',1)
            def duration = TimeCategory.minus(it.dateCreated,gallon.dateCreated)
            map.put('duration',duration.toString())
            list.push(map)
        }

        def res= list.sort { 
            it.date
        }
        def listres=[]
        def i=0;
        res.each{
            def mapres = [:]
            mapres.put('date',it.date)
            mapres.put('plant',it.plant)
            mapres.put('line',it.line)
            mapres.put('workcenter',it.workcenter)
            mapres.put('transactionGroup',it.transactionGroup)
            mapres.put('number',it.number)
            mapres.put('in',it.in)
            mapres.put('out',it.out)
            def duration = TimeCategory.minus(res[i].date,res[i-1].date)
            if(i>0){
                mapres.put('duration',duration.toString())    
            }else{
                mapres.put('duration','0')    
            }
            listres.push(mapres)
            i++
        }

        gallonMap.put('gallon',gallon)
        gallonMap.put('listDetail',listres)
        def listGalon=[]
        listGalon.push(gallonMap)

        
        
        render([success: true ,results:gallonMap] as JSON)
    }

    def gallonAutoComplete(){
        println "params" +params
        def query = {
            or {
                like("code", "%${params.term}%") // term is the parameter send by jQuery autocomplete
            }

            item{
                eq('serverId',params.itemId)
            }
        }

        
        
        def clist = Gallon.createCriteria().list(query) // execute  to the get the list of companies
        def custList = [] // to add each company details

        clist.each {
            def customer = [:] // add to map. jQuery autocomplete expects the JSON object to be with id/label/value.
            
            customer.put("label", it.code)
            customer.put("value", it.code)
            
            
            custList.add(customer) // add to the arraylist
        }

       // println " custList ppp " + custList
        
        render custList as JSON
        
    }

    /** receiving new gallon*/
    def receiving() {

        [gallonInstance: new Gallon(params)]
    }

    def saveReceiving(){

    }
}
