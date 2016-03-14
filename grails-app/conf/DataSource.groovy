dataSource {
    pooled = true
    driverClassName = 'org.postgresql.Driver'
    dialect = org.hibernate.dialect.PostgreSQLDialect
    url = 'jdbc:postgresql://localhost:5432/gtm'
    username = 'postgres'
    password = '123456'
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
            url = "jdbc:postgresql://localhost:5432/gtm"
            driverClassName = 'org.postgresql.Driver'
            username = 'postgres'
            password = '123456'
            dialect = org.hibernate.dialect.PostgreSQLDialect
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:postgresql://localhost:5432/gtm"
            driverClassName = 'org.postgresql.Driver'
            username = 'postgres'
            password = '123456'
            dialect = org.hibernate.dialect.PostgreSQLDialect
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            url = "jdbc:postgresql://localhost:5432/gtm"
            driverClassName = 'org.postgresql.Driver'
            username = 'postgres'
            password = '123456'
            dialect = org.hibernate.dialect.PostgreSQLDialect
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
