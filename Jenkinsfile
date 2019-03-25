#!/usr/bin/groovy

pipeline {
    agent {
		dockerfile true
	}

    options {
        disableConcurrentBuilds()
    }

    stages {
		
		stage("Test - Unit Test") {
            steps { 
			script {
				docker.build("seyi/myapp:${BUILD_NUMBER}-tests", "--target tests")
				sh "docker images"
			}
			}
		}

        stage("Build") {
            steps { 
			script {
				docker.build("seyi/myapp:${BUILD_NUMBER}")
				sh "docker images"
			}
			}
		}

        stage("Deploy - Dev") {
            steps { deploy('dev') }
		}

	}
}


// steps

def deploy(environment) {

	def containerName = ''
	def port = ''

	if ("${environment}" == 'dev') {
		containerName = "app_dev"
		port = "8888"
	} 
	else {
		println "Environment not valid"
		System.exit(0)
	}

	sh "docker ps -f name=${containerName} -q | xargs --no-run-if-empty docker stop"
	sh "docker ps -a -f name=${containerName} -q | xargs -r docker rm"
	sh "docker run -d -p ${port}:5000 --name ${containerName} seyi/myapp:${BUILD_NUMBER}"

}

def runUnittests() {
	sh "pip3.6 install --no-cache-dir -r ./section_4/code/cd_pipeline/requirements.txt"
	sh "python3.6 section_4/code/cd_pipeline/tests/test_flask_app.py"
}
