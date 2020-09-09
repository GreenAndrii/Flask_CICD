#!groovy
properties([disableConcurrentBuilds()])

pipeline {
    agent any
    options {
      timestamps()
    }
    environment {
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    }
    
    stages {

        stage('Create infrastructure by Terraform') {
            steps {
              sh 'cd terraform/dev && terraform init && terraform apply -input=false -auto-approve && cd -'
          }
        }
/*
        stage('Setup environment by Ansible') {
            steps {
              sh 'cd ansible && ansible-playbook playbook_flask.yml &&	cd -'
            }
        }

        stage('Run unit tests') {
            steps {

            }
        }

        stage('Destroy infrastructure by Terraform') {
            steps {
              sh 'cd terraform && terraform destroy -auto-approve && cd -'
            }
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

      always {
        cleanWs()
        sh 'cd terraform/dev && terraform destroy -auto-approve && cd -'
      }
    }
}