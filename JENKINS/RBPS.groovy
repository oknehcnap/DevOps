//Скрипт для добавления списка людей в Role-Based Strategy plugin.

import jenkins.model.*
import hudson.security.*
import java.util.*
import com.michelin.cio.hudson.plugins.rolestrategy.*
import java.lang.reflect.*
def roleName = "chief" //Имя роли
def roleType = RoleBasedAuthorizationStrategy.GLOBAL // Возможные роли .GLOBAL .PROJECT .SLAVE
def userName = [		//Список пользователей
	"test@test.com",
	"test1@test.com",
	"test2@test.com",
	"test3@test.com",
	"test4@test.com",
	"test5@test.com", 
	"test6@test.com",
	"test7@test.com",
	"test8@test.com",
	"test9@test.com",
	"test10@test.com",
  ]

def findGuestRoleEntry(grantedRoles, roleName) //Проверка существования роли.
{
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

if(authStrategy instanceof RoleBasedAuthorizationStrategy){
  RoleBasedAuthorizationStrategy roleAuthStrategy = (RoleBasedAuthorizationStrategy) authStrategy
  def grantedRoles = authStrategy.getGrantedRoles(roleType) //Объект типа map ролей для roleType
  if (grantedRoles != null)
  {

    def roleEntry = findGuestRoleEntry(grantedRoles, roleName) //Нахождение записи существующей роли roleName.
    if (roleEntry != null)
    {

      def sidList = roleEntry.getValue()
      for (String user : userName){
        if (sidList.contains(user)) //Проверка того, что пользователю уже присвоена роль
        {
          println "User " + user + " already assigned to role " + roleName
        } else {
          println "Adding user " + user + " to role " + roleName
         roleAuthStrategy.assignRole(roleType, roleEntry.getKey(), user); //Присвоение роли
          println "OK"
        }
      }
      Jenkins.instance.save()
    } else {
      println "Unable to find role " + roleName
    }
  } else {
    println "Unable to find grantedRoles for " + roleType
  }
} else {
  println "Role Strategy Plugin not found!"
}