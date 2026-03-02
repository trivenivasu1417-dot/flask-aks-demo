pipeline {
    agent any

    environment {
        // Jenkins credential ID for your Azure SP
        AZURE_CREDENTIALS = credentials('jenkins-pipeline-secret')
        RESOURCE_GROUP = "demo-rg"
        AKS_CLUSTER = "my-aks"
        AZ_CLI = "/usr/bin/az" // full path to Azure CLI
    }

    stages {
        stage('Login to Azure') {
            steps {
                script {
                    sh '''
                        echo "Logging in to Azure..."
                        $AZ_CLI login --service-principal \
                            -u $AZURE_CREDENTIALS_USR \
                            -p $AZURE_CREDENTIALS_PSW \
                            --tenant f9744da2-30d8-40bf-a1cc-f7ac4a8020a9
                        echo "Login successful!"
                    '''
                }
            }
        }

        stage('List Resource Groups') {
            steps {
                sh '$AZ_CLI group list --output table'
            }
        }

        stage('Get AKS Credentials') {
            steps {
                script {
                    sh '''
                        echo "Getting AKS credentials..."
                        $AZ_CLI aks get-credentials \
                            --resource-group $RESOURCE_GROUP \
                            --name $AKS_CLUSTER \
                            --overwrite-existing
                        echo "AKS credentials configured!"
                    '''
                }
            }
        }

        stage('List AKS Pods') {
            steps {
                sh 'kubectl get pods -o wide'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished!'
        }
    }
}
