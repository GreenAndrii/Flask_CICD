#!groovy
properties([disableConcurrentBuilds()])

pipeline {
    agent any 
    options {
      timestamps()
    }
    stages {
/*      
        stage('Launch main.yml with terraform module') {
          steps {
            sh 'ansible-playbook main.yml'
          }
        }
*/ 
        stage('Create infrastructure by Terraform') {
          withCredentials([usernamePassword(credentialsId: 'aws-key', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
    

            steps {
              sh 'cd terraform && terraform init && terraform apply -input=false -auto-approve && cd -'
            }
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

    post {

      success {
        telegramSend "SUCCESS: $JOB_NAME - Build # $BUILD_NUMBER"
      }

      failure {
        telegramSend "FAILURE: $JOB_NAME - Build # $BUILD_NUMBER"
      }
    }
}