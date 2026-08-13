pipeline {
    agent any

    environment {
        VIVADO_HOME = '/home/ealikhan/snap/Vivado/2023.2'
    }

    stages {

        stage('Check Vivado') {
            steps {
                sh '''
                    /bin/bash -c '
                        source "${VIVADO_HOME}/settings64.sh"

                        echo "========================================"
                        echo "Vivado"
                        echo "========================================"

                        vivado -version

                        echo ""
                        echo "========================================"
                        echo "XSim"
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
                        echo "STARTING VIVADO SIMULATION"
                        echo "========================================"

                        vivado \
                            -mode batch \
                            -source scripts/run_sim.tcl

                        echo ""
                        echo "========================================"
                        echo "SIMULATION COMMAND FINISHED"
                        echo "========================================"
                    '
                '''
            }
        }
    }

    post {
        success {
            echo "========================================"
            echo "       SIMULATION SUCCESS"
            echo "========================================"
        }

        failure {
            echo "========================================"
            echo "       SIMULATION FAILED"
            echo "========================================"
        }
    }
}
