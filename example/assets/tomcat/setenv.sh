JAVA_OPTS="-Djava.library.path=/usr/local/apr/lib" 
JAVA_OPTS="$JAVA_OPTS -Dalfresco.home=/usr/local/alfresco" 
JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote"
JAVA_OPTS="$JAVA_OPTS -XX:ReservedCodeCacheSize=128m"
JAVA_OPTS="$JAVA_OPTS -Xms1024M -Xmx1024M" # java-memory-settings
export JAVA_OPTS
			    
