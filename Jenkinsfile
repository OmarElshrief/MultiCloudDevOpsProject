@Library('java-shared-library') _

pipeline {
    agent any

    environment {
        dockerHubCredentialsID = 'Dockerhub'
        imageName = 'omarelsherif/ivolve-grad'
        OPENSHIFT_SERVER = 'https://console-openshift-console.apps.ocp-training.ivolve-test.com'
        GIT_REPO = 'https://github.com/OmarElshrief/MultiCloudDevOpsProject.git'
        OPENSHIFT_PROJECT = 'omarelshrief'
        OPENSHIFT_CREDENTIALS_ID = 'open-shift-service'
        SonarHostUrl = 'http://54.163.65.40:9000'
        SCANNER_HOME = tool 'sonar-qube'

    }
  

    stages {
        
        stage('Run Unit Test') {
            steps {
                script {
                    dir('my-app') {	
                	    runUnitTests()
                    }
        	    }
    	    }
	    }

	    stage('SonarQube CD') {
            steps {
                script {                
                    dir('my-app') {
                        withSonarQubeEnv('sonar-qube') { 
		                sh 'chmod +x gradlew'
                        sh './gradlew sonar -Dsonar.java.binaries=build/classes'
	                    }

                    }
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    dir('my-app'){
                        dockerBuildAndPush(
                        dockerHubCredentialsID, imageName) 
                    }
                }
            }
        }

        stage('Deploy to OpenShift') {
            steps {
                script {
                    dir('openshift'){
                        openshiftDeploy(OPENSHIFT_CREDENTIALS_ID, imageName)
                    }
                }
            }
        }
    }
}
