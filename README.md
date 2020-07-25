# Community collaboration in the context of pandemic (recently COVID-19) or post disaster (like cyclone, major earthquake)

This solution starter was created by technologists from Infosys.

## Authors

- Koushik Shah
- Ansuman Parija
- Manas Tripathy
- Sudarshan Debnath

## Contents

1. [Overview](#overview)
2. [The idea](#the-idea)
3. [How it works](#how-it-works)
4. [Diagrams](#diagrams)
5. [Documents](#documents)
6. [Technology](#technology)
7. [Getting started](#getting-started)
8. [Resources](#resources)
9. [License](#license)

## Overview

### What's the problem?

In any pandemic (recently COVID) or post disaster (like cyclone, major earthquake), reliable Blood supply becomes critical for saving human lives. More so as blood cannot be manufactured, only provided by volunteer donors.

Even in normal times the blood deficit is common problem across the globe. India alone requires approx. 12 million units but only 9 million units are available every year, and during crisis, the demand to supply gap worsens further.

For example, for plasma treatment during the ongoing COVID-19 crisis or during the recent super cyclone in WB and Odisha, many people have suffered due to lack of information about donors or available blood stock. The information is not sufficiently structured or reliable to enable rapid discovery of help needed.

What is needed is a solution that empowers citizens to easily connect and access this information for need of Blood.

### How can technology help?

An effcient collaboration based on Blockchain network and cloud service powered the Mobile & Web interfaces can help in addressing the current Blood donation challenges -

1. Lack of collaboration among blood banks
2. Lack of Transparency among the Donors , Receivers & banks.
3. Lack of common shared IT network among the blood banks
4. Lack of accessibility of data of blood stock

## The idea

The goal is -

1. To provide a mobile application for Blood Donor to donate & Receiver to find blood available in hospital in your nearest locality and guide them to the appropriate locations.
2. Build a common and shared blood bank blockchian network which will be used by Blood bank , Hospital , Donor , Receiver , NGO , Red cross.
3. Centralized Report for government to track and analyze the blood stock and run focused blood donation schemes
4. Increase blood donation through different initiatives and donor incentives.

### Demo video

[![Watch the video](/images/demo-video-2.png)](https://youtu.be/QXFmGNiJGek)

### Benefits

The IBM Cloud service (Watson Assistant, Blockchain) can benefit below -

#### Benefit to Donor

1. Unified blood donation history across blood banks for Donors.
2. With digitization, donors can avail donation benefits without having to register and donate under multiple organizations.
3. Donor can register to get alerts and reminders for upcoming blood donation drive.

#### Benefit to Recipient

1. Instant identification of blood bank with available blood stock.
2. Use of contaminated or unauthorized blood bag prevented.

#### Benefit to Hospitals

1. Easy access to available blood stock by Hospitals, Nursing Homes, etc.
2. Blood stock can be managed across Blood Banks.
3. Inter-district and inter-state surplus blood stock transfer possible instead of getting expired.

#### Benefit to Govt and NGOs

1. Govt., NGOs can use the data for planning drives and reward/appreciation for donors.
2. Contaminated blood can be traced to the originating blood bank. Regular offenders can be blacklisted.
3. Reports can be used by Govt. for any corrective action and/or sanction.

#### Block Chain benefits

1. Bring Transparency in available Blood stock across Blood Banks, Red cross.
2. Bring trust among the Blood Bank , Donor and Receiver.
3. Block Chain provides immutable records – which means blood related transactions cannot be altered.
    Fraudulent activities can be eliminated.
    Unauthorized blood bags and spurious blood can be detected easily.
    Contamination can be traced to the source due to the immutable audit trail.

#### Affiliate benefits

1. Donors can Search and book for blood test in case of identification of blood related disease from donation history.
2. During family emergency, users can donate in City A and avail benefit in City B.
3. Reward points for blood donation that can be redeemed through affiliate services like blood tests and medical check ups

## How it works

1. The Blood Donor, who want to Donate blood or want to register for blood donation open the User Mobile application and fills out the brief form and submit the detail. This information is stored in the database in the IBM Cloud. The Donor can fill the nearest Blood donation center where he want to donate the blood.

2. The Blood Bank/Hospital can access the Donor detail and contact them for collecting the blood. After the testing of the blood completed the Blood bag detail and the Donor detail in stored in Blockchain network.

3. The Blood Recipient, who need the blood , open the mobile application and use the chat interface to locate the Blood Bank/Hospital where the blood is available. Incase the blood is not available, They can submit Emergency blood need form via the Hospital approval application. The Donor will be mail/SMS and if the Donor agree to donate blood the Recipient and Donor can locate each other for blood donation.

## Diagrams

### The architecture

![Cooperation architecture diagram](/images/architecture-diagram.png)

1. Blood Donor/Receiver use the mobile app for voluntary blood donation, receiver can finding donor, hospital for blood availability.
2. User can ask questions to Watson Assistant and get answers on blood and voluntary donor availability questions.
3. Authorized Hospital or Blood Bank can obtain geolocation data to plot routes to collect (or drop off) supplies using HERE Location Services.
4. All Hospital and Blood Bank will maintain the bloodstock, Donor, Receiver detail in block chain.
5. Blood Bank & Hospital detail available across country.

### The Block Chian network

| **Peer**          | **Clients**                 |
| ----------------- | --------------------------- |
| Blood Banks       | All Citizen(Donor/Receiver) |
| Red Cross         | Hospital                    |
| Center/State Govt | Other Health Care           |

![Cooperation architecture diagram](/images/blockChain-diagram_old.png)

## Project roadmap

![Cooperation architecture diagram](/images/RoadMap.png)

## Documents

Trusted sources for Blood Donation crisis:

- [Covid 19 blood shortage burden](https://health.economictimes.indiatimes.com/news/industry/covid-19-blood-shortage-adding-to-the-healthcare-burden/75461947)
- [Pandemic leaves Delhi blood banks parched, hospitals rely on in-house donations](https://indianexpress.com/article/cities/delhi/delhi-coronavirus-updates-blood-banks-hospitals-6490864/)
- [Assam will give preferential treatment in govt jobs and schemes to plasma donors](https://economictimes.indiatimes.com/news/politics-and-nation/assam-will-give-preferential-treatment-in-govt-jobs-and-schemes-to-plasma-donors/articleshow/77005450.cms)
- [Maharashtra Government Warns People Of Possible Plasma Racket](https://www.ndtv.com/india-news/coronavirus-maharashtra-government-warns-people-of-possible-plasma-racket-2263536)
- [Blood Sortage Data In India](https://en.wikipedia.org/wiki/Blood_donation_in_India)
- [Blood banks waste 2.8 million units](https://timesofindia.indiatimes.com/city/mumbai/blood-banks-waste-2-8m-units-in-5-yrs/articleshow/58333394.cms)

## Technology

### IBM Cloud Services

- [IBM Cloudant](https://cloud.ibm.com/catalog?search=cloudant#search_results) - The NoSQL database used
- [Bot Asset Exchange](https://developer.ibm.com/code/exchanges/bots/)
- [IBM Watson Assistant](https://www.ibm.com/cloud/watson-assistant/)
- [Making Programmatic Calls from Watson Assistant](https://cloud.ibm.com/docs/assistant?topic=assistant-dialog-webhooks)
- [Build a Chatbot For Your Mobile App](https://developer.ibm.com/technologies/mobile/patterns/building-a-chatbot-with-kubernetes-watson-assistant-and-elastic-search)
- [IBM blockchain network on kubernetes](https://github.com/IBM/blockchain-network-on-kubernetes#2-setting-up-clis)
- [IBM DEVOPS TOOLCHAIN](https://www.ibm.com/cloud/devops)

### Framework for Mobile App

- Flutter

## Getting started

### Steps

1. [Set up an instance of Watson Assistant](#1-set-up-an-instance-of-watson-assistant).
1. [Provision a CouchDB instance using Cloudant](#2-Provision-a-CouchDB-instance-using-Cloudant).
1. [Run the Blood Bank Web application](#3-Run-the-Blood-Bank-Web-Application).
1. [Run the mobile application](#4-run-the-mobile-application).
1. [Provision Blockchain network using IKS](#5-provision-blockchain-network-using-iks).

### 1. Set up an instance of Watson Assistant

Log in to IBM Cloud and provision a Watson Assistant instance.

1. Provision an instance of **Watson Assistant** from the [IBM Cloud catalog](https://cloud.ibm.com/catalog/services/watson-assistant).
1. Launch the Watson Assistant service.
1. [Created an **Assistant**](https://cloud.ibm.com/docs/assistant?topic=assistant-assistant-add). We added **Find Blood** for ours usecase.
1. [Add a dialog skill](https://cloud.ibm.com/docs/assistant?topic=assistant-skill-dialog-add) to the **Assistant**. We add **search_blood** for ours usecase..
1. Note the **Assistant ID**, **API Key**, and **Assistant URL**. For **Assistant URL**, make note of the base URL/domain. You will need all three of these values in Step 4 below.

### 2: Provision a CouchDB instance using Cloudant

Log into the IBM Cloud and provision a [CouchDB instance using Cloudant](https://www.ibm.com/cloud/cloudant).

1. From the catalog, select Databases and then the Cloudant panel.
1. Once selected, Click the blue **Create** button. We have created **blaster_cloudant** instance for our usecase.
1. Next create a service credential that the CIR API Server can use to communicate with it. We have created **blaster-cloudant-creds** for our usecase.
1. Once created, Select **view service credentials**, and then copy the credential, which will be used by API server in Step 4.

### 3. Run the Blood Bank Web Application.

- To deploy to IBM Cloud:
  1. Log in to your IBM Cloud account using the IBM Cloud CLI: `ibmcloud login`.
  1. Target a Cloud Foundry org and space: `ibmcloud target --cf`.
  1. Create a Devops service <https://cloud.ibm.com/devops/toolchains?env_id=ibm:yp:jp-tok>.
  1. Create a Toolchain application with BYOP facility.
  1. Add Github as the Code Repo,complete required authorization for IBM to connect to Git.
  1. Create a Build and Deploy stage with custom job to build Angular app.
  1. The server can be accessed using the URL <https://blast-ui.eu-gb.mybluemix.net>.

### 4. Run the mobile application

To run the mobile application (Android Emulator):

1. From a terminal:
   1. Go to the `server-app` directory.
   1. Install the dependencies: `npm install`.
   1. Once the dependencies are installed successfully, start the server app with: `npm start`.
   1. Start up the android emulator. for VSCode `Ctrl + Shift + P` and type Emulator, click emulator and then select your emulator.
   1. Go to `red-avatar-mobile` directory. Run command `flutter run` to start up the app.
   1. The app should start up in the emulator.

### 5. Provision Blockchain network using IKS

To Set up Blockchain network on Kubernetes

1. Set up Kubernetes cluster on IBM Cloud <https://cloud.ibm.com/kubernetes/clusters>.
1. Deploy Hyperledger Fabric Network into Kubernetes Cluster <https://github.com/IBM/blockchain-network-on-kubernetes#2-setting-up-clis>.
1. Connect the network using CLient SDK <https://github.com/IBM/blockchain-network-on-kubernetes#7-connect-the-network-using-client-sdk>.
1. Deploy the chaincode onto the blockchain network.

** Due to blockchain service not aviable for Hackathon, We used **IBM Blockchian VS code extention** for ours demo
1. vvvvv
1. vvvvv
1. vvvv

## Live demo

### 1.The Blood Bank Web Application

You can find a running system to test at [RedAvatar Blood Bank Web App](https://blast-ui.eu-gb.mybluemix.net/)

### 2.The Mobile Application

With the application running in the simulator/emulator, you should be able to navigate through the various screens:

1. **Donor Profile (Award and Incentives)**

![Intro Screen](/images/0-donor-profile.png)

1. **Citizen can register to donate blood**

![Donate Screen](/images/1-donor-registration.png)

1. **Citizen can find aviable blood stock in blood bank**

![Search Screen](/images/2-find-blood-avilable.png)

1. **User can use chatbot to blood related queries**

![Chat Screen](/images/3-screen-chat.png)

1. **User can locate the blood bank**

![Map1 Screen](/images/map.PNG)

## License

This solution starter is made available under the [Apache 2 License](LICENSE).
