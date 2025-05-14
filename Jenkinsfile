pipeline {
    agent any

    tools{
        maven 'local maven'
    }

    parameters{
        string(name: 'tomcat_dev', defaultValue: '52.62.38.169', description: 'Staging Server')
        string(name: 'tomcat_prod', defaultValue: '13.210.234.181', description: 'Production Server')
    }

    triggers {
         pollSCM('* * * * *')
     }

     stages{
        stage('Build'){
            steps {
                bat 'mvn clean package'
            }
            post {
                success {
                    echo '开始存档...'
                    archiveArtifacts artifacts: '**/target/*.war'
                }
            }
        }

     stage ('Deployments'){
            parallel{
                stage ('Deploy to Staging'){
                    steps {
                        bat "scp -i /Users/gaoyan/Documents/SunnyDemo/dev/tomcat-demo.pem.txt **/target/*.war ec2-user@${params.tomcat_dev}:/var/lib/tomcat9/webapps"
                    }
                }

                stage ("Deploy to Production"){
                    steps {
                        bat "scp -i /Users/gaoyan/Documents/SunnyDemo/dev/tomcat-demo.pem.txt **/target/*.war ec2-user@${params.tomcat_prod}:/var/lib/tomcat9/webapps"
                    }
                }
            }
        }
    }
}