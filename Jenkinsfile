@Library('lokeshsharedlibs') _
node{
    
    def mavenHome = tool name: 'maven3.8.7'
    
    timestamps {
    // some block
    }

try {
    stage('checkoutcode'){
        sendSlackNotifications('STARTED')
       git branch: 'development', credentialsId: '354bd8a8-52bc-4e7d-b856-35c7e7570d8d', url: ' https://github.com/lokeshsgithub/maven-employee-web-application.git'
    }  
    
    stage('Build'){
        sh "${mavenHome}/bin/mvn clean package"
    }
   
   stage('Executing the sonarqube report'){
       sh "${mavenHome}/bin/mvn clean sonar:sonar"
   }
   
   stage('uploading the artifacts into nexus'){
       sh "${mavenHome}/bin/mvn clean deploy"
   }
    stage('Deploy into tomcat server'){
        sshagent(['824ba308-36cc-42dc-b653-403ffc7b6a09']) {
           sh "scp -o stricthostkeychecking=no target/employee-application.war ec2-user@172.31.32.229:/opt/apache-tomcat-9.0.70/webapps"
        }
    }
 
    
}//try closing
    
    catch (e) {
        currentBuild.result="FAILED"
    }
    
    finally {
        sendSlackNotifications(currentBuild.result)
    }
          
 
   
}//node closed

 
