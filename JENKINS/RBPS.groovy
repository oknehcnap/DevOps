@Grab('org.yaml:snakeyaml:1.17')

import org.yaml.snakeyaml.Yaml
import jenkins.model.*
import hudson.security.*
import java.util.*
import com.michelin.cio.hudson.plugins.rolestrategy.*
import java.lang.reflect.*

def roleType = RoleBasedAuthorizationStrategy.PROJECT
Yaml parser = new Yaml()
def doc = parser.load(("/var/lib/jenkins/roles.yml" as File).text)
def userMap = [:]

doc.each{
 	userMap.put("${it.key}","${it.value}")	
}

def findGuestRoleEntry(grantedRoles, roleName) {
  for (def entry : grantedRoles)
  {
    Role role = entry.getKey()

    if (role.getName().equals(roleName))
    {
      return entry
    }
  }
  return null
}

def authStrategy = Jenkins.getInstance().getAuthorizationStrategy()
RoleBasedAuthorizationStrategy roleAuthStrategy = (RoleBasedAuthorizationStrategy) authStrategy
def grantedRoles = authStrategy.getGrantedRoles(roleType)

for ( e in userMap ) {
   	def roleEntry = findGuestRoleEntry(grantedRoles, "$e.value".toString())
	roleAuthStrategy.assignRole(roleType, roleEntry.getKey(), "$e.key".toString());
}