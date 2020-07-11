# Community collaboration in the context of pandemic (recently COVID-19) or post disaster (like cyclone, major earthquake) 

This solution starter was created by technologists from Infosys.

## Authors

- Koushik Shah
- Ansuman Parija
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

In any pandemic (recently COVID) or post disaster (like cyclone, major earthquake), Blood become an essential and vital demand to fight the crisis. 

In normal time the blood deficit is common problem across global. India require approx. 12 million unit but available 9 million unit every year, and during crisis, the demand to supply needs become worse.

In the COVID-19 crisis for Plasma treatement or during the recent super cycle in WB, Odissa many people have suffered due to lack of Blood Donor or stock inforamtion due to often not sufficiently structured to enable rapid discovery of help needed. 

What is needed is a solution that empowers citized to easily connect and provide this information for need of Blood.

### How can technology help?

The Mobile, Web, Blockchain network and cloud service can help in addressing the currently Blood donation challenges -
1.	Lack of collaboration among 2,708 blood banks
2.	Lack of Transparency among the Donors , Receivers & banks.
3.	Lack of common shared IT network among the blood banks
4.	Lack of accessibility of data of blood stock

The IBM Cloud service (Watson Assistant , HERE , Blockchain) can benefit below –
####Benefit to Donor
1.	Unified blood donation history across blood banks for Donors.
2.	With digitization, donors can avail donation benefits without having to register and donate under multiple organizations.
3.	Donor can register to get alerts and reminders for upcoming blood donation drive.

Benefit to Recipient

1.	Instant identification of blood bank with available blood stock.
2.	Use of contaminated or unauthorized blood bag prevented.
Benefit to Hospitals
1.	Easy access to available blood stock by Hospitals, Nursing Homes, etc.
2.	Blood stock can be managed across Blood Banks.
3.	Inter-district and inter-state surplus blood stock transfer possible instead of getting expired.
Benefit to Govt and NGOs
1.	Govt., NGOs can use the data for planning drives and reward/appreciation for donors.
2.	Contaminated blood can be traced to the originating blood bank. Regular offenders can be blacklisted.
3.	Reports can be used by Govt. for any corrective action and/or sanction.
Block Chain benefits
1.	Bring Transparency in available Blood stock across Blood Banks, Red cross.
2.	Bring trust among the Blood Bank , Donor and Receiver.
3.	Block Chain provides immutable records – which means blood related transactions cannot be altered. 
     Fraudulent activities can be eliminated.
    	Unauthorized blood bags and spurious blood can be detected easily.
    	Contamination can be traced to the source due to the immutable audit trail.
Affiliate benefits
1.	Donors can Search and book for blood test in case of identification of blood related disease from donation history.
2.	During family emergency, users can donate in City A and avail benefit in City B.
3.	Reward points for blood donation that can be redeemed through affiliate services like blood tests and medical check ups


## The idea

The goal is to provide a mobile application, along with server-side components, that serves as the basis for developers to build out a community cooperation application that addresses local needs for food, equipment, and resources.
It would allow both "Suppliers" (such as a store or a community member who has produce they can sell or distribute) to make people aware of what the have; and consumers ("Recipients") to locate where these supplies are, and, if necessary, guide them to the appropriate locations to pick them up.

## How it works

1. The Blood Donor, who want to Donate blood or want to register for blood donation open the User Mobile application and fills out the brief form and submit the detail. This information is stored in the database in the IBM Cloud. The Donor can fill the nearest Blood donation center where he want to donate the blood. 

2. The Blood Bank/Hospital can access the Donor detail and contact them for collecting the blood. After the testing of the blood completed the Blood bag detail and the Donor detail in stored in Blockchain network.

3. The Blood Recipient, who need the blood , open the mobile application and use the chat interface to locate the Blood Bank/Hospital where the blood is available. Incase the blood is not available, They can submit Emergency blood need form via the Hospital approval application. The Donor will be mail/SMS and if the Donor agree to donate blood the Recipient and Donor can locate each other for blood donation.

## Diagrams

### The architecture

![Cooperation architecture diagram](/images/architecture-diagram.png)

