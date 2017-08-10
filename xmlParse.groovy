doc = new XmlSlurper().parse("/var/lib/jenkins/roles.xml")
def userMap = [:]


doc.employee.each
{
 	userMap.put("${it.email}","${it.role}")
}
userMap.each { entry ->
    println "Name: $entry.key Age: $entry.value"
}
