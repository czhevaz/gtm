package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * QCHeaderController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class QCHeaderController {
    def globalService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        //params.max = Math.min(params.max ? params.int('max') : 10, 100)
        if(params.trType =='qc'){
            session.trType = '1'
        }
        def results = QCHeader.createCriteria().list(params){}
        [QCHeaderInstanceList: results, QCHeaderInstanceTotal: results.totalCount]
    }

    def create() {
        if(params.trType =='qc'){
            session.trType = '1'
        }

        def transactionGroup = TransactionGroup.createCriteria().list(){
            eq('transactionType',session.trType)
        }

        [QCHeaderInstance: new QCHeader(params),transactionGroup:transactionGroup]
    }

    def save() {
        println "params " + params 
        def QCHeaderInstance = new QCHeader(params)
        QCHeaderInstance.properties = params
        QCHeaderInstance.createdBy= session.user
        QCHeaderInstance.gallon = Gallon.findByCode(params.gallon?.code)
        QCHeaderInstance.plant = Plant.findByServerId(params.plant?.serverId)
        QCHeaderInstance.workCenter = WorkCenter.findByServerId(params?.workCenter?.serverId)
        QCHeaderInstance.transactionGroup =TransactionGroup.findByServerId(params?.transactionGroup?.serverId)
        QCHeaderInstance.item = Item.findByServerId(params?.item?.serverId)
        QCHeaderInstance.shift = Shift.findByServerId(params?.shift?.serverId)

        if (!QCHeaderInstance.save(flush: true)) {
            render(view: "create", model: [QCHeaderInstance: QCHeaderInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'QCHeader.label', default: 'QCHeader'), QCHeaderInstance.id])
        redirect(action: "edit", params: [serverId:QCHeaderInstance?.serverId])
    }

    def show() {
        

        def QCHeaderInstance = QCHeader.findByServerId(params.serverId)
        if (!QCHeaderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCHeader.label', default: 'QCHeader'), params.id])
            redirect(action: "list")
            return
        }

        def processQC = ProcessQC.findAllByProcess(QCHeaderInstance.workCenter?.process)
        println " processQC "+ processQC

        [QCHeaderInstance: QCHeaderInstance,processQCAll:processQC]
    }

    def edit() {
        if(params.trType =='qc'){
            session.trType = '1'
        }
        
        def transactionGroup = TransactionGroup.createCriteria().list(){
            eq('transactionType',session.trType)
        }

        def QCHeaderInstance = QCHeader.findByServerId(params.serverId)
        if (!QCHeaderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCHeader.label', default: 'QCHeader'), params.id])
            redirect(action: "list")
            return
        }

        def processQC = ProcessQC.findAllByProcess(QCHeaderInstance.workCenter?.process)

        [QCHeaderInstance: QCHeaderInstance,processQCAll:processQC,transactionGroup:transactionGroup]
    }

    def update() {
        println "update" + params
        def QCHeaderInstance = QCHeader.findByServerId(params.serverId)
        
        if (!QCHeaderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCHeader.label', default: 'QCHeader'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (QCHeaderInstance.version > version) {
                QCHeaderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'QCHeader.label', default: 'QCHeader')] as Object[],
                          "Another user has updated this QCHeader while you were editing")
                render(view: "edit", model: [QCHeaderInstance: QCHeaderInstance])
                return
            }
        }

        QCHeaderInstance.properties = params

        QCHeaderInstance.updatedBy= session.user
        QCHeaderInstance.gallon = Gallon.findByCode(params.gallon?.code)
        QCHeaderInstance.plant = Plant.findByServerId(params.plant?.serverId)
        QCHeaderInstance.workCenter = WorkCenter.findByServerId(params?.workCenter?.serverId)
        QCHeaderInstance.transactionGroup =TransactionGroup.findByServerId(params?.transactionGroup?.serverId)
        QCHeaderInstance.qcActions = QCActions.findByServerId(params.qcActions?.serverId)
        //QCHeaderInstance.qcOptions = QCOptions.findByServerId(params.qcOptions?.serverId)

        

        if (!QCHeaderInstance.save(flush: true)) {
            //println "<<<<<<<<<<<<<<<<<  errors >>>>>>>>>>>>> "
            render(view: "edit", model: [QCHeaderInstance: QCHeaderInstance])
            return
        }

        def processQCAll = ProcessQC.findAllByProcess(QCHeaderInstance.workCenter?.process)
        
        processQCAll.each{ processQC -> 
           
            processQC?.qcMaster?.qCQuestions.each{
                if(it.parameterType == 2){
                    println " >>>>>>>>>>>>>>>>>> parameterType 2"
                    params."${it.qCMaster?.code}_${it.sequenceNo}".each{ option->
                        def qcp = QCOptions.findByServerId(option)
                      /*  println "-----------------------------"
                        println it
                        println " qcp " + qcp
                        println "-----------------------------"*/
                        def qcDetail = new QCDetail()
                        qcDetail.qcHeader = QCHeaderInstance
                        qcDetail.qcMaster = it.qCMaster
                        qcDetail.qcQuestions = it
                        qcDetail.qcOptions = qcp
                        qcDetail.results = qcp?.description
                        qcDetail.createdBy = session.user
                        if(!qcDetail.save(flush:true)){
                            //println "erorr" +qcDetail.errors
                        }    
                    }
                }else{
                    //println "testing >>>>>>> " + params."${it.qCMaster?.code}_${it.sequenceNo}"
                    def qcp = QCOptions.findByServerId(params."${it.qCMaster?.code}_${it.sequenceNo}")
                    def qcDetail = new QCDetail()
                    qcDetail.qcHeader = QCHeaderInstance
                    qcDetail.qcMaster = it.qCMaster
                    qcDetail.qcQuestions = it
                    qcDetail.qcOptions = qcp
                    qcDetail.results = qcp?qcp.description:params."${it.qCMaster?.code}_${it.sequenceNo}"
                    qcDetail.createdBy = session.user
                    if(!qcDetail.save(flush:true)){
                        //println "erorr" +qcDetail.errors
                    }
                }
                
            }
        }
        
        insertLineBalance(QCHeaderInstance)

		flash.message = message(code: 'default.updated.message', args: [message(code: 'QCHeader.label', default: 'QCHeader'), QCHeaderInstance.id])
        redirect(action: "show", params: [serverId:QCHeaderInstance?.serverId])
    }

    def delete() {
        def QCHeaderInstance = QCHeader.get(params.id)
        if (!QCHeaderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCHeader.label', default: 'QCHeader'), params.id])
            redirect(action: "list")
            return
        }

        try {
            QCHeaderInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'QCHeader.label', default: 'QCHeader'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'QCHeader.label', default: 'QCHeader'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def QCHeaderInstance = (params.id) ? QCHeader.get(params.id) : new QCHeader()
        
        if (!QCHeaderInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'QCHeader.label', default: 'QCHeader'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (QCHeaderInstance.version > version) {
                    QCHeaderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'QCHeader.label', default: 'QCHeader')] as Object[],
                              "Another user has updated this QCHeader while you were editing")
                    render([success: false, messages: QCHeaderInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        QCHeaderInstance.properties = params
                       
        if (!QCHeaderInstance.save(flush: true)) {
            render([success: false, messages: QCHeaderInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = QCHeader.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render QCHeader.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def QCHeaderInstance = QCHeader.get(id)
        if (!QCHeaderInstance)
            render([success: false] as JSON)
        else {
            try {
                QCHeaderInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def QCHeaderInstance = QCHeader.get(params.id)
        if (!QCHeaderInstance) {
            render(
                message : "QCHeader.not.found",
            ) as JSON

        }
        else {
            render([QCHeaderInstance : QCHeaderInstance ] as JSON)
        }
    }


    def insertLineBalance(QCHeaderInstance){
        params.order = params.order ?: 'desc' 
        params.sort = params.sort ?: 'dateCreated' 
        
        def last = LineBalance.createCriteria().list(params){
           maxResults(1)
        }

        def lineBalance = new LineBalance()
        lineBalance.plant = QCHeaderInstance.plant
        lineBalance.line = QCHeaderInstance.workCenter.line
        lineBalance.date = new Date()
        lineBalance.beginQty = last?.endQty[0]?:0
        lineBalance.inQty = 0
        lineBalance.outQty = 1
        lineBalance.endQty = lineBalance.beginQty - 1
        lineBalance.createdBy =session.user
        lineBalance.shift = QCHeaderInstance.shift
        lineBalance.item = QCHeaderInstance.item
        lineBalance.triggerClass = 'QCHeader'
        lineBalance.triggerId = QCHeaderInstance?.serverId

        if(!lineBalance.save(flush:true)){
            println "errors " + lineBalance.errors
        }


    }


    /**
    Report  
    **/
    def report(){
        def view = params.report
        render(view: "${view}")

        /*if(params.report == qcSummary){
            println "======= QC summary ======"
            
            
        } else if(params.report == qcAnalysis) {
            println "======= Qc Annalisys ======"
            views = params.report
            
        } */


    }

    /* QC summary */
    def qcSummary(){
        
        def startDate = globalService.correctDateTime(params.startDate)
        def endDate = globalService.correctDateTime(params.endDate)
        def filterDate = globalService.filterDate(startDate, endDate)
        def line1 = Line.findByServerId(params.line1ServerId)
        def line2 = Line.findByServerId(params.line2Code) 
        def plant = Plant.findByServerId(params.plantServerId)

        def results = QCHeader.createCriteria().list(){
            workCenter{
                eq('line',line1)    
                eq('plant',plant)
            }

//            le('date',filterDate.start)
  //          ge('date',filterDate.end)

        }

        println " results" + results

        def list = []

        results.each{
            
            def hasilQc = hasilQc(it)
            println " hasilQc " + hasilQc
            //it.
            def map = [:]
            map.put('gallonCode',it.gallon?.code)
            map.put('date',it.date)
            map.put('hasilQc',hasilQc)
            map.put('action',it.qcActions?.description?:'')
            map.put('userCreated',it.createdBy)
            
            list.push(map)
        }

        render([success: true ,results:list] as JSON)
    }


    def hasilQc(QCHeaderInstance){
        
        def processQCAll = ProcessQC.findAllByProcess(QCHeaderInstance.workCenter?.process)   
        def listMaster= []
        processQCAll.each{

            def listQuestion = []
            def qcMasters=it.qcMaster
            
            def mapMaster=[:]
            mapMaster.put('name',it.qcMaster?.name)

            
            qcMasters?.qCQuestions?.each{ question ->
                def mapQuestion=[:]
                mapQuestion.put('name',question.parameterDesc)
                
                def results = QCDetail.createCriteria().list(){
                    eq('qcHeader',QCHeaderInstance)
                    eq('qcMaster',qcMasters)
                    eq('qcQuestions',question)
                }

                mapQuestion.put('value',results.results)

                if(results){
                    listQuestion.push(mapQuestion)
                }
            }

            mapMaster.put('value',listQuestion)

            if(listQuestion.size() > 0){
                listMaster.push(mapMaster)    
            }
            
        }

        return listMaster     
    }

    /* END REport WC Summary*/

    def qcAnalysisQuestion(){
        
        def startDate = globalService.correctDateTime(params.startDate)
        def endDate = globalService.correctDateTime(params.endDate)
        def filterDate = globalService.filterDate(startDate, endDate)
        def process = Process.findByServerId(params.processServerId)
        def line1 = Line.findByServerId(params.line1ServerId)
        def plant = Plant.findByServerId(params.plantServerId)

        def processQc = ProcessQC.createCriteria().list(){
            eq('process',process)
        }

        def workCenter = WorkCenter.createCriteria().list(){
            eq('line',line1)    
            eq('plant',plant)
            eq('process',process)
        }

        def listQc=[]
        def listValQc=[]
        processQc.each{
            def mapqc=[:]
            mapqc.put('qcName',it.qcMaster?.name)
            def qCQuestions = QCQuestions.findAllByQCMaster(it.qcMaster)
            def listQuestion = []
            def listValQs=[]
            qCQuestions.each{ question ->
                def mapQuestion=[:]
                mapQuestion.put('questionName',question.parameterDesc)
                def qcOptions = QCOptions.findAllByQCQuestions(question)
                def lisOption=[]
                
                qcOptions.each{ option->
                    def mapOption=[:]
                    mapOption.put('optionName',option?.description)
                    mapOption.put('optionId',option?.serverId)
                    lisOption.push(mapOption)
                    def qcDetails=countTotalItem(workCenter,option,filterDate)
                    listValQs.push(qcDetails)
                }
                
                mapQuestion.put('lisOption',lisOption)    
                if(lisOption.size() == 0){
                    def qcDetails=countTotalItem2(workCenter,question,filterDate) 
                    listValQs.push(qcDetails)
                }

                listQuestion.push(mapQuestion)
            }
            mapqc.put('listQuestion',listQuestion)
            mapqc.put('listValQs',listValQs)
            listQc.push(mapqc)

            println mapqc
        }

       /* def qcDetails=countTotalItem(workCenter,filterDate)
        qcDetails.each{
            println " value " + it[0]?.serverId
            def mamval=[:]
            mamval.put('optionName',it[0]?.description)
            mamval.put('optionId',it[0]?.serverId)
            mamval.put('optionValue',it[1])
            listValQc.push(mamval)
        }*/

        
        render([success: true ,results:listQc,qcVal:listValQc] as JSON)        
    }

    def countTotalItem(workCenter,qcOptions,filterDate){
        def qcHeaders = QCHeader.createCriteria().list(){
            //le('date',filterDate.end)
            //ge('date',filterDate.start)
            'in'('workCenter',workCenter)
        }

        
        
        def qcDetail = QCDetail.createCriteria().list(){
            'in'('qcHeader',qcHeaders)
            eq('qcOptions',qcOptions)
            projections{
                //groupProperty('qcOptions')
                count('serverId')
            }
        }
        //println qcDetail
        return qcDetail[0]
        
    }

    def countTotalItem2(workCenter,qcQuestion,filterDate){
        def qcHeaders = QCHeader.createCriteria().list(){
            //le('date',filterDate.end)
            //ge('date',filterDate.start)
            'in'('workCenter',workCenter)
        }

        def qcDetail = QCDetail.createCriteria().list(){
            'in'('qcHeader',qcHeaders)
            eq('qcQuestions',qcQuestion)
            isNull('qcOptions')
        }
        return qcDetail.size()
        
    }

}
