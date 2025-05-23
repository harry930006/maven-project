pipeline{
    agent any
    tools{
        maven 'loacl maven'
    }
    stages{
        stage ('build'){
            steps{
                bat 'mvn clean package'
            }
        }
    }
}