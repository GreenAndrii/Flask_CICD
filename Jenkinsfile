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
            steps {
              sh 'cd terraform && terraform init && terraform apply -input=false -auto-approve && cd -'
            }
        }

        /*
        stage('Install environment by Ansible') {
            steps {
              sh 'cd ansible && ansible-playbook playbook_flask.yml &&	cd -'
            }
        }
        */

        
    post {

      success {
        telegramSend "SUCCESS: $JOB_NAME - Build # $BUILD_NUMBER"
      }

      failure {
        telegramSend "FAILURE: $JOB_NAME - Build # $BUILD_NUMBER"
      }
    }
  }
}