pipeline {
    agent { label 'windows' }

    environment {
        CONNECT = 'http://mkraemer-5560:8080'
        PROJECT = 'hello-java'
        BLDCMD = 'mvn -B package -DskipTests'
        CHECKERS = '--webapp-security --enable-callgraph-metrics'
        COVERITY_NO_LOG_ENVIRONMENT_VARIABLES = '1'
    }

    stages {
        stage('Build') {
            steps {
                bat '''
                   coverity capture  -o commit.connect.serverUrl=%CONNECT% -- mvn -B package -DskipTests
                '''
            }
        }
        stage('Testing'){
            parallel {
               stage('Functional Testing'){
                  bat 'mvn -B test'
               }

               stage('Security Testing'){
                  bat '''
                    coverity analyze  -o commit.connect.serverUrl=%CONNECT%
                    coverity commit   -o commit.connect.serverUrl=%CONNECT%
                  '''
               }
            }
        }

        stage('Test') {
            steps {
                sh 'mvn -B test'
            }
        }

    post {
        always {
            archiveArtifacts artifacts: 'idir/build-log.txt, idir/output/analysis-log.txt, idir/output/callgraph-metrics.csv'
            //cleanWs()
        }
    }
}
