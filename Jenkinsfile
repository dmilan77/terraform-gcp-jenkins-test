podTemplate(containers: [
    containerTemplate(name: 'terraform', image: 'hashicorp/terraform:0.12.23', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'gcloud', image: 'google/cloud-sdk:284.0.0-debian_component_based', ttyEnabled: true, command: 'cat')
  ]) {

    node(POD_LABEL) {
        stage('Test gcloud ') {
            // git 'https://github.com/jenkinsci/kubernetes-plugin.git'
            container('gcloud') {
                stage('list gcloud project') {
                    sh 'gcloud projects list'
                }
            }
        }

       stage('Test Terraform version ') {
            git url: 'https://github.com/dmilan77/terraform-gcp-jenkins-test.git'
            container('terraform') {
                stage('terraform stage 1 version') {
                    sh """
                    terraform version
                    terraform init
                    """
                }
            }
        }

    }
}