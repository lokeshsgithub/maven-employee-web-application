node{
    
    def mavenHome = tool name: 'maven3.8.7'
    
    timestamps {
    // some block
    }

try {
    stage('checkoutcode'){
        sendslacknotifications('STARTED')
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
        sendslacknotifications(currentBuild.result)
    }
          
 
   
}//node closed

def sendslacknotifications(String buildStatus = 'STARTED') {
  // build status of null means success
  buildStatus =  buildStatus ?: 'SUCCESS'

  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
  def summary = "${subject} (${env.BUILD_URL})"

  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (buildStatus == 'SUCCESSFUL') {
    color = 'GREEN'
    colorCode = '#00FF00'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
  }

  // Send notifications
  slackSend (color: colorCode, message: summary)
}
