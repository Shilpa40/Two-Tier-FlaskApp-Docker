pipeline{
    agent any

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
                    sh "docker build -t flaskapp:$BUILD_NUMBER ."
                }
            }
        }
        
        stage('Tag Docker Image'){
            steps{
                script {
                    // Tagging the Docker image
                    sh "docker tag flaskapp:$Build_NUMBER index.docker.io/shilpabains/flaskapp:$BUILD_NUMBER"
                }
            }
        }

        stage('Push Docker Image to Docker Hub'){
            steps{
                script {
                    // Push the Docker image to Docker Hub
                    sh "docker push index.docker.io/shilpabains/flaskapp:$BUILD_NUMBER"
                }
            }
        }

        stage('Deploy to Docker Compose'){
            steps{
                script {
                    // Deploy the application using Docker Compose
                    sh "docker-compose up -d --build flask-app"
                }
            }
        }
    }
}