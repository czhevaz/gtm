dataSource {
    pooled = true
    driverClassName = 'com.mysql.jdbc.Driver'
    dialect = org.hibernate.dialect.MySQL5InnoDBDialect
    url = "jdbc:mysql://localhost/gtm"
    username = 'root'
    password = ''
}

hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update"
            //dbCreate = "create-drop"
            url = "jdbc:mysql://localhost/gtm"
            driverClassName = 'com.mysql.jdbc.Driver'
            username = 'root'
            password = ''
            dialect = org.hibernate.dialect.MySQL5InnoDBDialect
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://localhost/gtm"
            driverClassName = 'com.mysql.jdbc.Driver'
            username = 'root'
            password = ''
            dialect = org.hibernate.dialect.MySQL5InnoDBDialect
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://localhost/gtm"
            driverClassName = 'com.mysql.jdbc.Driver'
            username = 'root'
            password = ''
            dialect = org.hibernate.dialect.MySQL5InnoDBDialect
            pooled = true
            properties {
               maxActive = -1
               minEvictableIdleTimeMillis=1800000
               timeBetweenEvictionRunsMillis=1800000
               numTestsPerEvictionRun=3
               testOnBorrow=true
               testWhileIdle=true
               testOnReturn=true
               validationQuery="SELECT 1"
            }
        }
    }
}
