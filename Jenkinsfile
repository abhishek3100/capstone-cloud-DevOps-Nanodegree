pipeline{
    agent any
    stages{
        stage('Lint HTML'){
            steps {
                sh 'tidy -q -e *.html'
				echo "Linting Done"
            }
        }
        stage('Build Docker Image') {
			steps {
				withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'DockerID', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
					sh '''
						docker build -t abhishek/capstone .
					'''
				}
			}
		}
	}
}
