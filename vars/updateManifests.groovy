#!/usr/bin/env groovy

/**
 * Jenkins Shared Library Step: updateManifests
 * Implements GitOps deployment trigger:
 * 1. Update image tag inside target Kubernetes deployment manifest
 * 2. Commit and push modified manifest back to GitHub repo for ArgoCD sync
 */
def call(Map config = [:]) {
    def imageName      = config.get('imageName', 'mohadevv/ivolve-app')
    def imageTag       = config.get('imageTag', "${env.BUILD_NUMBER}")
    def manifestPath   = config.get('manifestPath', 'k8s/frontend/deployment.yaml')
    def serviceName    = config.get('serviceName', 'frontend')
    def gitRepoUrl     = config.get('gitRepoUrl', 'https://github.com/Moha-sys/graduation_project_ivolve.git')
    def gitBranch      = config.get('gitBranch', 'main')
    def gitCredsId     = config.get('gitCredsId', 'github-credentials')

    echo "=========================================================="
    echo " [Shared Library] GitOps Manifest Update & Push          "
    echo " Service:      ${serviceName}                            "
    echo " Manifest:     ${manifestPath}                           "
    echo " New Image:    ${imageName}:${imageTag}                  "
    echo "=========================================================="

    stage("Update Manifests") {
        echo "Updating image tag in ${manifestPath}..."
        sh """
        sed -i 's|image: .*${serviceName}.*|image: ${imageName}:${imageTag}|g' ${manifestPath}
        echo "=== Updated Manifest Content ==="
        grep -n "image:" ${manifestPath}
        """
    }

    stage("Push Manifests") {
        echo "Pushing updated Kubernetes manifests to Git repository for Argo CD auto-sync..."
        withCredentials([usernamePassword(
            credentialsId: gitCredsId,
            usernameVariable: 'GIT_USER',
            passwordVariable: 'GIT_TOKEN'
        )]) {
            sh """
            git config user.name "Jenkins CI/CD"
            git config user.email "jenkins-ci@ivolve.local"
            git add ${manifestPath}

            if git diff --staged --quiet; then
                echo "No changes in manifest to commit."
            else
                git commit -m "chore(gitops): update ${serviceName} image tag to ${imageTag} [build #${env.BUILD_NUMBER}]"
                git push https://\${GIT_USER}:\${GIT_TOKEN}@github.com/Moha-sys/graduation_project_ivolve.git ${gitBranch}
                echo "Successfully pushed manifest update to GitHub repository!"
            fi
            """
        }
    }
}
