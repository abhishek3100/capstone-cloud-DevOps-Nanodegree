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
						docker build -t abhishek3100/capstone .
					'''
				}
			}
		}
        stage('Push Image To Dockerhub') {
			steps {
				withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'DockerID', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
					sh '''
						docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
						docker push abhishek3100/capstone
					'''
				}
			}
		}

		stage('Create kubernetes cluster') {
			steps {
				withAWS(region:'us-east-1', credentials:'Aws') {
					sh '''
						curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
						sudo mv /tmp/eksctl /usr/local/bin
						eksctl version
						eksctl create cluster \
						--name capstonecluster \
						--version 1.13 \
						--nodegroup-name standard-workers \
						--node-type t2.small \
						--nodes 2 \
						--nodes-min 1 \
						--nodes-max 3 \
						--node-ami auto \
						--region us-east-1 \
						--zones us-east-1a \
						--zones us-east-1b \
						--zones us-east-1c \
					'''
				}
			}
		}
	}
}
