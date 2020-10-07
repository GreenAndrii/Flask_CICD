#!groovy
properties([disableConcurrentBuilds()])
def FAILED_STAGE

pipeline {
    agent any
    options {
      timestamps()
    }
    environment {
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
				DOCKER_USER = credentials('docker_user')
				DOCKER_TOKEN = credentials('docker_token')
				
    }
    
    stages {

        stage('Create infrastructure by Terraform') {
            steps {
							script {
							  FAILED_STAGE=env.STAGE_NAME
                sh 'cd terraform/dev && terraform init && terraform apply -input=false -auto-approve && cd -'
								sh 'sleep 30'
              }
						}
        }

        stage('Setup environment by Ansible') {
            steps {
							script {
							  FAILED_STAGE=env.STAGE_NAME
                sh 'cd ansible && ansible-playbook \
								    --extra-vars docker_user=${DOCKER_USER} docker_token=${DOCKER_TOKEN} \
										--timeout 30 playbook_flask.yml &&	cd -'
              }
						}
        }
/*
        stage('Run unit tests') {
            steps {
							script {
								FAILED_STAGE=env.STAGE_NAME
								sh 'cd microblog/pytest && python test_UI.py && cd -'


		          }
            }
        }

        stage('Deploy infrastructure to production') {
            steps {
							script {
								FAILED_STAGE=env.STAGE_NAME

						  }
            }
        }
*/
    }        

    post {

      success {
        telegramSend "SUCCESS: $JOB_NAME - Build # $BUILD_NUMBER"
      }

      failure {
        telegramSend "FAILURE: $JOB_NAME - Build # $BUILD_NUMBER Stage: ${FAILED_STAGE}"
      }

      always {
/*        sh 'cd terraform/dev && terraform destroy -auto-approve && cd -'  */
        cleanWs()
      }

    }
}