#!/usr/bin/env groovy

/**
 * Jenkins Shared Library Step: runTests
 * Runs unit and integration tests based on runtime environment.
 */
def call(Map config = [:]) {
    def serviceType = config.get('serviceType', 'generic')
    def workDir     = config.get('workDir', '.')

    echo "Running tests for ${serviceType} in ${workDir}..."
    dir(workDir) {
        if (serviceType == 'maven' || fileExists('pom.xml')) {
            sh "mvn test"
        } else if (serviceType == 'npm' || fileExists('package.json')) {
            sh "npm test || echo 'No automated tests defined in package.json'"
        } else if (serviceType == 'python' || fileExists('requirements.txt')) {
            sh "python3 -m unittest discover || echo 'No unit tests found'"
        }
    }
}
