set /augeas/load/Xml/lens Xml.lns
set /augeas/load/Xml/incl[2] /opt/jboss/wildfly/standalone/configuration/standalone.xml
load

defvar subsystem "/files/opt/jboss/wildfly/standalone/configuration/standalone.xml/server/profile/subsystem[#attribute/xmlns='urn:jboss:domain:datasources:2.0']"
set $subsystem/datasources/datasource/#attribute/pool-name "ENV_VAR_POOL_NAME"
set $subsystem/datasources/datasource/#attribute/jndi-name "java:jboss/datasources/ENV_VAR_POOL_NAME"
set $subsystem/datasources/datasource/connection-url/#text "ENV_VAR_URL"

set $subsystem/datasources/datasource[last()+1]/#attribute/jndi-name "ENV_VAR_POOL_NAME"
defvar ds $subsystem/datasources/datasource[last()]
set $ds/#attribute/pool-name "ENV_VAR_POOL_NAME"
set $ds/#attribute/enabled "true"
set $ds/#attribute/use-java-context "true"
set $ds/connection-url/#text "ENV_VAR_URL"
set $ds/driver/#text "teste"
set $ds/security/user-name/#text "user"
set $ds/security/password/#text "pass"
set $subsystem/datasources/drivers/driver[last()+1]/#attribute/name "oracle"
defvar dr $subsystem/datasources/drivers/driver[last()]
set $dr/#attribute/module "org.jdbc.oracle"
set $dr/xa-datasource-class/#text "org.oracle.jdbc.OracleDataSource"

save
print /augeas//error
