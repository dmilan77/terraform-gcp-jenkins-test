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
    image: gcr.io/cloud-builders/gcloud
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
    image: gcr.io/cloud-builders/kubectl
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
          sh "PYTHONUNBUFFERED=1 gcloud projects list"
        }
      }
    }
  }
}