package com.smanggin

/**
 * JqueryDateTagLib
 * A taglib library provides a set of reusable tags to help rendering the views.
 */
class JqueryDateTagLib {
	def jqDatePicker = {attrs, body ->
		def out = out
		def name = attrs.name    //The name attribute is required for the tag to work seamlessly with grails
		def id = attrs.id ?: name
		def minDate = attrs.minDate
		def showDay = attrs.showDay

		def value = attrs.value
		
		
		if(isNotNullNotEmptyNotWhiteSpaceOnlyByGuava(value)){
			value=parseDate(attrs.value?.toString())
		}else{
			value = new Date()
		}

		
		println " value " + value
		def day = value.date 
		def month = value.month + 1
		def year = value.year + 1900

		value = value.format('yyyy-MM-dd')
	 
		//Create date text field and supporting hidden text fields need by grails
		out.println "<div class=\"input-group col-sm-4\">"
		out.println "<span class=\"input-group-addon\"><i class=\"icon-calendar\"></i></span>"
		out.println "<input type=\"text\" name=\"${name}\" id=\"${id}\" value=\"${value}\" class=\"datepicker form-control\" readonly=\"true\" typedata-format='yyyy-mm-dd'/></div>"		
		out.println "<input type=\"hidden\" name=\"${name}_day\" id=\"${id}_day\"  value=\"${day}\"/>"
		out.println "<input type=\"hidden\" name=\"${name}_month\" id=\"${id}_month\"  value=\"${month}\"/>"
		out.println "<input type=\"hidden\" name=\"${name}_year\" id=\"${id}_year\"  value=\"${year}\"/>"
	 
		//Code to parse selected date into hidden fields required by grails
		out.println "<r:require module=\"jquery-ui-dev\"/>"
		out.println "<script type=\"text/javascript\"> \$(document).ready(function(){"
		//out.println "var date = \$(\".datepicker\").datepicker({ format: 'yyyy-mm-dd ', language: 'id',autoclose: true});"	
		out.println "\$(\"#${name}\").on(\"changeDate\", function(e){"

		out.println "\$(\"#${name}_month\").attr(\"value\",new Date(e.date).getMonth() +1);"
		out.println "\$(\"#${name}_day\").attr(\"value\",new Date(e.date).getDate());"
		out.println "\$(\"#${name}_year\").attr(\"value\",new Date(e.date).getFullYear());"

		
		//If you want to customize using the jQuery UI events add an if block an attribute as follows
		if(minDate != null){
			out.println ","
			out.println "minDate: ${minDate}"
		}
		
		if(showDay != null){
			out.println ","
			out.println "beforeShowDay: function(date){"
			out.println	"var day = date.getDay();"
			out.println	"return [day == ${showDay},\"\"];"
			out.println "}"
		}
		
		out.println "});"
		out.println "})</script>"
	}

	def parseDate(String strDate){

        Date output = null
        //SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")
       	if(strDate){
            output= new Date().parse("yyyy-MM-dd hh:mm:ss", strDate)
       	}
        
        return output
    }

	def boolean isNotNullNotEmptyNotWhiteSpaceOnlyByGuava(string)  
	{  
		string = string?.toString()
		return string != null && !string.isEmpty() && !string.trim().isEmpty()
	}
}
