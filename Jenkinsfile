pipeline
{
	agent any
	stages
	{
		stage('Code Checkout')
		{
			steps
			{
				git 'https://github.com/jsachdev07/purdue-igp.git'
			}
		}
		
		stage('Code Compile')
		{
			steps
			{
				sh 'mvn compile'
			}
		}

		stage('Test')
		{
			steps
			{
				sh 'mvn test'
			}
		}

		stage('Build')
		{
			steps
			{
				sh 'mvn package'
			}
		}


		stage('Build Docker Image')
		{
			steps
			{
			        sh 'cp /var/lib/jenkins/workspace/$JOB_NAME/target/ABCtechnologies-1.0.war abc_tech.war'
                                sh 'docker build -t abc_tech:$BUILD_NUMBER .'
				sh 'docker tag abc_tech:$BUILD_NUMBER jsachdev07/abc_tech:$BUILD_NUMBER'
			}
		}

		stage('Push Docker Image')
		{ 
			steps
			{   
			    withDockerRegistry([ credentialsId: "jsachdev-dockerhub", url: "" ])
			    {
			       sh 'docker push jsachdev07/abc_tech:$BUILD_NUMBER'
			    }
			}
		}

		stage('Deploy as container')
		{
			steps
			{
				sh 'docker run -itd -P jsachdev07/abc_tech:$BUILD_NUMBER'
			}
		}

		stage('Deploy to k8s cluster ')
		{
			steps
			{
				sh 'kubectl create -f deploy.yaml'
			        sh  sh 'kubectl create -f svc.yaml'
			}
		}


   }
}