1.	Blood Donor/Receiver use the mobile app for voluntary blood donation, receiver can finding donor, hospital for blood availability. 
2.	User can ask questions to Watson Assistant and get answers on blood and voluntary donor availability questions.
3.	Authorized Hospital or Blood Bank can obtain geolocation data to plot routes to collect (or drop off) supplies using HERE Location Services.
4.	All Hospital and Blood Bank will maintain the bloodstock, Donor, Receiver detail in block chain.
5.	Blood Bank & Hospital detail available across country.

### The Block Chian network

![Cooperation architecture diagram](/images/blockChain-diagram.png)

## Documents

Trusted sources for COVID-19 Information:
- [CDC COVID-19 FAQ](https://www.cdc.gov/coronavirus/2019-ncov/faq.html)
- [WHO COVID-19 page](https://www.who.int/health-topics/coronavirus)
- [Johns Hopkins University Coronavirus (includes tracking map)](https://coronavirus.jhu.edu)
- [National Foundation for Infectious Diseases](https://www.nfid.org/infectious-diseases/frequently-asked-questions-about-novel-coronavirus-2019-ncov/)

## Technology

### IBM Cloud Services

- [Bot Asset Exchange](https://developer.ibm.com/code/exchanges/bots/)
- [IBM Watson Assistant](https://www.ibm.com/cloud/watson-assistant/)
- [How-to guides for chatbots](https://www.ibm.com/watson/how-to-build-a-chatbot)
- [Create a machine learning powered web app to answer questions](https://developer.ibm.com/patterns/create-a-machine-learning-powered-web-app-to-answer-questions-from-a-book/)
- [Learning path: Getting started with Watson Assistant](https://developer.ibm.com/series/learning-path-watson-assistant/)
- [Train a speech-to-text model](https://developer.ibm.com/patterns/customize-and-continuously-train-your-own-watson-speech-service/)
- [Enhance customer helpdesks with Smart Document Understanding using webhooks in Watson Assistant](https://developer.ibm.com/patterns/enhance-customer-help-desk-with-smart-document-understanding/)
- [Watson Voice Agent](https://cloud.ibm.com/catalog/services/voice-agent-with-watson)
- [Getting Started with Watson Voice Agent](https://cloud.ibm.com/docs/services/voice-agent?topic=voice-agent-getting-started)
- [Making Programmatic Calls from Watson Assistant](https://cloud.ibm.com/docs/assistant?topic=assistant-dialog-webhooks)
- [IBM Cloud Voice Agent with Twilio](https://developer.ibm.com/recipes/tutorials/ibms-voice-agent-with-watson-and-twilio/)
- [Build a Chatbot For Your Mobile App](https://developer.ibm.com/technologies/mobile/patterns/building-a-chatbot-with-kubernetes-watson-assistant-and-elastic-search)
- [Build a cross-platform mobile app using React Native](https://developer.ibm.com/technologies/mobile/patterns/build-a-cross-platform-mobile-app-to-search-company-news-and-gain-insights)
- [Building successful mobile apps article series](https://developer.ibm.com/series/building-successful-mobile-apps/)
- [Chat Bot Slack Integration](https://developer.ibm.com/technologies/artificial-intelligence/videos/integrating-watson-assistant-with-slack-using-built-in-integrations/#)
- [Chat Bot Slack deployment](https://cloud.ibm.com/docs/assistant?topic=assistant-deploy-slack)
- [Node-RED Slack integration](https://www.ibm.com/cloud/blog/create-a-chatbot-on-ibm-cloud-and-integrate-with-slack-part-1)

### HERE Technologies

- [HERE.com API Key](https://developer.here.com/ref/IBM_starterkit_Covid?create=Freemium-Basic)
- [HERE Maps](https://developer.here.com/products/maps)
- [HERE Routing](https://developer.here.com/products/routing)
- [Integrate interactive maps and location features into your application](https://developer.here.com/documentation/)

## Getting started

### Prerequisites

- Register for an [IBM Cloud](https://www.ibm.com/account/reg/us-en/signup?formid=urx-42793&eventid=cfc-2020?cm_mmc=OSocial_Blog-_-Audience+Developer_Developer+Conversation-_-WW_WW-_-cfc-2020-ghub-starterkit-cooperation_ov75914&cm_mmca1=000039JL&cm_mmca2=10008917) account.
- Install and configure [IBM Cloud CLI](https://cloud.ibm.com/docs/cli?topic=cloud-cli-getting-started#overview).
- Register for a [HERE](https://developer.here.com/ref/IBM_starterkit_Covid?create=Freemium-Basic) account.
- Install [React Native CLI dependencies](https://reactnative.dev/docs/getting-started.html). See the [React Native documentation](https://reactnative.dev/docs/environment-setup) for the exact steps and requirements based on your Operating System and Target OS. For example:
    - **iOS on macOS**
        - [Node.js](https://nodejs.org/en/)
        - [Watchman](https://facebook.github.io/watchman/docs/install)
        - [Xcode](https://itunes.apple.com/us/app/xcode/id497799835?mt=12)
        - [CocoaPods](https://guides.cocoapods.org/using/getting-started.html)
    - **Android on Windows**
        - [Node.js](https://nodejs.org/en/)
        - [Python 2](https://www.python.org/downloads/)
        - [Java Development Kit](https://www.oracle.com/java/technologies/javase-jdk8-downloads.html)
        - [Android Studio](https://developer.android.com/studio/index.html) - add Android 9 (Pie) SDK & configure `ANDROID_HOME`
        - [Create an Android Virtual Device (AVD)](https://developer.android.com/studio/run/managing-avds.html) - with Pie image (API Level 28)
- Clone the [repository](https://github.com/Call-for-Code/Solution-Starter-Kit-Cooperation-2020).

### Steps

1. [Set up an instance of Watson Assistant](#1-set-up-an-instance-of-watson-assistant).
1. [Provision a CouchDB instance using Cloudant](#2-Provision-a-CouchDB-instance-using-Cloudant).
1. [Generate an API Key from the HERE Developer Portal](#3-generate-an-api-key-from-the-here-developer-portal).
1. [Run the server](#4-run-the-server).
1. [Run the mobile application](#5-run-the-mobile-application).

### 1. Set up an instance of Watson Assistant

Log in to IBM Cloud and provision a Watson Assistant instance.

1. Provision an instance of **Watson Assistant** from the [IBM Cloud catalog](https://cloud.ibm.com/catalog/services/watson-assistant).
1. Launch the Watson Assistant service.
1. [Create an **Assistant**](https://cloud.ibm.com/docs/assistant?topic=assistant-assistant-add).
1. [Add a dialog skill](https://cloud.ibm.com/docs/assistant?topic=assistant-skill-dialog-add) to the **Assistant** by importing the [`starter-kit-cooperation-dialog-skill.json`](./starter-kit/assistant/starter-kit-cooperation-dialog-skill.json) file.
1. Go back to All Assistants page, open **Settings** from the action menu ( **`⋮`** ) and click on **API Details**.
1. Note the **Assistant ID**, **API Key**, and **Assistant URL**. For **Assistant URL**, make note of the base URL/domain (e.g., `https://api.us-south.assistant.watson.cloud.ibm.com` or `https://api.eu-gb.assistant.watson.cloud.ibm.com`) and not the full directory/path. You will need all three of these values in Step 4 below.

1. Go to **Preview Link** to get a link to test and verify the dialog skill.

### 2: Provision a CouchDB instance using Cloudant

Log into the IBM Cloud and provision a [CouchDB instance using Cloudant](https://www.ibm.com/cloud/cloudant).

1. From the catalog, select Databases and then the Cloudant panel.
1. Once selected, you can choose your Cloudant plan -- there is a free tier for simple testing that is sufficient to run this CIR example. You should choose an appropriate region, give the service a name, and it is recommended you choose **Use only IAM** under **Available authentication methods**. You can leave the other settings with their defaults. Click the blue **Create** button when ready.
1. Once your Cloudant instance has been created, you need to create a service credential that the CIR API Server can use to communicate with it. By selecting your running Cloudant instance, you can choose **Service credentials** from the left-hand menu. Create a new service credential and give it a name (it doesn't matter what you call it).
1. Once created, you can display the credentials by selecting **view service credentials**, and then copy the credential, so you are ready to paste it into the code of the API server in Step 4.

### 3. Generate an API Key from the HERE Developer Portal

The application uses HERE Location Services for maps, searching, and routing.

To access these services, you'll need an API key. Follow the instructions outlined in the [HERE Developer Portal](https://developer.here.com/ref/IBM_starterkit_Covid?create=Freemium-Basic) to [generate a JavaScript API key](https://developer.here.com/documentation/authentication/dev_guide/topics/api-key-credentials.html).

### 4. Run the server

To set up and launch the server application:

1. Go to the `starter-kit/server-app` directory of the cloned repo.
1. Copy the `.env.example` file in the `starter-kit/server-app` directory, and create a new file named `.env`.
1. Edit the newly created `.env` file and update the `ASSISTANT_URL`, `ASSISTANT_ID`, and `ASSISTANT_IAM_APIKEY` with the values from the dialog skill's API Detail page in Watson Assistant, from Step 1. Also, update the `CLOUDANT_ID` and `CLOUDANT_IAM_APIKEY` with the values from the service credential you created in Step 2. (Note that the `username` from the credential is what should be used for the `CLOUDANT_ID`.)
1. Edit the **name** value in the `manifest.yml` file to your application name (for example, _my-app-name_).
1. From a terminal:
    1. Go to the `starter-kit/server-app` directory of the cloned repo.
    1. Install the dependencies: `npm install`.
    1. Launch the server application locally or deploy to IBM Cloud:
        - To run locally:
            1. Start the application: `npm start`.
            1. The server can be accessed at <http://localhost:3000>.
        - To deploy to IBM Cloud:
            1. Log in to your IBM Cloud account using the IBM Cloud CLI: `ibmcloud login`.
            1. Target a Cloud Foundry org and space: `ibmcloud target --cf`.
            1. Push the app to IBM Cloud: `ibmcloud app push`.
            1. The server can be accessed at a URL using the **name** given in the `manifest.yml` file (for example,  <https://my-app-name.bluemix.net>).

### 5. Run the mobile application

To run the mobile application (using the Xcode iOS Simulator or Android Studio Emulator):

1. Go to the `starter-kit/mobile-app` directory of the cloned repo.
1. Copy the `.env.example` file in the `starter-kit/mobile-app` directory, and create a file named `.env`.
1. Edit the newly created `.env` file:
    - Update the `STARTER_KIT_SERVER_URL` with the URL to the server app launched in the previous step.
        > **Note**: If you are running the server locally and testing with the Android Emulator set the `STARTER_KIT_SERVER_URL` using the local machine's URL (e.g., `http://10.0.2.2:3000`) instead of `localhost`
    - Update the `HERE_APIKEY` with the API key generated in the HERE Developer Portal.
1. From a terminal:
    1. Go to the `starter-kit/mobile-app` directory.
    1. Install the dependencies: `npm install`.
    1. **iOS only**: Go to the `ios` directory: `cd ios`.
    1. **iOS only**: Install pod dependencies: `pod install`.
    1. **iOS only**: Return to the `mobile-app` directory: `cd ../`.
    1. Launch the app in the simulator/emulator:
        - **iOS only**: `npm run ios`
            > **Note**: You should be running at least iOS 13.0. The first time you launch the simulator, you should ensure that you set a Location in the Features menu.
        - **Android only**: `npm run android`
            > **Note**: Your Android Studio needs to have the `Android 9 (Pie)` SDK and a `Pie API Level 28` virtual device

With the application running in the simulator/emulator, you should be able to navigate through the various screens:

![Intro Screen](/images/0-screen-home.png) ![Intro Screen](/images/0-new-screen-home.png)
![Donate Screen](/images/1-screen-donate.png)
![Search Screen](/images/2-screen-search.png)
![Chat Screen](/images/5-screen-chat.png)
![Map1 Screen](/images/3-screen-map.png)
![Map2 Screen](/images/4-screen-map.png)

## Resources

- [IBM Cloud](https://www.ibm.com/cloud)
- [Watson Assistant](https://cloud.ibm.com/docs/assistant?topic=assistant-getting-started)
- [IBM Cloudant](https://cloud.ibm.com/docs/Cloudant?topic=cloudant-overview)
- [HERE Location Services](https://developer.here.com/documentation)
- [Node.js](https://nodejs.org)
- [React Native](https://reactnative.dev/)
- [IBM Blockchain for Developers](https://developer.ibm.com/technologies/blockchain/)

## License

This solution starter is made available under the [Apache 2 License](LICENSE).
