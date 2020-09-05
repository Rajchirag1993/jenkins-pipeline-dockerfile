pipeline {
    agent any
	
environment {

      sonar_url = 'http://172.31.45.230:9000'
      sonar_username = 'admin'
      sonar_password = 'admin'
      nexus_url = '172.31.45.230:8081'
      artifact_version = '0.0.1'

 }
    
    tools {
        jdk 'JAVA_HOME'
        maven 'MAVEN_HOME'
    }

    stages {
        stage('git repo') {
            steps {
             git 'https://github.com/wakaleo/game-of-life.git'
            }
        }
        stage ('maven') {
            steps {
                sh 'mvn clean install -U  -Dmaven.test.skip=true'
              }
            }
		stage ('Sonarqube Analysis'){
           steps {
           withSonarQubeEnv('sonar') {
           sh '''
           mvn clean package org.jacoco:jacoco-maven-plugin:prepare-agent install -Dmaven.test.failure.ignore=false
           mvn -e -B sonar:sonar -Dsonar.java.source=1.8 -Dsonar.host.url="${sonar_url}" -Dsonar.login="${sonar_username}" -Dsonar.password="${sonar_password}" -Dsonar.sourceEncoding=UTF-8
           '''
           }
         }
      }
	    stage ('Publish Artifact') {
          steps {
          nexusArtifactUploader artifacts: [[artifactId: 'gameoflife', classifier: '', file: "/var/lib/jenkins/workspace/jenkins-sonar-pipeline/gameoflife-build/target/gameoflife-build-1.0-SNAPSHOT.jar", type: 'jar']], credentialsId: '4daeaa53-5e78-465f-8892-59c2f9838b9e', groupId: 'com.wakaleo.gameoflife', nexusUrl: "${nexus_url}", nexusVersion: 'nexus3', protocol: 'http', repository: 'jar_repo', version: "${artifact_version}"
            }
          }
		stage ('Docker build') {   
	      steps {
	     sh '''
	     cd ${WORKSPACE}/jenkins-pipeline-dockerfile
	     docker build -t rajesh987/game-of-life-jenkins:v1 --pull=true --file=Dockerfile ${WORKSPACE}
	     
		 '''
	   }
	  }
	stage('Push docker image') {
      steps { 
      sh '''
       docker login --username rajesh987 --password Rajesh@123    
	   docker push rajesh987/game-of-life-jenkins:v1
	   '''  
	}
   }
            
        
        
        
    }
}
