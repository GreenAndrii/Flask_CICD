#!groovy
properties([disableConcurrentBuilds()])

pipeline {
    agent any 
    options {
      timestamps()
    }
		withCredentials([
                        [
                                $class           : 'AmazonWebServicesCredentialsBinding',
                                credentialsId    : 'AWS_ACCOUNT_ID_DEV',
                                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                        ]]) {
    stages {
/*     
        stage('Add credentials to environment') {
          steps {
            sh 'export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID_DEV && export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY_DEV'
          }
        }
*/ 
        stage('Create infrastructure by Terraform') {
            steps {
              sh '
							cd terraform && terraform init && terraform apply -input=false -auto-approve && cd -'
            }
          
        }
/*
        stage('Install environment by Ansible') {
            steps {
              sh 'cd ansible && ansible-playbook playbook_flask.yml &&	cd -'
            }
        }

         stage('Send message by Telegram') {
            steps {              
              telegramSend "SUCCESS: $JOB_NAME - Build # $BUILD_NUMBER"
            } 
*/
		}
			  }		

    post {

      success {
        telegramSend "SUCCESS: $JOB_NAME - Build # $BUILD_NUMBER"
      }

      failure {
        telegramSend "FAILURE: $JOB_NAME - Build # $BUILD_NUMBER"
      }
    }
}