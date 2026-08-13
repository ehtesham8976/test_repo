pipeline {
    agent any

    environment {
        VIVADO_HOME = '/home/ealikhan/snap/Vivado/2023.2'
    }

    stages {

        stage('Checkout') {
            steps {
                echo '========================================'
                echo 'Checking out source code'
                echo '========================================'

                checkout scm
            }
        }

        stage('Check Vivado') {
            steps {
                sh '''
                    /bin/bash -c '
                        source "${VIVADO_HOME}/settings64.sh"

                        echo "========================================"
                        echo "Vivado Version"
                        echo "========================================"

                        vivado -version

                        echo ""
                        echo "========================================"
                        echo "XSim Version"
                        echo "========================================"

                        xsim -version
                    '
                '''
            }
        }

        stage('Run Simulation') {
            steps {
                sh '''
                    /bin/bash -c '
                        source "${VIVADO_HOME}/settings64.sh"

                        echo ""
                        echo "========================================"
                        echo "Starting Vivado Simulation"
                        echo "========================================"

                        vivado \
                            -mode batch \
                            -source scripts/run_sim.tcl

                        echo ""
                        echo "========================================"
                        echo "Simulation command completed"
                        echo "========================================"
                    '
                '''
            }
        }
    }

    post {
        success {
            echo '========================================'
            echo '       SIMULATION SUCCESS'
            echo '========================================'
        }

        failure {
            echo '========================================'
            echo '       SIMULATION FAILED'
            echo '========================================'
        }
    }
}
