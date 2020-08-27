#!groovy
properties([disableConcurrentBuilds()])

pipeline {
    agent any 
    options {
      timestamps()
    }
    stages {
        stage('Create infrastructure') {
            steps {
              sh 'cd terraform && terraform init && terraform apply -input=false -auto-approve && cd -'
            }
        }

				stage('Install environment by Ansible') {
            steps {
              sh 'cd ansible && ansible-playbook playbook_apache.yml &&	cd -'
            }
				}

				/* stage('Send message by Telegram') {
            steps {              
              telegramSend "SUCCESS: $JOB_NAME - Build # $BUILD_NUMBER"
            } */
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