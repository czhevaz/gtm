package com.smanggin.trackingmanagement

import java.text.SimpleDateFormat
import org.codehaus.groovy.grails.plugins.jasper.JasperExportFormat
import org.codehaus.groovy.grails.plugins.jasper.JasperReportDef
import org.springframework.web.multipart.commons.CommonsMultipartFile
import org.apache.commons.io.FileUtils
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.*;

/**
 * PrintService
 * A service class encapsulates the core business logic of a Grails application
 */
class PrintService {

    def jasperService
	/* 
	createFrom kalo di submit lari ke print ini ngambil param dari jrxml
		
	*/

	def print(format, request, response, params, controller, filename){

		
		filename = filename.replaceAll("\\s","")
		def parameters = createParam(format, controller, params)
		def result = []
		
		def reportDef = jasperService.buildReportDefinition(parameters, request, result)

		if(params.view){
			generateReportView(reportDef, response, filename)
		}else{
			generateReport(reportDef, response, filename)
		}
		
	}
	
	def generateReport(reportDef, response, filename){
		def file =filename.trim()
		if (!reportDef.fileFormat.inline && !reportDef.parameters._inline) {			
			response.setHeader("Content-Disposition", "inline; filename=\"${reportDef.parameters._name ?: file}.${reportDef.fileFormat.extension}\"");
			response.setHeader("Content-Type", "${reportDef.fileFormat.mimeTyp}");
			response.setContentType("application/octet-stream")
			response.characterEncoding = "UTF-8"
			response.outputStream << reportDef.contentStream.toByteArray()
		}
	}
	
	def generateReportView(reportDef, response, filename){
		print "filename" + filename
		def file =filename.trim()
		def out = reportDef.contentStream
		response.setHeader("Content-Disposition", "inline; filename=\"${reportDef.parameters._name ?: file}.${reportDef.fileFormat.extension}\"");
		response.setHeader("Expires", "0")
        response.setHeader("Cache-Control",
            "must-revalidate, post-check=0, pre-check=0")
        response.setHeader("Pragma", "public")
        response.setContentType("application/pdf")
        response.setContentLength(out.size())
        OutputStream os = response.getOutputStream()
        out.writeTo(os)
        os.flush()
        os.close()
	}
	
	
	def skipParam = [
		[name:'max'],
		[name:'print'],
		[name:'action'],
		[name:'controller'],
		[name:'format'],
		[name:'offset']
	]
	
	def createParam(format, controller, params){
		Map parameters = new HashMap<>();
		parameters.put("_format", format);
		parameters.put("_file", controller);
		
		Collection<?> keys = params.keySet()
		for (Object key : keys) {
			boolean skip = skipParam.find {
				(it.name == key.toString())
			}

			
			if(skip)
				continue			
			def string =params.get(key)
			
			if(key.toString().endsWith("Date")){	
				string = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(string)
				/*if(key.toString().startsWith("start") && params.get(key).isEmpty())
					string = "1970-01-01"
				if(key.toString().startsWith("end") && params.get(key).isEmpty())

					string = new SimpleDateFormat("yyyy-MM-dd").format(new Date())*/
			}
				
			parameters.put(key.toString(), string)
		}
		return parameters
	}


	def responePrint(out,response){
        response.setHeader("Expires", "0")
        response.setHeader("Cache-Control",
            "must-revalidate, post-check=0, pre-check=0")
        response.setHeader("Pragma", "public")
        response.setContentType("application/pdf")
        response.setContentLength(out.size())
        OutputStream os = response.getOutputStream()
        out.writeTo(os)
        os.flush()
        os.close()
	}


}
