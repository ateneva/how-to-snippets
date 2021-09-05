



👀 **INTRO**

[https://www.youtube.com/watch?v=oKU2wbTXMTY](https://www.youtube.com/watch?v=oKU2wbTXMTY)

###   

[https://www.youtube.com/watch?v=cvu53CnZmGI](https://www.youtube.com/watch?v=cvu53CnZmGI)



### 👇 What is Cloud Pub/Sub?

[https://www.youtube.com/watch?v=MjEam95VLiI](https://www.youtube.com/watch?v=MjEam95VLiI)

![](https://t4668229.p.clickup-attachments.com/t4668229/a6d24302-6ba4-4c0f-b82f-37444a465ab2/image.png)
-------------------------------------------------------------------------------------------------------



### 👇 Cloud Pub/Sub in Action

[https://www.youtube.com/watch?v=f5DOsB7Nlw0](https://www.youtube.com/watch?v=f5DOsB7Nlw0)



### 👇 Cloud Pub/Sub Publishers

[https://www.youtube.com/watch?v=ML6P1ksHcqo](https://www.youtube.com/watch?v=ML6P1ksHcqo)



### 👇 Cloud Pub/Sub Subscribers

[https://www.youtube.com/watch?v=nQ9\_Xur2aM4](https://www.youtube.com/watch?v=nQ9_Xur2aM4)



### 👇 Cloud Pub/Sub Push or Pull Subscriber ⁉️

[https://www.youtube.com/watch?v=KObJkda4ZfY](https://www.youtube.com/watch?v=KObJkda4ZfY)



### 👇 Cloud Pub/Sub Receiving mesasges using Pull

[https://www.youtube.com/watch?v=cCkwo6eEHIg](https://www.youtube.com/watch?v=cCkwo6eEHIg)



### 👇 Cloud Pub/Sub Receiving mesasges using Push to Cloud Function

[https://www.youtube.com/watch?v=k8lBOV-nRXI](https://www.youtube.com/watch?v=k8lBOV-nRXI)



### 👇 Cloud Pub/Sub Receiving mesasges with Cloud Run

[https://www.youtube.com/watch?v=ZI9ndn2obDk](https://www.youtube.com/watch?v=ZI9ndn2obDk)



### 👇 Cloud Pub/Sub Replying and Discarding Messsages

[https://www.youtube.com/watch?v=VyLmmamuOVo](https://www.youtube.com/watch?v=VyLmmamuOVo)







* * *

**Overview**
============

👉 Google Cloud Pub/Sub is a messaging service for exchanging event data among applications and services.

*   **A producer of data publishes messages to a Cloud Pub/Sub topic.**
*   **A consumer creates a subscription to that topic.**
*   ✅ Subscribers either pull messages from a subscription or are configured as webhooks for push subscriptions.
  *   Every subscriber must acknowledge each message within a configurable window of time.



![](https://t4668229.p.clickup-attachments.com/t4668229/650bc64b-1979-4269-8db6-64c80f171a4e/image.png)



### ![](https://t4668229.p.clickup-attachments.com/t4668229/10baaeab-fb6b-4b4c-a4cf-04cba2747522/image.png)



![](https://t4668229.p.clickup-attachments.com/t4668229/b965702e-1d43-48cd-b3a1-7b4557cf43d9/image.png)

###   

### What you'll do

*   Set up a topic to hold data.
*   Subscribe to a topic to access the data.
*   Publish and then consume messages with a pull subscriber.



Google Cloud Pub/Sub: Qwik Start - Console
==========================================

###   

### Activate Cloud Shell

Cloud Shell is a virtual machine that is loaded with development tools. It offers a persistent 5GB home directory and runs on the Google Cloud. Cloud Shell provides command-line access to your Google Cloud resources.

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

```plain
[core]
project = <project_ID>
```



(Example output)

```plain
[core]
project = qwiklabs-gcp-44776a13dea667a6
```

For full documentation of `gcloud` see the [gcloud command-line tool overview](https://cloud.google.com/sdk/gcloud).



---

**Setting up Pub/Sub**
----------------------

You can use the Google Cloud Shell console to perform operations in Google Cloud Pub/Sub.



To use a Pub/Sub, you create a topic to hold data and a subscription to access data .published to the topic.

*   Click **Navigation menu** > **Pub/Sub** > **Topics**.

![](https://cdn.qwiklabs.com/xZ3SEfVz2XSS%2F%2F1znllxjwCt6Sw91sr8KuWwOH%2FDBoo%3D)

*   Click **Create topic**.

![](https://cdn.qwiklabs.com/%2B5DjzluijKP1xciKT%2BmsugTk9wWkuM9Tf87XVq4Cc9s%3D)

*   The topic must have a unique name. For this lab, name your topic `MyTopic`. In the **Create a topic** dialog:
  *   For **Topic ID**, type `MyTopic`.
  *   Leave **Encryption** at the default value.
  *   Click **CREATE TOPIC**.

![](https://cdn.qwiklabs.com/uaLTYdoVR9A88J8ifWGw%2BdG3PA%2FUThxFH1sdZI6XNn4%3D)

You've created a topic.

![](https://cdn.qwiklabs.com/2Q9LtD0bxEp9yjxsTUAqpq41MOli5F%2Fk0f0Te1QQBWk%3D)

###   

📌 **Add a subscription**
-------------------------

Now you'll make a subscription to access the topic.

*   Click **Topics** in the left panel to return to the **Topics** page. For the topic you just made click the three dot icon > **Create subscription**.

![](https://cdn.qwiklabs.com/pmK%2F6B9Zi6jTDefr3uTGsKjJqNgjFWtKwLnqu7bL%2Bxk%3D)

*   In the **Add subscription to topic** dialog:
  *   Type a name for the subscription, such as **MySub**
*   Set the Delivery Type to **Pull**.
*   Leave all other options at the default values.

![](https://cdn.qwiklabs.com/hW3IVEU2yyh7fkvEBN3vZQbli9GE%2B9o6qwtdnV3zcSA%3D)

*   Click **Create**.

Your subscription is listed in the Subscription list.

![](https://cdn.qwiklabs.com/o1FlKlZ%2FAOy0by2aR0AvWJzuaNp%2F6BB30d4wEgUegSc%3D)

###   

**Test your Understanding**
---------------------------

Below are multiple choice questions to reinforce your understanding of this lab's concepts. Answer them to the best of your abilities.



![](https://t4668229.p.clickup-attachments.com/t4668229/e1859165-bdfa-4369-ac85-bed97559fb00/image.png)



===

* * *



===

Google Cloud Pub/Sub: Qwik Start - Command Line
===============================================



### Prerequisites

This is an **introductory** level lab. This assumes little or no prior experience with Pub/Sub, and it will teach you the basics of setting up and using this Google Cloud service.

Before taking this lab, consider your proficiency with Pub/Sub. Below is a list of more challenging labs that will let you apply your knowledge of Pub/Sub to different cloud services and use cases:

*   [Dataflow: Qwik Start - Templates](https://google.qwiklabs.com/catalog_lab/934)
*   [Building an IoT Analytics Pipeline with Google Cloud](https://google.qwiklabs.com/catalog_lab/694)
*   [Scanning User-generated Content Using the Cloud Video Intelligence and Cloud Vision APIs](https://google.qwiklabs.com/catalog_lab/1109) 



**The Pub/Sub basics**
----------------------

As stated earlier, Google Cloud Pub/Sub is an asynchronous global messaging service.



There are three terms in Pub/Sub that appear often: `topics`, `publishing`, and `subscribing`.

*   A `topic` is a shared string that allows applications to connect with one another through a common thread.
*   Publishers push (or `publish`) a message to a Cloud Pub/Sub topic.
*   Subscribers make a "`subscription`" to a topic where they will either pull messages from the subscription or configure webhooks for push subscriptions. Every subscriber must acknowledge each message within a configurable window of time.



✅ To sum it up, a producer **publishes messages to a topic and a consumer creates a subscription to a topic to receive messages from it.**



📌 **Pub/Sub topics**
---------------------

Pub/Sub comes preinstalled in the Google Cloud Shell, so there are no installations or configurations required to get started with this service.



👉 Run the following command to create a topic called `myTopic`:

```bash
gcloud pubsub topics create myTopic
```



For good measure, create two more topics; one called `Test1` and the other called `Test2`:

```bash
gcloud pubsub topics create Test1
gcloud pubsub topics create Test2
```



👀 To see the three topics you just created, run the following command:

```bash
gcloud pubsub topics list
```



Your output should resemble the following:

```bash
name: projects/qwiklabs-gcp-3450558d2b043890/topics/myTopic
---
name: projects/qwiklabs-gcp-3450558d2b043890/topics/Test2
---
name: projects/qwiklabs-gcp-3450558d2b043890/topics/Test1
```



![](https://t4668229.p.clickup-attachments.com/t4668229/2b0c0b86-0e3b-4c63-b208-4b567e6377b7/image.png)



👉 Time to cleanup. Delete `Test1` and `Test2` by running the following commands:

```bash
gcloud pubsub topics delete Test1
gcloud pubsub topics delete Test2
```



👉 Run the `gcloud pubsub topics list` command one more time to verify the topics were deleted:

```bash
gcloud pubsub topics list
```



You should get the following output:

```bash
---
name: projects/qwiklabs-gcp-3450558d2b043890/topics/myTopic
```

![](https://t4668229.p.clickup-attachments.com/t4668229/08937d89-e76a-4219-84cd-bc6308318f90/image.png)
-------------------------------------------------------------------------------------------------------



📌 **Pub/Sub subscriptions**
----------------------------

Now that you're comfortable creating, viewing, and deleting topics, time to work with subscriptions.



👉 Run the following command to create a subscription called `mySubscription` to topic `myTopic`:

```bash
gcloud  pubsub subscriptions create --topic myTopic mySubscription
```

###   

👉 Add another two subscriptions to `myTopic`. Run the following commands to make `Test1` and `Test2` subscriptions:

```bash
gcloud  pubsub subscriptions create --topic myTopic Test1
gcloud  pubsub subscriptions create --topic myTopic Test2
```



👉 Run the following command to list the subscriptions to myTopic:

```bash
gcloud pubsub topics list-subscriptions myTopic
```



Your output should resemble the following:

```bash
---
projects/qwiklabs-gcp-3450558d2b043890/subscriptions/Test2
---
projects/qwiklabs-gcp-3450558d2b043890/subscriptions/Test1
---
projects/qwiklabs-gcp-3450558d2b043890/subscriptions/mySubscription
```



![](https://t4668229.p.clickup-attachments.com/t4668229/4adf3ac4-05fd-4f55-a310-b5107fa5c2e6/image.png)



👉 Now delete the `Test1` and `Test2` subscriptions. Run the following commands:

```bash
gcloud pubsub subscriptions delete Test1
gcloud pubsub subscriptions delete Test2
```



See if the `Test1` and `Test2` subscriptions were deleted. Run the `list-subscriptions` command one more time:

```bash
gcloud pubsub topics list-subscriptions myTopic
```



You should get the following output:

```bash
---
projects/qwiklabs-gcp-3450558d2b043890/subscriptions/mySubscription
```

![](https://t4668229.p.clickup-attachments.com/t4668229/800862e1-8f7c-4658-a08d-87176077063e/image.png)
-------------------------------------------------------------------------------------------------------



📌 **Pub/Sub Publishing and Pulling a Single Message**
------------------------------------------------------

Next you'll learn how to publish a message to a Pub/Sub topic.



👉 Run the following command to publish the message `"hello"` to the topic you created previously (`myTopic`):

```bash
gcloud pubsub topics publish myTopic --message "Hello"
```



👉 Publish a few more messages to `myTopic`. Run the following commands (replacing `<YOUR NAME>` with your name and `<FOOD>` with a food you like to eat):

```bash
gcloud pubsub topics publish myTopic --message "Publisher's name is <YOUR NAME>"
gcloud pubsub topics publish myTopic --message "Publisher likes to eat <FOOD>"
gcloud pubsub topics publish myTopic --message "Publisher thinks Pub/Sub is awesome"

gcloud pubsub topics publish myTopic --message "Publisher's name is Angelina"
gcloud pubsub topics publish myTopic --message "Publisher likes to eat Musaka"
gcloud pubsub topics publish myTopic --message "Publisher thinks Pub/Sub is awesome"
```

next, use the `pull` command to get the messages from your topic.



![](https://t4668229.p.clickup-attachments.com/t4668229/295403dd-e486-4225-b6bb-1bf9ac54a46d/image.png)



The pull command is subscription based, meaning it should work because earlier you set up the subscription `mySubscription` to the topic `myTopic`.



👉 Use the following command to pull the messages you just published from the Pub/Sub topic:

```bash
gcloud pubsub subscriptions pull mySubscription --auto-ack
```



Your output should resemble the following:

![](https://cdn.qwiklabs.com/59Crmi1YmFDkTUDc1DPQCFiS4inFJjWs8iYQj8xBREM%3D)



![](https://t4668229.p.clickup-attachments.com/t4668229/133ca2db-72c6-46e1-8d88-d3a8e340e571/image.png)



⁉️ What's going on here? You published 4 messages to your topic, but only 1 was outputted.

Now is an important time to note a couple features of the `pull` command that often trip developers up:

*   ⚠️ **Using the pull command without any flags will output only one** 1️⃣ **message, even if you are subscribed to a topic that has more held in it.**



*   ‼️ **Once an individual message has been outputted from a particular subscription-based pull command, you cannot access that message again with the pull command.**



To see what the second bullet is talking about, run the last command three more times. You will see that it will output the other messages you published before.



![](https://t4668229.p.clickup-attachments.com/t4668229/98e0c835-41f3-4454-a799-10bd3e12b5e0/image.png)



👉 Now, run the command a 4th time. You'll get the following output (since there were none left to return):

```bash
gcpstaging20394_student@cloudshell:~ (qwiklabs-gcp-3450558d2b043890)$ gcloud pubsub subscriptions pull mySubscription --auto-ack
Listed 0 items.
```



![](https://t4668229.p.clickup-attachments.com/t4668229/305419c5-ef88-488d-a6ba-cac4cee6a494/image.png)



In the last section, you will learn how to pull multiple messages from a topic with a `flag`.



---

📌 **Pub/Sub pulling all messages from subscriptions**
------------------------------------------------------

Since you pulled all of the messages from your topic in hte last example, populate `myTopic` with a few more messages.



Run the following commands:

```bash
gcloud pubsub topics publish myTopic --message "Publisher is starting to get the hang of Pub/Sub"
gcloud pubsub topics publish myTopic --message "Publisher wonders if all messages will be pulled"
gcloud pubsub topics publish myTopic --message "Publisher will have to test to find out"
```



Add a `flag` to your command so you can output all three messages in one request.



*   You may have not noticed, but you have actually been using a flag this entire time: the `--auto-ack` part of the `pull` command is a flag that has been formatting your messages into the neat boxes that you see your pulled messages in.



*   `limit` is another flag that sets an upper limit on the number of messages to pull.



👉 Wait a minute to let the topics get created. Run the pull command with the `limit` flag:

```bash
gcloud pubsub subscriptions pull mySubscription --auto-ack --limit=3
```



Your output should match the following:

![](https://cdn.qwiklabs.com/RqPezOvS%2F0IYEIkWliflxdg5XtRApdqMRlcPhMXel%2Bk%3D)



![](https://t4668229.p.clickup-attachments.com/t4668229/14f5ff79-9c90-4f5e-a453-eff1aaa6de9d/image.png)



Now you know how to add flags to a Pub/Sub command to output a larger pool of messages. You are well on your way to becoming a Pub/Sub master.





* * *







Google Cloud Pub/Sub: Qwik Start - Python
=========================================



---

👉 **Create a virtual environment**
-----------------------------------



Execute the following command to download and update the packages list.

```bash
sudo apt-get update
```



Python virtual environments are used to isolate package installation from the system.

```bash
sudo apt-get install virtualenv
```

If prompted \[Y/n\], press `Y` and then `Enter`.



👉 create virtual environment

```bash
virtualenv -p python3 venv
```



✅ Activate the virtual environment.

```bash
source venv/bin/activate
```



---

👉 **Install the client library**
---------------------------------

Run the following to install the client library:

```bash
pip install --upgrade google-cloud-pubsub
```



📌 Get the sample code by cloning a GitHub repository:

```bash
git clone https://github.com/googleapis/python-pubsub.git
```



[

python-pubsub/samples/snippets at main · googleapis/python-pubsub

Contribute to googleapis/python-pubsub development by creating an account on GitHub.

![](https://www.google.com/s2/favicons?domain_url=https%3A%2F%2Fgithub.com%2Fgoogleapis%2Fpython-pubsub%2Ftree%2Fmain%2Fsamples%2Fsnippets)https://github.com/googleapis/python-pubsub/tree/main/samples/snippets

](https://github.com/googleapis/python-pubsub/tree/main/samples/snippets)





Navigate to the directory:

```bash
cd python-pubsub/samples/snippets
```



---

👉 **Pub/Sub - the Basics**
---------------------------

Google Cloud Pub/Sub is an asynchronous global messaging service. There are three terms in Pub/Sub that appear often: **_topics_****,** **_publishing_****, and** **_subscribing_****.**



A topic is a shared string that allows applications to connect with one another through a common thread.

*   **Publishers push (or publish) a message to a Cloud Pub/Sub topic.**



*   Subscribers will then make a _subscription_ to that thread, where they **will either pull messages from the topic or configure webhooks for push subscriptions.**
  *   Every subscriber must acknowledge each message within a configurable window of time.



✅ In sum, a publisher creates and sends messages to a topic and a **subscriber creates a subscription** to a topic to receive messages from it.

###   

### Pub/Sub in Google CLoud

✅ Pub/Sub comes preinstalled in the Cloud Shell, so **there are no installations or configurations required to get started with this service.** In this lab you use Python to create the topic, subscriber, and then view the message. You use a gcloud command to publish the message to the topic.



---

👉 **Create a topic**
---------------------

To publish data to Cloud Pub/Sub you create a topic and then configure a publisher to the topic.



Set the environment variable `GOOGLE_CLOUD_PROJECT`.

You can find your Project ID in the CONNECTION DETAILS:

```bash
export GLOBAL_CLOUD_PROJECT=GCP Project ID

export GLOBAL_CLOUD_PROJECT=qwiklabs-gcp-03-fe58e8074b42
```



👀 [`publisher.py`](http://publisher.py) is a script that demonstrates how to perform basic operations on topics with the Cloud Pub/Sub API.



View the content of publisher script:

```bash
cat publisher.py
```



⚠️ **Note:** Alternatively, you can use the shell editors that are installed on Cloud Shell, such as nano or vim or use the Cloud Shell code editor to view `python-docs-samples/pubsub/cloud-client/publisher.py`



[

python-pubsub/publisher.py at main · googleapis/python-pubsub

Contribute to googleapis/python-pubsub development by creating an account on GitHub.

![](https://www.google.com/s2/favicons?domain_url=https%3A%2F%2Fgithub.com%2Fgoogleapis%2Fpython-pubsub%2Fblob%2Fmain%2Fsamples%2Fsnippets%2Fpublisher.py)https://github.com/googleapis/python-pubsub/blob/main/samples/snippets/publisher.py

](https://github.com/googleapis/python-pubsub/blob/main/samples/snippets/publisher.py)







ℹ️ For information about the publisher script:

```bash
python publisher.py -h
```



_Example Output, do not copy_

```plain
usage: publisher.py [-h]
                  project
                  {list,create,delete,publish,publish-with-custom-attributes,publish-with-futures,publish-with-error-handler,publish-with-batch-settings}
                  ...
This application demonstrates how to perform basic operations on topics
with the Cloud Pub/Sub API.
For more information, see the README.md under /pubsub and the documentation
at https://cloud.google.com/pubsub/docs.
positional arguments:
project               Your Google Cloud project ID
{list,create,delete,publish,publish-with-custom-attributes,publish-with-futures,publish-with-error-handler,publish-with-batch-settings}
  list                Lists all Pub/Sub topics in the given project.
  create              Create a new Pub/Sub topic.
  delete              Deletes an existing Pub/Sub topic.
  publish             Publishes multiple messages to a Pub/Sub topic.
  publish-with-custom-attributes
                      Publishes multiple messages with custom attributes to
                      a Pub/Sub topic.
  publish-with-futures
                      Publishes multiple messages to a Pub/Sub topic and
                      prints their message IDs.
  publish-with-error-handler
                      Publishes multiple messages to a Pub/Sub topic with an
                      error handler.
  publish-with-batch-settings
                      Publishes multiple messages to a Pub/Sub topic with
                      batch settings.
optional arguments:
-h, --help            show this help message and exit
```



👉 Run the publisher script to create Pub/Sub Topic:

```bash
python publisher.py $GLOBAL_CLOUD_PROJECT create MyTopic
```



👉 This command returns a list of all Pub/Sub topics in a given project:

```bash
python publisher.py $GLOBAL_CLOUD_PROJECT list
```



![](https://t4668229.p.clickup-attachments.com/t4668229/4e2e86ba-ac7d-45a2-ab6b-b5198db37e8f/image.png)



You can also view the topic you just made in the Cloud Console.

Navigate to **Navigation menu** > **Pub/Sub** > **Topics**.

![](https://cdn.qwiklabs.com/%2BOe9PeVxmoke4%2F38la7GFatJpnmtCWu9jQw1kiJUuJA%3D)



You should see `MyTopic`.

![](https://cdn.qwiklabs.com/9B%2BZPgLBxWXokZDwYuPnAt%2FowY36uKcQ1BNvyvAkxxk%3D)



---

👉 **Create a subscription**
----------------------------

Create a Pub/Sub subscription for topic with [`subscriber.py`](http://subscriber.py) script:

```bash
python subscriber.py $GLOBAL_CLOUD_PROJECT create MyTopic MySub
```

###   

✅ This command returns a list of subscribers in given project:

```bash
python subscriber.py $GLOBAL_CLOUD_PROJECT list-in-project
```

You'll see only one subscription because you've made only one subscription.



_Example output (do not copy)_

```plain
projects/qwiklabs-gcp-7877af129f04d8b3/subscriptions/MySubcontent_copy
```



![](https://t4668229.p.clickup-attachments.com/t4668229/1efd0870-764d-4d2c-bc1a-8eb1bbf4fec4/image.png)



Check out the subscription you just made in the console. In the left pane, click **Subscriptions**. You should see the subscription name and other details.

![](https://cdn.qwiklabs.com/3t4Iwn7UhRKwxBpY65x7k46Wo2WLbBWPc6jMEC3pr0Y%3D)



ℹ️ For information about the `subscriber` script:

```bash
python subscriber.py -h
```



_Output, do not copy_

```plain
usage: subscriber.py [-h]
                   project
                   {list_in_topic,list_in_project,create,create-push,delete,update,receive,receive-custom-attributes,receive-flow-control,receive-synchronously,listen_for_errors}
                   ...
This application demonstrates how to perform basic operations on
subscriptions with the Cloud Pub/Sub API.
For more information, see the README.md under /pubsub and the documentation
at https://cloud.google.com/pubsub/docs.
positional arguments:
project               Your Google Cloud project ID
{list_in_topic,list_in_project,create,create-push,delete,update,receive,receive-custom-attributes,receive-flow-control,receive-synchronously,listen_for_errors}
  list_in_topic       Lists all subscriptions for a given topic.
  list_in_project     Lists all subscriptions in the current project.
  create              Create a new pull subscription on the given topic.
  create-push         Create a new push subscription on the given topic.
  delete              Deletes an existing Pub/Sub topic.
  update              Updates an existing Pub/Sub subscription's push
                      endpoint URL. Note that certain properties of a
                      subscription, such as its topic, are not modifiable.
  receive             Receives messages from a pull subscription.
  receive-custom-attributes
                      Receives messages from a pull subscription.
  receive-flow-control
                      Receives messages from a pull subscription with flow
                      control.
  receive-synchronously
                      Pulling messages synchronously.
  listen_for_errors   Receives messages and catches errors from a pull
                      subscription.
optional arguments:
-h, --help            show this help message and exit
```



---

👉 **Publish messages**
-----------------------

Now that you've set up `MyTopic` (the topic), a subscription to `MyTopic` (`MySub`), see if you can use gcloud commands to publish a message to `MyTopic`.

Publish the message "Hello" to `MyTopic`:

```bash
gcloud pubsub topics publish MyTopic --message "Hello"
```



Publish a few more messages to `MyTopic`—run the following commands (replacing <YOUR NAME> with your name and <FOOD> with a food you like to eat):

```bash
gcloud pubsub topics publish MyTopic --message "Publisher's name is <YOUR NAME>"
gcloud pubsub topics publish MyTopic --message "Publisher likes to eat <FOOD>"
gcloud pubsub topics publish MyTopic --message "Publisher thinks Pub/Sub is awesome"

gcloud pubsub topics publish MyTopic --message "Publisher's name is Angelina"
gcloud pubsub topics publish MyTopic --message "Publisher likes to eat Musaka"
gcloud pubsub topics publish MyTopic --message "Publisher thinks Pub/Sub is awesome"
```

![](https://t4668229.p.clickup-attachments.com/t4668229/a25a96ba-1ef6-40d9-bc62-01ba856478c8/image.png)
-------------------------------------------------------------------------------------------------------

👉 **View messages**
--------------------

Now that you've published messages to MyTopic, pull and view the messages using MySub.

Use MySub to pull the message from MyTopic:

```bash
python subscriber.py $GLOBAL_CLOUD_PROJECT receive MySub
```



_Example output (do not copy)_

```plain
Listening for messages on projects/qwiklabs-gcp-7877af129f04d8b3/subscriptions/MySubReceived message: Message {
data: 'Publisher thinks Pub/Sub is awesome'
attributes: {}}Received message: Message {
data: 'Hello'
attributes: {}}Received message: Message {
data: "Publisher's name is Harry"
attributes: {}}Received message: Message {
data: 'Publisher likes to eat cheese'
attributes: {}}
```

Click **Ctrl**+**c** to stop listening.



![](https://t4668229.p.clickup-attachments.com/t4668229/f0be6e42-e787-4a5f-97d1-c59a607b7e33/image.png)



![](https://t4668229.p.clickup-attachments.com/t4668229/40528593-d8ed-4eb3-8fc8-088761cdb7a4/image.png)



![](https://t4668229.p.clickup-attachments.com/t4668229/56f54800-4904-475c-a6f4-39a73c22378a/image.png)



### Take Your Next Lab

*   [Pub/Sub Lite: Qwik Start](https://google.qwiklabs.com/catalog_lab/3372). Complementing Pub/Sub, [Pub/Sub Lite](https://cloud.google.com/pubsub/docs/choosing-pubsub-or-lite) is a zonal service for messaging systems with predictable traffic patterns. If you publish 1 MiB-1 GiB of messages per second, Pub/Sub Lite is a low cost option for high-volume event ingestion.
