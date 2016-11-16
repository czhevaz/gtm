package com.smanggin.trackingmanagement

import groovy.sql.Sql
import java.sql.PreparedStatement

/**
 * ConnectDBService
 * A service class encapsulates the core business logic of a Grails application
 */
class ConnectDBService {
	def grailsApplication

    static transactional = true

    /* Amatra*/
	def getSqlAmatraConnection() {
	 	def url = grailsApplication.config.dataSource.url
	 	def username = grailsApplication.config.dataSource.username
	 	def password = grailsApplication.config.dataSource.password
	 	def sql = Sql.newInstance(url, username, password, "org.postgresql.Driver") // Sql.newInstance("jdbc:mysql://localhost:3306/sjs?useUnicode=yes&characterEncoding=UTF-8", "root", "", "com.mysql.jdbc.Driver")

	 	print " sync db PAS " 
	 	return sql
	}

    
}
