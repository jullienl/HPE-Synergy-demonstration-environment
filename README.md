# HPE-Synergy-demonstration-environment
How to create a HPE Synergy demonstration or learning environment on your laptop

## Introduction
If you agree that a product live demonstration is one of your best tools to strongly impact customers to adopt new technologies, then this technical white paper is for you! 

Software-Defined infrastructure, infrastructure programmability (or infrastructure as code) and infrastructure automation are key features to transform, simplify and increase IT productivity. Demonstrating these unique features using a self-built demonstration environment can strongly impacts customers to adopt our technologies as they realize the value and the power of a Synergy Composable Infrastructure.

This technical white paper explains how to create a HPE Synergy demonstration (or learning) environment on your laptop (or personal computer) using the HPE Synergy Composer Demonstration appliance running on Oracle VM VirtualBox and using an Ubuntu Linux environment running on Windows 10 WSL (Windows Subsystem for Linux) to extend our demos to Python and Ansible scenarios. 
 
This document provides all the step-by-step process for creating a simple demonstration environment by installing and configuring all required components with a HPE Synergy Composer/OneView Demonstration appliance, a lightweight Ubuntu Linux distribution fully configured with Python/Ansible/OneView modules running in the astonishing Windows Subsystem for Linux (WSL) from Microsoft, with some snapshots to reset your demonstrations and with some cool scenarios to show live demonstrations of our Infrastructure as code, total datacenter automation.

Live demonstration scenarios include:
- Postman to introduce the OneView REST API, the resource model, OneView object content, etc.
- PowerShell/Python scripts to demonstrate many aspects of the Software Defined Infrastructure, Infra as Code, etc.
- DevOps with Ansible and Terrafom to show how simple automation can be implemented at the Hardware Infrastructure level. 

For more information about HPE Synergy, please visit the HPE website. You can access to the HPE Synergy user guides and manuals at www.hpe.com/info/synergy-docs 


## Requirements

-	A powerful laptop with minimum 16G of RAM (best is 32G) and with Intel Virtualization Technology enabled 

-	CentOS 7.5 Boot ISO

-	OneView DCS 5.30 OVA File(s) for Synergy or for BL/DL, the process below is the same for both.

-	An update version of Windows 10 (preferably April 2018 update, version 1803) to run the latest version of Windows Subsystem for Linux


## Demonstration appliance prerequisites

The HPE OneView demonstration appliance is recommended to be deployed on a dual-core 2GHz or greater, 64-bit CPU laptop with a minimum of 16G of RAM (12GB is required for the demonstration appliance itself with 4GB allocated to the host OS and its applications). With 16G of RAM, it is necessary to close as many applications as possible to get a smooth-running experience. For a better experience, 32G of RAM is recommended. 

Important notice: If your laptop does not meet these requirements, you will not be able to run the appliance.


The HPE OneView demonstration appliance is intended for demonstration purposes only and is only available to HPE employees and HPE Partners.


 
[DRAFT - Technical white paper](https://github.com/jullienl/HPE-Synergy-demonstration-environment/blob/5.20/DRAFT-Building%20an%20HPE%20Synergy%20demonstration%20environment%20on%20your%20own%20laptop.pdf)