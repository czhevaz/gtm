package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import java.sql.*
/**
 * QcAfkirController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class QcAfkirController {
    def globalService 
    def printService
    def connectDBService
    
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        if(params.trType){
            session.trType = params.trType 
        }else if(session.trType){
            params.trType = session.trType 
        }

        def results = QcAfkir.createCriteria().list(params){
            transactionGroup{
                eq('transactionType',params.trType)
            }
        }
        [qcAfkirInstanceList: results, qcAfkirInstanceTotal: results.totalCount,params:params]
    }

    def create() {
        
        params.trType = session.trType 
        
        def trGroupList =  globalService.trGroupList(session.defaultPlantId,session.trType)
        [qcAfkirInstance: new QcAfkir(params),trGroupList:trGroupList,params:params]
    }

    def save() {

        params.trType = session.trType 

        def qcAfkirInstance = new QcAfkir()
        qcAfkirInstance.properties = params
        qcAfkirInstance.createdBy= session.user
       
        qcAfkirInstance.plant = Plant.findByServerId(params.plant?.serverId)
        qcAfkirInstance.workCenter = WorkCenter.findByServerId(params?.workCenter?.serverId)
        qcAfkirInstance.transactionGroup =TransactionGroup.findByServerId(params?.transactionGroup?.serverId)
        qcAfkirInstance.item = Item.findByServerId(params?.item?.serverId)
        qcAfkirInstance.shift = Shift.findByServerId(params?.shift?.serverId)
        qcAfkirInstance.qCQuestions = QCQuestions.findByServerId(params.qCQuestions.serverId)


        if (!qcAfkirInstance.save(flush: true)) {
            render(view: "create", model: [qcAfkirInstance: qcAfkirInstance])
            return
        }

        println " Insert Value "
        
        if(qcAfkirInstance.qCQuestions.parameterType == 2){

            println " parameterType =  2"
            params."option_${qcAfkirInstance.qCQuestions.sequenceNo}".each{ option->
                def qcp = QCOptions.findByServerId(option)

                def qcDetailInstance = new QCDetail()
                qcDetailInstance.qcMaster = qcAfkirInstance.qCQuestions.qCMaster
                qcDetailInstance.qcQuestions = qcAfkirInstance.qCQuestions
                qcDetailInstance.qcOptions = qcp
                qcDetailInstance.results = qcp?.description
                qcDetailInstance.createdBy = session.user
                qcDetailInstance.reffDocClass = 'QcAfkir'
                qcDetailInstance.refDocId = qcAfkirInstance.serverId
                if(!qcDetailInstance.save(flush:true)){
                println "erorr" +qcDetailInstance.errors
                }
            }
    
        }else{

            println " parameterType !=2"
        
            def qcp = QCOptions.findByServerId(params."option_${qcAfkirInstance.qCQuestions.sequenceNo}")

            println "qcp "+qcp
            def qcDetailInstance  = new QCDetail()
            qcDetailInstance.qcMaster = qcAfkirInstance.qCQuestions.qCMaster
            qcDetailInstance.qcQuestions = qcAfkirInstance.qCQuestions
            qcDetailInstance.qcOptions = qcp
            qcDetailInstance.results = qcp?qcp?.description:params."option_${qcAfkirInstance.qCQuestions.sequenceNo}"
            qcDetailInstance.createdBy = session.user
            qcDetailInstance.reffDocClass = 'QcAfkir'
            qcDetailInstance.refDocId = qcAfkirInstance.serverId
            if(!qcDetailInstance .save(flush:true)){
                println "erorr" +qcDetailInstance.errors
            }
    
        }
        params.serverId = qcAfkirInstance.serverId
        if(qcAfkirInstance.transactionGroup.transactionType == '4'){
		  flash.message = message(code: 'default.created.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), qcAfkirInstance.number])
        }else{
            flash.message = message(code: 'default.created.message', args: [message(code: 'qcRejected.label', default: 'QcAfkir'), qcAfkirInstance.number])            
        }

        redirect(action: "show", params: params)
    }

    def show() {

        params.trType = session.trType 
        println "params.trType"+params.trType
        def qcAfkirInstance = QcAfkir.findByServerId(params.serverId)
        if (!qcAfkirInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), params.id])
            redirect(action: "list")
            return
        }


        def qcval = QCDetail.createCriteria().list(){
            eq('reffDocClass','QcAfkir')\
            eq('refDocId',qcAfkirInstance.serverId)
            eq('qcQuestions',qcAfkirInstance.qCQuestions)
        }

        def qcvalJoin = qcval.results.join(',')

        def yearList=globalService.yearList()
        def monthList=globalService.monthList()

        [qcAfkirInstance: qcAfkirInstance,qcvalJoin:qcvalJoin,yearList:yearList,monthList:monthList,params:params]
    }

    def edit() {
        def qcAfkirInstance = QcAfkir.findByServerId(params.serverId)

        if (!qcAfkirInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), params.id])
            redirect(action: "list")
            return
        }
        def trGroupList =  globalService.trGroupList(session.defaultPlantId,session.trType)
        [qcAfkirInstance: qcAfkirInstance,trGroupList:trGroupList]
    }

    def update() {
        def qcAfkirInstance = QcAfkir.findByServerId(params.serverId)
        if (!qcAfkirInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (qcAfkirInstance.version > version) {
                qcAfkirInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'qcAfkir.label', default: 'QcAfkir')] as Object[],
                          "Another user has updated this QcAfkir while you were editing")
                render(view: "edit", model: [qcAfkirInstance: qcAfkirInstance])
                return
            }
        }
        
        qcAfkirInstance.updatedBy= session.user
       
        qcAfkirInstance.plant = Plant.findByServerId(params.plant?.serverId)
        qcAfkirInstance.workCenter = WorkCenter.findByServerId(params?.workCenter?.serverId)
        qcAfkirInstance.transactionGroup =TransactionGroup.findByServerId(params?.transactionGroup?.serverId)
        qcAfkirInstance.item = Item.findByServerId(params?.item?.serverId)
        qcAfkirInstance.shift = Shift.findByServerId(params?.shift?.serverId)
        qcAfkirInstance.qCQuestions = QCQuestions.findByServerId(params.qCQuestions?.serverId)

        if (!qcAfkirInstance.save(flush: true)) {
            render(view: "edit", model: [qcAfkirInstance: qcAfkirInstance])
            return
        }
        
        //insert qc Detail 
        
        if(qcAfkirInstance.transactionGroup.transactionType == '4'){
            /* write off gallon*/
            println " <<<<<<< write Off >>>>>>> "    
            writeOff(qcAfkirInstance.qcAfkirDetails)

        }
		flash.message = message(code: 'default.updated.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), qcAfkirInstance.serverId])
        redirect(action: "edit", params:[serverId:qcAfkirInstance.serverId])
    }

    def delete() {
        def qcAfkirInstance = QcAfkir.get(params.id)
        if (!qcAfkirInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), params.id])
            redirect(action: "list")
            return
        }

        try {
            qcAfkirInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def qcAfkirInstance = (params.id) ? QcAfkir.get(params.id) : new QcAfkir()
        
        if (!qcAfkirInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (qcAfkirInstance.version > version) {
                    qcAfkirInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'qcAfkir.label', default: 'QcAfkir')] as Object[],
                              "Another user has updated this QcAfkir while you were editing")
                    render([success: false, messages: qcAfkirInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        qcAfkirInstance.properties = params
                       
        if (!qcAfkirInstance.save(flush: true)) {
            render([success: false, messages: qcAfkirInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = QcAfkir.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render QcAfkir.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def qcAfkirInstance = QcAfkir.get(id)
        if (!qcAfkirInstance)
            render([success: false] as JSON)
        else {
            try {
                qcAfkirInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def qcAfkirInstance = QcAfkir.get(params.id)
        if (!qcAfkirInstance) {
            render(
                message : "qcAfkir.not.found",
            ) as JSON

        }
        else {
            render([qcAfkirInstance : qcAfkirInstance ] as JSON)
        }
    }

    def writeOff(qcAfkirDetails){
        def res =true
        qcAfkirDetails.each{
          
            def item = Gallon.findByServerId(it.gallon?.serverId)
            println "gallon>>>>>>> " + item
            item.writeOff = 1
            item.updatedBy = session.user
            
            println " horasssss "


            if(!item.save(flush:true)){
                println "save Gallon errors " +  it.gallon.errors
                res = false
            }
            
        }
        return res
    }

    /**
        Reject Report
    **/
    def report(){
        def view = params.report        
        if(params.report){
            render(view: "${view}",params:params)
        }
    }
    
    def rejectedAnalysis(){
        def startDate = globalService.correctDateTime(params.startDate)
        def endDate = globalService.correctDateTime(params.endDate)
        def filterDate = globalService.filterDate(startDate, endDate)
        def process = Process.findByServerId(params.processServerId)
        def plant = Plant.findByServerId(params.plantServerId)
        
        def line = Line.createCriteria().list(){
            le('serverId','${params.line2}')
            ge('serverId','${params.line}')
        }

        def qcAfkirQuestions = QcAfkir.createCriteria().listDistinct(){
            transactionGroup{
                eq('transactionType',params.trType)
            }
            eq('plant',plant)
            projections {
                groupProperty("qCQuestions")
            }
        }

        def line1 = Line.findByServerId(params.line1ServerId)
        def listLine = []

        def mapLine=[:]
        mapLine.put('lineName','Line 1')
        def listQuestion = []
        def listValQs=[]
        
        def workCenter = WorkCenter.createCriteria().list(){
            eq('line',line1)    
            eq('plant',plant)
       
        }
        def dataSet = [:]
        def labelname = []
        def val = []
        qcAfkirQuestions.each{question ->
            def mapQuestion=[:]
            mapQuestion.put('questionName',question.parameterDesc)
            def qcOptions = QCOptions.findAllByQCQuestions(question)
            def lisOption=[]
            
            qcOptions.each{ option->
                def mapOption=[:]
                mapOption.put('optionName',option?.description)
                mapOption.put('optionId',option?.serverId)
                def qcDetails=countTotalItem(workCenter,option,filterDate,question,params)
                
                listValQs.push(['val':qcDetails,'optionId':option?.serverId,'questioId':question?.serverId,'trType':params.trType])

                lisOption.push(mapOption)
                labelname.push(question.parameterDesc+' '+option?.description)
            }

            if(lisOption.size() == 0){
                def qcDetails=countTotalItem(workCenter,null,filterDate,question,params) 
                listValQs.push(['val':qcDetails,'optionId':null,'questioId':question?.serverId,'trType':params.trType])
                labelname.push(question.parameterDesc+' other')
            }

            mapQuestion.put('lisOption',lisOption) 
            listQuestion.push(mapQuestion)
            
        }
        
        mapLine.put('listQuestion',listQuestion)
        mapLine.put('listValQs',listValQs)
        listLine.push(mapLine)
        dataSet.put('labelname',labelname)
        dataSet.put('listValQs',listValQs)

        println "dataSet" +listValQs

        render([success:true ,results:listLine,dataSet:dataSet] as JSON)            
    }    

    def countTotalItem(workCenter,qcOptions,filterDate,qcQuestion,params){
        
        def qcDetails = QCDetail.createCriteria().list(){       
            eq('qcQuestions',qcQuestion)
            if(qcOptions){
                eq('qcOptions',qcOptions)    
            }else{
                isNull('qcOptions')   
            }     
            
        }

        def listAfkir=[]
        qcDetails.each{
            if(it.reffDocClass == 'QcAfkir'){
                def refDocId = it.refDocId
               // println "refDocId " +it.refDocId
                def qcAfkirs = QcAfkir.createCriteria().list(){
                    transactionGroup{
                        eq('transactionType',params.trType)
                    }
                    eq('serverId',refDocId)  
                }    
                if(qcAfkirs){
                    listAfkir.push(qcAfkirs[0])    
                }
                
            }
        }
        
        def count=0
        if(listAfkir.size() > 0){

            def qcAfkirDetails = QcAfkirDetail.createCriteria().list(){
            'in'('qcAfkir',listAfkir)
            }
            println "listAfkir true" +listAfkir
            count = qcAfkirDetails.size() 
        }
        
        return count
        
    }

    def rejectedAnalysisVendor(){
        if(params.trType){
           session.trType =  params.trType
        }

        def startDate = globalService.correctDateTime(params.startDate)
        def endDate = globalService.correctDateTime(params.endDate)
        def filterDate = globalService.filterDate(startDate, endDate)
        def plant = Plant.findByServerId(params.plantServerId)
        def supplier = Supplier.findByServerId(params.supplierId)
        def item = Item.findByServerId(params.itemId)
        
        def suppliers = Supplier.createCriteria().list(){
            if(params.supplierId != ''){
                eq('serverId',params.supplierId)
            }
        } 

        def qcAfkir = QcAfkir.createCriteria().list(){
            eq('plant',plant)
            eq('item',item)
            transactionGroup{
                eq('transactionType',session.trType)
            }
            ge('date', filterDate.start)
            le('date', filterDate.end)
        }

        def conSqlAmatra = connectDBService?.getSqlAmatraConnection()
        def start= new java.sql.Timestamp(filterDate.start.getTime())
        def end= new java.sql.Timestamp(filterDate.end.getTime())
        def sqlQueryAll = "select * from vrejectanalysis where transaction_type =$session.trType and item_id = $item.serverId and plant_id = $plant.serverId and date between $start and $end"

        if(params.supplierId){
            sqlQueryAll += "and supplierid = $params.supplierId"
        }

        def supplierList = []
        def optionList = []
        
        conSqlAmatra?.eachRow(sqlQueryAll){ row ->  
            def mapSupp = ['suppliername':row.suppliername,'supplierid':row.supplierid]
            supplierList.push(mapSupp)
            optionList.push(row.actual_condition)
         
        }
        /* sort asc */
        optionList.sort { 
            it
        }

        def list = []
        supplierList.unique().each{ supp ->
            def i= 0
            
            def mappSupp = [:]    
            mappSupp.put('supplierName',supp.suppliername)
            def val = []
            val.push(supp.suppliername)
            optionList.unique().each{
                def sqlQuery = "select count(*) as count from vrejectanalysis where transaction_type =$session.trType and item_id = $item.serverId and plant_id = $plant.serverId and date between $start and $end and supplierid = $supp.supplierid and actual_condition = $it"
                conSqlAmatra?.eachRow(sqlQuery){ row ->
                   println row
                   val.push(row.count)
                }
                
                
            } 
            mappSupp.put('listValQs',val)
            list.push(mappSupp)
        }


        
        //println conSqlAmatra?.eachRow(sqlQueryAll)

        /*def qcAfkirQuestions = QcAfkir.createCriteria().listDistinct(){
            transactionGroup{
                eq('transactionType',params.trType)
            }            
            eq('plant',plant)
            projections {
                groupProperty("qCQuestions")
            }
        }
        
        def listSupplier = []
        
        suppliers.each{
            def mapLine=[:]
            mapLine.put('supplierName',it.name)
            def listQuestion = []
            def listValQs=[]    
            listValQs.push(it.name)
            qcAfkirQuestions.each{question ->
                def mapQuestion=[:]
                mapQuestion.put('questionName',question.parameterDesc)
                def qcOptions = QCOptions.findAllByQCQuestions(question)
                def lisOption=[]
                
                qcOptions.each{ option->
                    def mapOption=[:]
                    mapOption.put('optionName',option?.description)
                    mapOption.put('optionId',option?.serverId)
                    def qcDetails=countTotalItemVendor(option,filterDate,question,it,params)
                    listValQs.push(qcDetails)
                    lisOption.push(mapOption)
                }

                if(lisOption.size() == 0){
                    def qcDetails=countTotalItemVendor(null,filterDate,question,it,params) 
                    listValQs.push(qcDetails)
                }

                mapQuestion.put('lisOption',lisOption) 

                listQuestion.push(mapQuestion)
            }    
            mapLine.put('listQuestion',listQuestion)
            mapLine.put('listValQs',listValQs)
            listSupplier.push(mapLine)
        }

        def dataSet = []
        def labelOption =[]
        qcAfkirQuestions.each{question ->
            def datasetMap= [:]
            datasetMap.put('labelname',question.parameterDesc)
            def valCount=[]
            def qcOptions = QCOptions.findAllByQCQuestions(question)
            def lisOption=[]
            
            qcOptions.each{ option->
                def mapOption=[:]
                mapOption.put('optionName',option?.description)
                mapOption.put('optionId',option?.serverId)
                lisOption.push(mapOption)
                def labelOptionMap = [:]
                labelOptionMap.put('optionName',question.parameterDesc+' '+option?.description) 
                def count=[]
                suppliers.each{ s ->
                    def qcDetails=countTotalItemVendor(option,filterDate,question,s,params)
                    count.push(qcDetails)
                }
                labelOptionMap.put('count',count) 
                labelOption.push(labelOptionMap)
            }

            if(lisOption.size() == 0){
                def labelOptionMap = [:]
                labelOptionMap.put('optionName',question.parameterDesc+' Other') 
                def count=[]
                suppliers.each{ s ->
                    def qcDetails=countTotalItemVendor(null,filterDate,question,s,params)
                    count.push(qcDetails)
                }
                labelOptionMap.put('count',count) 
                labelOption.push(labelOptionMap)
            }    

            suppliers.each{ s ->
                def qcAfkirDetail= QcAfkirDetail.createCriteria().list(){
                    qcAfkir{
                        eq('plant',plant)
                        eq('qCQuestions',question)    
                    }
                    gallon{
                        eq('supplier',s)
                    }
                }
                valCount.push(qcAfkirDetail.size());
            }

            datasetMap.put('count',valCount)
            datasetMap.put('lisOption',lisOption) 
            dataSet.push(datasetMap)
        }*/
        list.sort { 
            it.supplierName
        }
        
        
        //render([success:true ,results:listSupplier,dataSet:dataSet,labelOption:labelOption] as JSON)
        render([success:true,results:list,labelOption:optionList] as JSON)
    }

    def countTotalItemVendor(qcOptions,filterDate,qcQuestion,supplier,params){
        def qcDetails = QCDetail.createCriteria().list(){       
            eq('qcQuestions',qcQuestion)
            if(qcOptions){
                eq('qcOptions',qcOptions)    
            }else{
                isNull('qcOptions')   
            }     
            
        }

        def listAfkir=[]
        qcDetails.each{
            if(it.reffDocClass == 'QcAfkir'){
                def refDocId = it.refDocId
               // println "refDocId " +it.refDocId
                def qcAfkirs = QcAfkir.createCriteria().list(){
                    transactionGroup{
                        eq('transactionType',params.trType)
                    }            
                    eq('serverId',refDocId)  
                }    

                if(qcAfkirs){
                    listAfkir.push(qcAfkirs[0])    
                }
                
            }
        }
        
        def count=0
        if(listAfkir.size() > 0){

            def qcAfkirDetails = QcAfkirDetail.createCriteria().list(){
                'in'('qcAfkir',listAfkir)
                gallon{
                    eq('supplier',supplier)
                }
            }
            println "listAfkir true" +listAfkir
            count = qcAfkirDetails.size() 
        }
        
        return count
    }

    def actionWriteOff(){
        def qcAfkirInstance = QcAfkir.findByServerId(params.serverId)
        if (!qcAfkirInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (qcAfkirInstance.version > version) {
                qcAfkirInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'qcAfkir.label', default: 'QcAfkir')] as Object[],
                          "Another user has updated this QcAfkir while you were editing")
                render(view: "edit", model: [qcAfkirInstance: qcAfkirInstance])
                return
            }
        }
        
        qcAfkirInstance.updatedBy= session.user
       
        if (!qcAfkirInstance.save(flush: true)) {
            render(view: "edit", model: [qcAfkirInstance: qcAfkirInstance])
            return
        }
        
        //insert qc Detail 
        
        if(qcAfkirInstance.transactionGroup.transactionType == '4'){
            /* write off gallon*/
            println " <<<<<<< write Off >>>>>>> "    
            writeOff(qcAfkirInstance.qcAfkirDetails)

        }
        flash.message = message(code: 'default.updated.message', args: [message(code: 'qcAfkir.label', default: 'QcAfkir'), qcAfkirInstance.serverId])
        redirect(action: "create", params:[serverId:qcAfkirInstance.serverId])

    }

    def reportWriteOff(){
        def startDate = globalService.correctDateTime(params.startDate)
        def endDate = globalService.correctDateTime(params.endDate)       
        
        def qcWriteOff = QcAfkir.createCriteria().list(){
            transactionGroup{
                eq('transactionType','4')    
            }            
        } 

        def gallon = QcAfkirDetail.createCriteria().list(){
            'in'('qcAfkir',qcWriteOff)
            
        }

        render([success:true ,results:qcWriteOff] as JSON)            
    }

    def printPdf(){
        
        def file = params.controller
        def plant = Plant.findByServerId(params.plant.serverId)
        if(params.printId){
            def purchaseOrder = QcAfkir.findByServerId(params.printId)
            def filename = purchaseOrder?.number
            file  = filename?.replace("/","")

            params.put('receive_id',params.printId)
            
                
        }else{
            params.controller = params.controller+'List'
        }

        
        if(session.trType == '1'){
            params.put('tittle','Rejection List')
        }else{
            params.put('tittle','Write Off List')
        }

        params.put('plantName',plant.name)
        params.put('trType',session.trType)
        params.put('view',true)
        printService.print("PDF", request.getLocale(), response,params, params.controller,file)
    }

    def printReport(){
        
        def file = params.controller
        if(params.plantId){
            def plant = Plant.findByServerId(params.plantId)
            params.put('plantName',plant?.name)    
        }

        if(params.itemId){
            def item = Item.findByServerId(params.itemId)
            params.put('itemName',item?.name)   
        }

        if(params.supplierId){
            def supplier = Supplier.findByServerId(params.supplierId)
            params.put('supplierName',supplier?.name)   
        }else{
            params.put('supplierName',"All")   
        }

        params.put('tittle',params.entityName)
        params.put('trType',session.trType)
        params.put('view',true)

        printService.print("PDF", request.getLocale(), response,params,'rejectAnalysis',file)
    }
}
