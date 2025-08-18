pipeline{
    agent any
    environment {
            DOCKER_IMAGE_NAME = "flaskapp"
            DOCKER_IMAGE_TAG = "${env.BUILD_NUMBER}" // Or a more complex tag, e.g., "v1.${env.BUILD_NUMBER}"
        }
    stages{
        stage('Checkout Code'){
            steps{
                script {
                    // Checkout the code from the repository
                    git url: 'https://github.com/Shilpa40/Two-Tier-FlaskApp-Docker.git',
                    branch: 'main'
                }
            }
        }

        stage('Docker Login') {
                steps {
                    script {
                        // Login to Docker Hub using credentials stored in Jenkins
                        withCredentials([usernamePassword(credentialsId: 'DockerHubCred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_TOKEN')]) {
                            sh "docker login -u ${env.DOCKER_USER} -p ${env.DOCKER_TOKEN}"
                        }
                    }
                }
            }
        stage('Build Docker Image'){
            steps{
                script {
                    // Build the Docker image
                    sh "docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} ."
                }
            }
        }
        
        stage('Tag Docker Image'){
            steps{
                script {
                    // Tagging the Docker image
                    sh "docker tag ${DOCKER_IMAGE_NAME}:$Build_NUMBER index.docker.io/shilpabains/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                }
            }
        }

        stage('Push Docker Image to Docker Hub'){
            steps{
                script {
                    // Push the Docker image to Docker Hub
                    sh "docker push index.docker.io/shilpabains/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                }
            }
        }

        stage('Deploy to Docker Compose'){
            steps{
                script {
                    // Deploy the application using Docker Compose
                    sh "DOCKER_IMAGE_TAG=${DOCKER_IMAGE_TAG} docker-compose up -d --build flask-app"
                }
            }
        }
    }
}