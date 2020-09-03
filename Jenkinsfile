#!groovy
properties([disableConcurrentBuilds()])

pipeline {
    agent any 
    options {
      timestamps()
    }
		
    stages {

        stage('Create infrastructure by Terraform') {
            steps {
							withCredentials([[
                                $class           : 'AmazonWebServicesCredentialsBinding',
                                credentialsId    : 'AWS_ACCOUNT_ID_DEV',
                                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                        ]]) {
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

				stage('Run unit tests') {
					  steps {

						}
				}
*/
        stage('Destroy infrastructure by Terraform') {
            steps {
							withCredentials([[
                                $class           : 'AmazonWebServicesCredentialsBinding',
                                credentialsId    : 'AWS_ACCOUNT_ID_DEV',
                                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                        ]]) {
              sh 'cd terraform && terraform destroy -auto-approve && cd -'
            }
					}
        }
		}
		  		

    post {

      success {
        telegramSend "SUCCESS: $JOB_NAME - Build # $BUILD_NUMBER"
      }

      failure {
				script{
        telegramSend "FAILURE: $JOB_NAME - Build # $BUILD_NUMBER"
				withCredentials([[
                                $class           : 'AmazonWebServicesCredentialsBinding',
                                credentialsId    : 'AWS_ACCOUNT_ID_DEV',
                                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                        ]]) {
              sh 'cd terraform && terraform destroy -auto-approve && cd -'
            }
				}
      }
    }
}