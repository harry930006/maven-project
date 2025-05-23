pipeline{
    agent any
    tools{
        maven 'local maven'
    }
    stages{
        stage ('build'){
            steps{
                bat 'mvn clean package'
                bat "docker build . -t tomactwebapp:${env.BUILD_ID}"
            }
        }
    }
}