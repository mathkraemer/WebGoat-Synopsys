echo Using BRIDGE_polaris_accessToken env variable for authentication!

synopsys-bridge --stage polaris polaris.assessment.types=sast,sca ^
    polaris.application.name=MK-Demo2 polaris.project.name=WebGoat ^
    polaris.serverUrl=https://poc.polaris.synopsys.com

