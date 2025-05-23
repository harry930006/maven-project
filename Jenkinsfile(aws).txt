pipeline {
    agent any

    tools{
        maven 'local maven'
    }

    parameters{
        string(name: 'tomcat_dev', defaultValue: '3.27.217.217', description: 'Staging Server')
        string(name: 'tomcat_prod', defaultValue: '3.106.227.197', description: 'Production Server')
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
                        bat """for /r %%f in (target\\*.war) do scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i G:/Users/Admin/Downloads/tomcat-demo.pem "%%f" ec2-user@${params.tomcat_dev}:/var/lib/tomcat9/webapps"""


                    }
                }

                stage ("Deploy to Production"){
                    steps {
                        bat """for /r %%f in (target\\*.war) do scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i G:/Users/Admin/Downloads/tomcat-demo.pem "%%f" ec2-user@${params.tomcat_prod}:/var/lib/tomcat9/webapps"""


                    }
                }
            }
        }
    }
}