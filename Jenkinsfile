pipeline{
    agent any
    tools{
        maven 'local maven'
    }
    stages{
        stage ('build'){
            steps{
                bat 'mvn clean package'
            }
        }
    }
}