def project = 'REPLACE_WITH_YOUR_PROJECT_ID'
def  appName = 'gceme'
def  feSvcName = "${appName}-frontend"
def  imageTag = "gcr.io/${project}/${appName}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"

pipeline {
  agent {
    kubernetes {
      label 'sample-app'
      defaultContainer 'jnlp'
      yaml """
apiVersion: v1
kind: Pod
metadata:
labels:
  component: ci
spec:
  # Use service account that can deploy to all namespaces
  serviceAccountName: cd-jenkins
  volumes:
  - name: google-cloud-key
    secret:
      secretName: pubsub-key
  containers:
  - name: gcloud
    image: google/cloud-sdk:284.0.0-debian_component_based
    volumeMounts:
    - name: google-cloud-key
      mountPath: /var/secrets/google
      env:
      - name: GOOGLE_APPLICATION_CREDENTIALS
        value: /var/secrets/google/key.json
    command:
    - cat
    tty: true
  - name: kubectl
    image: bitnami/kubectl:1.15.3
    volumeMounts:
    - name: google-cloud-key
      mountPath: /var/secrets/google
      env:
      - name: GOOGLE_APPLICATION_CREDENTIALS
        value: /var/secrets/google/key.json
    command:
    - cat
    tty: true
"""
}
  }
  stages {
    
    stage('Build and push image with Container Builder') {
      steps {
        container('gcloud') {
          sh "PYTHONUNBUFFERED=1 cat /var/secrets/google/key.json"
        }
      }
    }
  }
}