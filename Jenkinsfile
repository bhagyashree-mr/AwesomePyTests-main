pipeline {
    agent {
                label 'agentlinux'
            }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/kss7/AwesomePyTests.git'
                sh "ls -lat"
                echo "done checkout"
                echo params.BuildId
            }
        }
		stage('Run Tests') {
           steps {
				echo "Setup and run API Tests"
				sh('bash ./jenkinsscript.sh')
          }
        }
	stage("publish junit report") {
            steps{
                echo "publishing junit"
                junit skipMarkingBuildUnstable: true, testResults: 'xmlReport/output.xml'
            }
        }
	stage("Publish Allure Report")	{
		steps{
			echo "Publish Allure"
			allure includeProperties: false, jdk: '', results: [[path: 'allure_results']]
		}
	}

    }
}