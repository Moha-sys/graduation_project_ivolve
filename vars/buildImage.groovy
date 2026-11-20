#!/usr/bin/env groovy

/**
 * Jenkins Shared Library Step: buildImage
 * Implements the CI container pipeline:
 * 1. Build Docker image
 * 2. Scan Image with Trivy
 * 3. Push Image to Container Registry (DockerHub or ECR)
 * 4. Delete Image Locally from runner disk
 */
def call(Map config = [:]) {
    def imageName     = config.get('imageName', 'mohadevv/ivolve-app')
    def imageTag      = config.get('imageTag', "${env.BUILD_NUMBER}")
    def dockerfileDir = config.get('dockerfileDir', '.')
    def credentialsId = config.get('credentialsId', 'dockerhub-credentials')
    def severity      = config.get('severity', 'HIGH,CRITICAL')

    echo "=========================================================="
    echo " [Shared Library] Build, Scan, Push & Cleanup Docker Image"
    echo " Target:     ${imageName}:${imageTag}                     "
    echo " Directory:  ${dockerfileDir}                             "
    echo " Severity:   ${severity}                                  "
    echo "=========================================================="

    stage("Build Image") {
        echo "Building container image from ${dockerfileDir}..."
        sh """
        docker build -t ${imageName}:${imageTag} -t ${imageName}:latest ${dockerfileDir}
        """
    }

    stage("Scan Image") {
        echo "Scanning Docker image with Trivy (${severity} vulnerabilities)..."
        sh """
        trivy image --severity ${severity} --scanners vuln --exit-code 0 ${imageName}:${imageTag} || true
        """
    }

    stage("Push Image") {
        echo "Authenticating and pushing image to container registry..."
        withCredentials([usernamePassword(
            credentialsId: credentialsId,
            usernameVariable: 'DOCKER_USER',
            passwordVariable: 'DOCKER_PASS'
        )]) {
            sh """
            echo "\$DOCKER_PASS" | docker login -u "\$DOCKER_USER" --password-stdin
            docker push ${imageName}:${imageTag}
            docker push ${imageName}:latest
            """
        }
    }

    stage("Delete Image Locally") {
        echo "Removing local container images to reclaim runner disk space..."
        sh """
        docker rmi ${imageName}:${imageTag} ${imageName}:latest || true
        """
    }
}
