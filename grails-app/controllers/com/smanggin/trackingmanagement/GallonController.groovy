package com.smanggin.trackingmanagement


import com.itextpdf.text.Document
import com.itextpdf.text.DocumentException
import com.itextpdf.text.PageSize
import com.itextpdf.text.Paragraph
import com.itextpdf.text.pdf.PdfWriter
import com.itextpdf.text.Phrase
import com.itextpdf.text.Rectangle
import com.itextpdf.text.pdf.PdfPCell
import com.itextpdf.text.pdf.PdfPTable
import com.itextpdf.text.Chunk
import com.itextpdf.text.Font
import com.itextpdf.text.FontFactory
import com.itextpdf.text.Element
import com.itextpdf.text.Image
import com.itextpdf.text.BaseColor

import org.apache.commons.codec.binary.Base64;
import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import groovy.time.*
/**
 * GallonController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class GallonController {
    def globalService
    def printService
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
        def gallonInstance = Gallon.findByServerId(params.serverId)
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
        
        def gallon = Gallon.createCriteria().list(){
            eq('code',params.code)
        }
        def gallonInstance = (gallon.size()>0) ? gallon[0] : new Gallon()
        

        println " gallon" +gallon
 
        if (!gallonInstance) {                     
            println " kadie"
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
        
        if(params.scanItem){
            if(gallon.size > 0 ){
                println 'tesdasdasd'
                render([success: false] as JSON)
            }else{
                println 'gallon ada'
                gallonInstance.properties = params
                gallonInstance.writeOff = false
                gallonInstance.createdBy = session.user
                gallonInstance.item=Item.findByServerId(params.itemId)
                gallonInstance.type = false
                gallonInstance.receiveItem = ReceiveItem.findByServerId(params.receiveId)
                gallonInstance.supplier = gallonInstance.receiveItem?.supplier
                Calendar cal = Calendar.getInstance();
                cal.setTime(gallonInstance.receiveItem?.productionDate);
                //int months = cal.getMonth();
                //int years= cal.getYear();
                println " month "+cal.get(Calendar.MONTH)
                println " year "+cal.get(Calendar.YEAR)
                def month = cal.get(Calendar.MONTH) + 1
                gallonInstance.yearExisting = cal.get(Calendar.YEAR).toString()
                gallonInstance.monthExisting = month.toString()

                if (!gallonInstance.save(flush: true)) {
                    println gallonInstance.errors
                    render([success: false, messages: gallonInstance.errors] as JSON)
                    return
                }
                                
                render([success: true,totalScan:gallonInstance.receiveItem.gallons.size()] as JSON)
            }    

        }else{
            println " params.receiveItem tidak ada" 
        }
        
        
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
        }else if(params.supplierId){
            def c = Gallon.createCriteria()
            def supplier = Supplier.findByServerId(params.supplierId)

            def items = c.list {
                eq('supplier',supplier)
                eq('writeOff',false)
            }

            def results = []
            items.each{
                if(params.operator == 'lt'){
                    if(it.age <= params.variable?.toLong()){
                        results.push(it)
                    }    
                }else if(params.operator == 'ge'){
                    if(it.age >= params.variable?.toLong()){
                        results.push(it)
                    }
                }
            }

            render([data: results,supplierName:supplier.name] as JSON)
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
        def gallonInstance = Gallon.findByServerId(params.serverId)
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
        }else if(params.gallonAging){
            view = "gallonAging"
            render(view: "${view}")
        }
    }

    def newGallon() {
        return ''
    }

    def gallonHistory(){
        
        def startDate = globalService.correctDateTime(params.startDate)
        def endDate = globalService.correctDateTime(params.endDate)
        def filterDate = globalService.filterDate(startDate, endDate)
        def rangeGallon = Gallon.createCriteria().list(){
            le('code',params.gallonCode2)
            ge('code',params.gallonCode)
        }
        def listGalon=[]

        rangeGallon.each{gallon ->

            //def gallon = Gallon.findByCode(params.gallonCode)

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
                map.put('plant',it.plant?.name)
                map.put('line',it.line?.name)
               // map.put('workcenter',it.productionInHeader?.workCenter?.name)
                map.put('transactionGroup',it.transactionGroup?.name)
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

            /*qCHeader.each{
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
            }*/

            def qcAfkir = QcAfkirDetail.createCriteria().list(){
                eq('gallon',gallon)
                /*le('date',filterDate.start)
                ge('date',filterDate.end)*/
            }
            qcAfkir.each{
                def map = [:]
                map.put('date',it.dateCreated)
                map.put('plant',it.qcAfkir?.plant?.name)
                map.put('line',it.qcAfkir?.workCenter?.line?.name)
                map.put('workcenter',it?.qcAfkir?.workCenter?.name)
                map.put('transactionGroup',it.qcAfkir?.transactionGroup?.name)
                map.put('number',it.qcAfkir.number?:'')
                map.put('in',0)
                map.put('out',1)
                def duration = TimeCategory.minus(it.dateCreated,gallon.dateCreated)
                map.put('duration',duration.toString())
                list.push(map)
            }

            def replaceCodes = ReplaceCodeHistory.createCriteria().list(){
                eq('gallon',gallon)
            }

            replaceCodes.each{
                def map = [:]
                map.put('date',it.dateCreated)
                map.put('plant',it?.plant?.name)
                map.put('line','')
                map.put('workcenter','')
                map.put('transactionGroup','Code Replacement')
                map.put('number',it.oldNumber+' -> '+it.newNumber)
                map.put('in',0)
                map.put('out',0)
                def duration = TimeCategory.minus(it.dateCreated,gallon.dateCreated)
                map.put('duration',duration.toString())
                list.push(map)
            }


            def mapReceived = [:]
            mapReceived.put('date',gallon.dateCreated)
            mapReceived.put('plant','')
            mapReceived.put('line','')
            mapReceived.put('workcenter','')
            mapReceived.put('transactionGroup',gallon.receiveItem?.transactionGroup?.name)
            mapReceived.put('number',gallon.receiveItem?gallon.receiveItem.number:'')
            mapReceived.put('in',0)
            mapReceived.put('out',0)
            //def duration = TimeCategory.minus(it.dateCreated,gallon.dateCreated)
            mapReceived.put('duration',0)
            list.push(mapReceived)


            def res= list.sort { 
                it.date
            }

            def listres=[]
            def i=0;
            res.each{
                def mapres = [:]
                mapres.put('date',it.date)
                mapres.put('gallonDate',gallon.dateCreated)
                mapres.put('plant',it.plant)
                mapres.put('line',it.line)
                mapres.put('workcenter',it.workcenter?:'')
                mapres.put('transactionGroup',it.transactionGroup?:'')
                mapres.put('number',it.number?:'')
                mapres.put('in',it.in)
                mapres.put('out',it.out)
                def duration = TimeCategory.minus(res[i].date,res[i-1].date)
                if(i>1){
                    mapres.put('duration',duration.toString())    
                }else{
                    mapres.put('duration',it.duration)    
                }
                listres.push(mapres)
                i++
            }

            
            if(listres.size() > 0){
                gallonMap.put('gallon',gallon)
                gallonMap.put('listDetail',listres)  
                listGalon.push(gallonMap)  
            }
            

            
            
        }//end each range 
        println " listGalon" +listGalon
        render([success: true ,results:listGalon] as JSON)
    }

    def gallonAutoComplete(){
        //println "params" +params
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

    /**
    report Gallon Aging
    **/
    def gallonAging(){
        println params.supplierId
        def suppliers = Supplier.createCriteria().list(){
            if(params.supplierId != ''){
                eq('serverId',params.supplierId)
            }
        } 

        def parameter1 = params.parameter1.toLong()
        def parameter2 = params.parameter2.toLong()
        def parameter3 = params.parameter3.toLong()

        def list=[]

        def areaChartData = []
        if(suppliers){
            suppliers.each{
                def map=[:]
                map.put('supplierId',it.serverId)
                map.put('supplierName',it.name)
                map.put('condition1',countAge(it,parameter1,null,'lt'))
                map.put('condition2',countAge(it,parameter2,parameter1,'bt'))
                map.put('condition3',countAge(it,parameter3,parameter2,'bt'))
                map.put('condition4',countAge(it,parameter3,null,'ge'))
                list.push(map)
            }
        }

        //println "" + list
        if(params.printToPdf == "true"){
            if(params.supplierId != ''){
                params.supplierName = suppliers[0]?.name 
            }else{
                params.supplierName = 'All'
            }

            printPdf(list,params)
        }else{
            render([success: true ,results:list] as JSON)
        }

        
    } 

    def countAge(supplier,variable1,variable2,operator){
        def gallon =  Gallon.createCriteria().list(){
            eq('supplier',supplier)
            eq('writeOff',false)
        }
        
        def count=0
        gallon.each{
            if(operator == 'lt'){
                if(it.age <= variable1){
                    count++
                }

            }else if(operator == 'bt'){
                if(it.age >= variable1 && it.age <= variable2){
                    count++
                }
            }else if(operator == 'ge'){
                if(it.age >= variable1){
                    count++
                }
            }
            
        }

        return count
    }


    def printPdf(data,params){
        
        def dataUrl = params.image
        String encodingPrefix = "base64,";
        int contentStartIndex = dataUrl.indexOf(encodingPrefix) + encodingPrefix.length();
        byte[] imageData = Base64.decodeBase64(dataUrl.substring(contentStartIndex));

        ByteArrayOutputStream out = new ByteArrayOutputStream()

        Document document = new Document(PageSize.A4.rotate(), 20, 20, 20, 20)
            // step 2
            
        PdfWriter writer = PdfWriter.getInstance(document, out)
        writer.setPdfVersion(PdfWriter.VERSION_1_5)
        writer.setViewerPreferences( PdfWriter.PageLayoutSinglePage)
        // step 3
        document.open()

        // step 4
        String date = new Date().format( 'dd/MM/yyyy HH.mm.ss' )

        document.add(paragraphRight(date,"ALIGN_CENTER",8))    
        document.add(paragraph("Report Item(s) Aging","ALIGN_CENTER",24))
        document.add(Chunk.NEWLINE)
        document.add(paragraphLeft("Supplier   : "+params.supplierName,"ALIGN_CENTER",12))
        document.add(paragraphLeft("Parameter1 : "+ params.parameter1,"ALIGN_CENTER",12))
        document.add(paragraphLeft("Parameter2 : "+ params.parameter2,"ALIGN_CENTER",12))
        document.add(paragraphLeft("Parameter3 : "+ params.parameter3,"ALIGN_CENTER",12))
        document.add(Chunk.NEWLINE)

        PdfPTable table = createTableDetail(data,params)
        document.add(table)
        table.setSpacingBefore(10)
        table.setSpacingAfter(10)

        document.add(Chunk.NEWLINE)
        document.add(Chunk.NEWLINE)
        document.add(paragraph("Chart Item(s) Aging","ALIGN_CENTER",24))
        document.add(Chunk.NEWLINE)

        Image image = Image.getInstance(imageData);
        image.scaleToFit(600, 600);
        document.add(image);

        // step 5
        document.close()

        /* view PDF to browser */
        printService.responePrint(out,response)

    }

    /* ITEXT PDF Properties */

    def cells(text,header){
        PdfPCell cell;
        cell = new PdfPCell(phrase(text,10));
        
        cell.setBackgroundColor(BaseColor.GRAY);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER); 
        
        return cell   
    }

    def cellsRight(text){
        PdfPCell cell;
        cell = new PdfPCell(phrase(text,10));
        
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT); 
        
        return cell   
    }

    def paragraph(text,align,size){
       Font font = FontFactory.getFont("Times-Roman",size, Font.NORMAL);
       Paragraph paragraph = new Paragraph(text,font)
       paragraph.setAlignment(Element.ALIGN_CENTER)
       return paragraph
    }

    def paragraphLeft(text,align,size){
       Font font = FontFactory.getFont("Times-Roman",size, Font.NORMAL);
       Paragraph paragraph = new Paragraph(text,font)
       paragraph.setAlignment(Element.ALIGN_LEFT)
       paragraph.setIndentationLeft(50);
       return paragraph
    }

    def paragraphRight(text,align,size){
       Font font = FontFactory.getFont("Times-Roman",size, Font.ITALIC);
       Paragraph paragraph = new Paragraph(text,font)
       paragraph.setAlignment(Element.ALIGN_RIGHT)
       paragraph.setIndentationLeft(75);
       return paragraph
    }   

    def phrase(text,size){
        Font font = FontFactory.getFont("Times-Roman",size, Font.NORMAL);
        Phrase phrase = new Phrase(text,font)
        return phrase
    }

    def createTableDetail(data,parameter){
        PdfPTable table = new PdfPTable(6);
        table.setWidthPercentage(90);
        
        table.setWidths(2f,20f,10f,10f,10f,10f);
        PdfPCell cell;
       
        table.addCell(cells("No",true));
        table.addCell(cells("Supplier",true));
        table.addCell(cells('<'+params.parameter1+ 'th',true));
        table.addCell(cells(params.parameter1+' to '+params.parameter2 + 'th',true));
        table.addCell(cells(params.parameter2+' to '+params.parameter3 + 'th',true));
        table.addCell(cells('>' + params.parameter3 + 'th',true));

        def i=0
        data.each{
            i=i+1
            table.addCell(cellsRight(i.toString()));
            table.addCell(it.supplierName);
            table.addCell(cellsRight(it.condition1.toString()));
            table.addCell(cellsRight(it.condition2.toString()));
            table.addCell(cellsRight(it.condition3.toString()));
            table.addCell(cellsRight(it.condition4.toString()));
        }
        
        return table
    }
    
}
