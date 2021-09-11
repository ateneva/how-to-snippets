

### 👀 Intro:

[https://www.youtube.com/watch?v=\_nYXeEe-hqc](https://www.youtube.com/watch?v=_nYXeEe-hqc)



---

**Overview**
------------

Cloud Functions is a serverless execution environment for building and connecting cloud services.



👉 With Cloud Functions you write simple, **single-purpose functions** that are attached to events emitted from your cloud infrastructure and services. **Your Cloud Function is triggered when an event being watched is fired.**



✅ **Your code executes in a fully managed environment.** There is no need to provision any infrastructure or worry about managing any servers.



Cloud Functions are written in Javascript and execute in a Node.js environment on Google Cloud. You can take your Cloud Function and run it in any standard Node.js runtime which makes both portability and local testing a breeze.





### Connect and Extend Cloud Services

👉 Cloud Functions provides a connective layer of logic that **lets you write code to connect and extend cloud services.**



*   Listen and respond to a file upload to Cloud Storage,
*   a log change,
*   or an incoming message on a Cloud Pub/Sub topic.



Cloud Functions augments existing cloud services and allows you to address an increasing number of use cases with arbitrary programming logic.



✅ Cloud Functions have access to the Google Service Account **credential and are thus seamlessly authenticated with the majority of Google Cloud services** such as:

*   Datastore,
*   Cloud Spanner,
*   Cloud Translation API,
*   Cloud Vision API, as well as many others.



In addition, Cloud Functions are supported by numerous [Node.js client libraries](https://cloud.google.com/nodejs/apis), which further simplify these integrations.

###   

### Events and Triggers

ℹ️ Cloud events are _things_ that happen in your cloud environment.These might be things like:

*   changes to data in a database,
*   files added to a storage system,
*   or a new virtual machine instance being created.



Events occur whether or not you choose to respond to them. You create a response to an event with a _trigger_.



ℹ️ A trigger is a declaration that you are interested in a certain event or set of events. Binding a function to a trigger allows you to capture and act on events.



For more information on creating triggers and associating them with your functions, see [Events and Triggers](https://cloud.google.com/functions/docs/concepts/events-triggers).

###   

### Serverless

✅ Cloud Functions removes the work of managing servers, configuring software, updating frameworks, and patching operating systems.



✅ The software and infrastructure are fully managed by Google so that you just add code.



**Furthermore, provisioning of resources happens automatically in response to events**.

This means that a function can scale from a few invocations a day to many millions of invocations without any work from you.

###   

### Use Cases:

👉 Asynchronous workloads like lightweight ETL,

👉 or cloud automations like triggering application builds now no longer need their own server and a developer to wire it up.



You simply deploy a Cloud Function **bound to the event you want and you're done.**



👉 The fine-grained, on-demand nature of Cloud Functions also makes it a perfect candidate **for lightweight APIs and webhooks.**



In addition, the automatic provisioning of HTTP endpoints when you deploy an HTTP Function means there is no complicated configuration required as there is with some other services. See the following table for additional common Cloud Functions use cases:



![](https://t4668229.p.clickup-attachments.com/t4668229/266b42e3-7e64-4974-a3a9-0a4790523348/image.png)





#### **What you'll do**

*   Create a cloud function
*   Deploy and test the function
*   View logs



Cloud Functions: Qwik Start - Console
=====================================



**Create a function**
---------------------

In this step, you're going to create a cloud function using the console.

1.  In the console, click the **Navigation menu** > **Cloud Functions**.



![](https://cdn.qwiklabs.com/KbMVUAeYk76QP%2FAX14%2BBP9brAf4kNEs9FS9KW9p9GRo%3D)



Click **Create function**.

![](https://cdn.qwiklabs.com/EtxhMlrkfHY797AS4fF14KRAxl8Ko0Mb%2BWvN1zpL1gU%3D)



![](https://t4668229.p.clickup-attachments.com/t4668229/3dd47756-2894-4e38-ae82-b8949e2f9b91/image.png)



![](https://cdn.qwiklabs.com/Ru4d0bLhJx9aOkgkxCYKysLdOxcQi5ValtHR5qys%2BQY%3D)

You deploy the function in the next section.



---

**Deploy the function**
-----------------------

Still in the **Create function** dialog, in Source code for **Inline editor** use the default `helloWorld` function implementation already provided for index.js. At the bottom, click **Deploy** to deploy the function.



![](https://t4668229.p.clickup-attachments.com/t4668229/dbecbc03-c0e0-402e-bfed-ef6f97227596/image.png)



After you click **Deploy**, the console redirects to the **Cloud Functions Overview** page.

While the function is being deployed, the icon next to it is a small spinner. When it's deployed, the spinner is a green check mark.

![](https://cdn.qwiklabs.com/KgVOk%2BSqqP5pUjyoleVuXNv8P03B2%2BpDthn61SsDmCE%3D)

###   

**Test the function**
---------------------



In the **Cloud Functions Overview** page, display the menu for your function, and click **Test function**.

![](https://cdn.qwiklabs.com/n%2BFGkZis%2FEC73qY5XSUfj4YfC9FjF1RsPRRQSw0rfQU%3D)



In the Triggering event field, enter the following text between the brackets `{}` and click **Test the function**.

```bash
"message":"Hello World!"
```



In the **Output** field, you should see the message `Success: Hello World!`

In the **Logs** field, a status code of **200** indicates success. (It may take a minute for the logs to appear.)

![](https://cdn.qwiklabs.com/3u9%2FKmmTfQoVBuLcD6ecW5n4LqGxt4g%2FMRaPZ0nJfLc%3D)

![](https://t4668229.p.clickup-attachments.com/t4668229/54be6808-b123-41b1-867d-3e15328f9eb5/image.png)
-------------------------------------------------------------------------------------------------------

**View logs**
-------------

View logs from the Cloud Functions Overview page.

Click the blue arrow to go back to the **Cloud Functions Overview** page.

![](https://cdn.qwiklabs.com/9H5sRV3E8z2I%2FoUmhqD3ODBGMAdnPlX2E3TUzSkOnmg%3D)



Display the menu for your function, and click **View logs**.

![](https://cdn.qwiklabs.com/tbb%2B4z8Bp8nC8ETvhr3hcFpnFhW6X3ecJg2J4h%2BRJ4A%3D)



Example of the log history that displays in **Query results**:

![](https://cdn.qwiklabs.com/jybuRC0x9ToONDo2zrvJJJ7LNdoTtRmnfiIA7f2XSi4%3D)



Your application is deployed, tested, and you can view the logs.

![](https://t4668229.p.clickup-attachments.com/t4668229/050b4a3d-2c79-4015-9d4b-c286ab01a3fc/image.png)
-------------------------------------------------------------------------------------------------------



**Test your Understanding**
---------------------------



![](https://t4668229.p.clickup-attachments.com/t4668229/5bc1cee9-4560-4539-90f9-804a77955094/image.png)





* * *



Cloud Functions: Qwik Start - Command Line
==========================================



### Activate Cloud Shell

In the Cloud Console, in the top right toolbar, click the **Activate Cloud Shell** button.

![](https://cdn.qwiklabs.com/vdY5e%2Fan9ZGXw5a%2FZMb1agpXhRGozsOadHURcR8thAQ%3D)



Click **Continue**.

![](https://cdn.qwiklabs.com/lr3PBRjWIrJ%2BMQnE8kCkOnRQQVgJnWSg4UWk16f0s%2FA%3D)

It takes a few moments to provision and connect to the environment. When you are connected, you are already authenticated, and the project is set to your _PROJECT\_ID_. For example:

![](https://cdn.qwiklabs.com/hmMK0W41Txk%2B20bQyuDP9g60vCdBajIS%2B52iI2f4bYk%3D)

`gcloud` is the command-line tool for Google Cloud. It comes pre-installed on Cloud Shell and supports tab-completion.



You can list the active account name with this command:

```bash
gcloud auth list
```



(Output)

```bash
Credentialed accounts:- <myaccount>@<mydomain>.com (active)
```



(Example output)

```bash
Credentialed accounts:- google1623327_student@qwiklabs.net
```



You can list the project ID with this command:

```bash
gcloud config list project
```



(Output)

```bash
[core]
project = <project_ID>
```



(Example output)

```bash
[core]
project = qwiklabs-gcp-44776a13dea667a6
```

For full documentation of `gcloud` see the [gcloud command-line tool overview](https://cloud.google.com/sdk/gcloud).



---

**Create a function**
---------------------

First, you're going to create a simple function named helloWorld. This function writes a message to the Cloud Functions logs. It is triggered by cloud function events and accepts a callback function used to signal completion of the function.



ℹ️ For this lab the cloud function event is a cloud pub/sub topic event.



👉 **A pub/sub is a messaging service** where the senders of messages are decoupled from the receivers of messages. When a message is sent or posted, a subscription is required for a receiver to be alerted and receive the message.



For more information about pub/subs, see [Google Cloud Pub/Sub: A Google-Scale Messaging Service](https://cloud.google.com/pubsub/architecture).



For more information on the event parameter and the callback parameter, see [Background Functions](https://cloud.google.com/functions/docs/writing/background).



To create a cloud function:

*   In the Cloud Shell command line, create a directory for the function code.

```bash
mkdir gcf_hello_world
```



*   Move to the `gcf_hello_world` directory.

```bash
cd gcf_hello_world
```



*   Create and open `index.js` to edit.

```bash
nano index.js
```



*   Copy the following into the `index.js` file

```javascript
/**
* Background Cloud Function to be triggered by Pub/Sub.
* This function is exported by index.js, and executed when
* the trigger topic receives a message.
*
* @param {object} data The event payload.
* @param {object} context The event metadata.
*/
exports.helloWorld = (data, context) => {
const pubSubMessage = data;
const name = pubSubMessage.data
  ? Buffer.from(pubSubMessage.data, 'base64').toString() : "Hello World";
console.log(`My Cloud Function: ${name}`);
};
```

*   Exit nano (Ctrl+x) and save (Y) the file.



---

**Create a cloud storage bucket**
---------------------------------

Use the following command to create a new cloud storage bucket for your function:

```bash
gsutil mb -p [PROJECT_ID] gs://[BUCKET_NAME]

gsutil mb -p qwiklabs-gcp-01-578bda2b0f0b gs://qwiklabs-gcp-01-578bda2b0f0b

gsutil mb -p qwiklabs-gcp-00-613d45c10bec gs://qwiklabs-gcp-00-613d45c10bec
```



*   **PROJECT\_ID** is the Project ID in the connection details of this lab

![](https://cdn.qwiklabs.com/MSmsUcrgV8c3%2FThlG2E67Tdm3HoWI8hsTdDO8iQouqw%3D)

*   **BUCKET\_NAME** is the name you give to the bucket. It must be a globally unique name. For more information, see [Bucket naming guidelines](https://cloud.google.com/storage/docs/naming-buckets).



---

**Deploy your function**
------------------------

When deploying a new function, you must specify `--trigger-topic`, `--trigger-bucket`, or `--trigger-http`. When deploying an update to an existing function, the function keeps the existing trigger unless otherwise specified.

For this lab, you'll set the `--trigger-topic` as `hello_world`.

*   Deploy the function to a pub/sub topic named **hello\_world**, replacing `[BUCKET_NAME]` with the name of your bucket:



```bash
gcloud functions deploy helloWorld \
--project [PROJECT NAME] \
--stage-bucket [BUCKET_NAME] \
--trigger-topic hello_world \
--runtime nodejs8

gcloud functions deploy helloWorld \
--project qwiklabs-gcp-00-613d45c10bec \
--stage-bucket qwiklabs-gcp-00-613d45c10bec \
--trigger-topic hello_world \
--runtime nodejs8
```



*   If you get OperationError, ignore warning and re-run heethe command.



If prompted, enter `Y` to allow unauthenticated invocations of a new function.

*   Verify the status of the function.

```bash
gcloud functions describe helloWorld
```



✅ An ACTIVE status indicates that the function has been deployed.

```bash
entryPoint: helloWorld
eventTrigger:
eventType: providers/cloud.pubsub/eventTypes/topic.publish
failurePolicy: {}
resource:...
status: ACTIVE
```



Every message published in the topic triggers function execution, the message contents are passed as input data.

###   

**Test the function**
---------------------

After you deploy the function and know that it's active, test that the function writes a message to the cloud log after detecting an event.

Enter this command to create a message test of the function.

```bash
DATA=$(printf 'Hello World!'|base64) && gcloud functions call helloWorld --data '{"data":"'$DATA'"}'
```



The cloud tool returns the execution ID for the function, which means a message has been written in the log.



✅ Example output:

```bash
executionId: 3zmhpf7l6j5bc
```

View logs to confirm that there are log messages with that execution ID.



---

**View logs**
-------------

Check the logs to see your messages in the log history.

```bash
gcloud functions logs read helloWorld
```



If the function executed successfully, messages in the log appear as follows:

```bash
LEVEL  NAME        EXECUTION_ID  TIME_UTC                 LOG
D      helloWorld  3zmhpf7l6j5b  2017-12-05 22:17:42.585  Function execution started
I      helloWorld  3zmhpf7l6j5b  2017-12-05 22:17:42.650  My Cloud Function: Hello World!
D      helloWorld  3zmhpf7l6j5b  2017-12-05 22:17:42.666  Function execution took 81 ms, finished with status: 'ok'


```

⚠️ **Note:** The logs will take around 10 mins to appear. Also, the alternative way to view the logs is, go to **Logging** > **Logs Explorer**.



![](https://t4668229.p.clickup-attachments.com/t4668229/30696e99-43ec-4401-a12a-b4946f3a2fbe/image.png)



Your application is deployed, tested, and you can view the logs.

### Deploy a function that user Cloud Storage as a triggers

* deploy a function written in JavaScript
```bash
gcloud functions deploy helloGCS \
--entry-point thumbnail \
--project qwiklabs-gcp-01-1f0e384c78fd \
--trigger-resource qwiklabs-gcp-01-1f0e384c78fd \
--trigger-event google.storage.object.finalize \
--runtime nodejs14
```

* deploy a function written in python
```bash
gcloud functions deploy hello_gcs \
--runtime python39 \
--trigger-resource YOUR_TRIGGER_BUCKET_NAME \
--trigger-event google.storage.object.finalize
```

* deploy Pub/Sub functions and check logs

```bash
gcloud functions deploy publish --trigger-http --runtime RUNTIME
```

```bash
gcloud functions deploy subscribe --trigger-topic MY_TOPIC --runtime RUNTIME
```

```bash
gcloud functions call publish --data '{"topic":"MY_TOPIC","message":"Hello World!"}'
```

```bash
gcloud functions logs read subscribe
```

* deploy a fucntion that triggers Firestore

```bash
gcloud functions deploy FUNCTION_NAME \
  --entry-point ENTRY_POINT \
  --runtime RUNTIME \
  --trigger-event "providers/cloud.firestore/eventTypes/document.write" \
  --trigger-resource "projects/YOUR_PROJECT_ID/databases/(default)/documents/messages/{pushId}"
```

# Refetrences:
* https://cloud.google.com/functions/docs/deploying/filesystem
* https://cloud.google.com/functions/docs/calling/storage#functions-calling-storage-python
* https://cloud.google.com/functions/docs/calling/pubsub
* https://cloud.google.com/functions/docs/calling/cloud-firestore
