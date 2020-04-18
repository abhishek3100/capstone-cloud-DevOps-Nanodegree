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
/*
		stage('Create kubernetes cluster') {
			steps {
				withAWS(region:'us-east-1', credentials:'Aws') {
					sh '''
						curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
						sudo mv /tmp/eksctl /usr/local/bin
						eksctl version
						eksctl create cluster --name capstone --without-nodegroup
					'''
				}
			}
		}
*/
		stage('Create conf file cluster') {
			steps {
				withAWS(region:'us-east-1', credentials:'Aws') {
					sh '''
						aws eks --region us-east-1 update-kubeconfig --name capstone
					'''
				}
			}
		}

		stage('Set current kubectl context') {
			steps {
				withAWS(region:'us-east-1', credentials:'Aws') {
					sh '''
						kubectl config use-context arn:aws:eks:us-east-1:499046974206:cluster/capstone
					'''
				}
			}
		}
	}
}
