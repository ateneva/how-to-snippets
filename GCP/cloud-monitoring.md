
https://www.youtube.com/watch?v=ZuUZQfCmA7Y

👉 **Create a Compute Engine instance**
---------------------------------------

1.  In the Cloud Console dashboard, go to **Navigation menu** > **Compute Engine** > **VM instances**, then click **Create instance**.

![](https://cdn.qwiklabs.com/48XM2fQQVCp7ObiNAyXTPs7VFh%2BuW7M2gyc3pPGK62E%3D)

*   Fill in the fields as follows, leaving all other fields at the default value:

| **Field** | **Value** |
| ---| --- |
| Name | lamp-1-vm |
| Region | us-central1 (Iowa) |
| Zone | us-central1-a |
| Series | N1 |
| Machine type | n1-standard-2 |
| Firewall | check Allow HTTP traffic |

*   Click **Create**.

Wait a couple of minutes, you'll see a green check when the instance has launched.

Click **Check my progress** below. A green check confirms you're on track.



---

👉 **Add Apache2 HTTP Server to your instance**
-----------------------------------------------



1.  In the Cloud Console, click **SSH** to open a terminal to your instance.

![](https://cdn.qwiklabs.com/157XnA6MKqd0jjbTNhOenyTQWI31YJZVWQUn30E8wTY%3D)

*   Run the following commands in the SSH window to set up Apache2 HTTP Server:

```bash
sudo apt-get update
sudo apt-get install apache2 php7.0
```

When asked if you want to continue, enter **Y**.

**Note:** If you cannot install php7.0, use php5.

```bash
sudo service apache2 restart
```



*   Return to the Cloud Console, on the VM instances page. Click the `External IP` for `lamp-1-vm` instance to see the Apache2 default page for this instance.

![](https://cdn.qwiklabs.com/IZlq%2Fs%2Fjkwv08kKY5OMQouAGmM2e%2BZD83AOMfY1LVqM%3D)

![](https://cdn.qwiklabs.com/UYEHvdQG6fv%2FFFuZk6xiz4oSzaVznBOY%2BrvHOFPnpt8%3D)



[https://www.youtube.com/watch?v=1ZW59HrRUzw](https://www.youtube.com/watch?v=1ZW59HrRUzw)



### 👉 Create a Monitoring workspace

Now set up a Monitoring workspace that's tied to your Google Cloud Project. The following steps create a new account that has a free trial of Monitoring.

1.  In the Cloud Console, click **Navigation menu** > **Monitoring**.
2.  Wait for your workspace to be provisioned.



When the Monitoring dashboard opens, your workspace is ready.

![](https://cdn.qwiklabs.com/FfS7W1mNXshxngUuea%2BFUBXoXedgDHt0YWk1aZKHiIk%3D)

### Install the Monitoring and Logging agents

Agents collect data and then send or stream info to Cloud Monitoring in the Cloud Console.

The _Cloud Monitoring agent_ is a collectd-based daemon that gathers system and application metrics from virtual machine instances and sends them to Monitoring. By default, the Monitoring agent collects disk, CPU, network, and process metrics. Configuring the Monitoring agent allows third-party applications to get the full list of agent metrics. See [Cloud Monitoring agent overview](https://cloud.google.com/monitoring/agent) for more information.



In this section, you install the _Cloud Logging agent_ to stream logs from your VM instances to Cloud Logging. Later in this lab, you see what logs are generated when you stop and start your VM.

It is best practice to run the Cloud Logging agent on all your VM instances.

#### **Install agents on the VM:**

*   Run the Monitoring agent install script command in the SSH terminal of your VM instance to install the Cloud Monitoring agent.

```bash
curl -sSO https://dl.google.com/cloudagents/add-monitoring-agent-repo.sh
sudo bash add-monitoring-agent-repo.sh
```



```bash
sudo apt-get update
```



```bash
sudo apt-get install stackdriver-agent
```

When asked if you want to continue, enter **Y**.

*   Run the Logging agent install script command in the SSH terminal of your VM instance to install the Cloud Logging agent

```bash
curl -sSO https://dl.google.com/cloudagents/add-logging-agent-repo.sh
sudo bash add-logging-agent-repo.sh
```



```bash
sudo apt-get update
```



```bash
sudo apt-get install google-fluentd
```



---

👉 **Create an uptime check**
-----------------------------

Uptime checks verify that a resource is always accessible. For practice, create an uptime check to verify your VM is up.

1.  In the Cloud Console, in the left menu, click **Uptime checks**, and then click **Create Uptime Check**.

![](https://cdn.qwiklabs.com/mdt35y5ElNzYoCkdrVkodx81TWTuTWAbBYfoj0Ps5r4%3D)

1.  Set the following fields:
  *   **Title**: Lamp Uptime Check, then click **Next**.
  *   **Protocol**: HTTP
  *   **Resource Type**: Instance
  *   **Applies to**: Single, lamp-1-vm
  *   **Path**: leave at default
  *   **Check Frequency**: 1 min

![](https://cdn.qwiklabs.com/HYlXLfWnUXFtXC0A34MfQljuNeFLsUr4XX93uPYfWPY%3D)

1.  Click on **Next** to leave the other details to default and click **Test** to verify that your uptime check can connect to the resource.
2.  When you see a green check mark everything can connect. Click **Create**.

The uptime check you configured takes a while for it to become active. Continue with the lab, you'll check for results later. While you wait, create an alerting policy for a different resource.



👉 **Create an alerting policy**
--------------------------------

Use Cloud Monitoring to create one or more alerting policies.

1.  In the left menu, click **Alerting**, and then click **Create Policy**.
2.  Click **Add Condition**.



Set the following in the panel that opens, leave all other fields at the default value.

**Target**: Start typing "VM" in the resource type and metric field, and then select:

*   **Resource Type**: VM Instance (gce\_instance)
*   **Metric**: Type "network", and then select Network traffic (gce\_instance+1). Be sure to choose the Network traffic resource with [`agent.googleapis.com/interface/traffic`](http://agent.googleapis.com/interface/traffic):

![](https://cdn.qwiklabs.com/iaqRe2fY42Td%2B8T8lu0UJUPRp377nHLXBvuXi%2BUGyBk%3D)

**Configuration**

*   **Condition**: is above
*   **Threshold**: 500
*   **For**: 1 minute

Click **ADD**.

1.  Click on **Next**.
2.  Click on drop down arrow next to **Notification Channels**, then click on **Manage Notification Channels**.

![](https://cdn.qwiklabs.com/akOFdDyEuKOmhn6BWOrBP7cGEvEy5jTDg28Q71R6Xms%3D)



A **Notification channels** page will open in new tab.

*   Scroll down the page and click on **ADD NEW** for **Email**.

![](https://cdn.qwiklabs.com/%2B3S74DM%2BjBdvWDyjMwuEzhk76T8GS6jA3aSpeeTsfvU%3D)

1.  In **Create Email Channel** dialog box, enter your personal email address in the **Email Address** field and a **Display name**.
2.  Click on **Save**.
3.  Go back to the previous **Create alerting policy** tab.
4.  Click on **Notification Channels** again, then click on the **Refresh icon** to get the display name you mentioned in the previous step.

![](https://cdn.qwiklabs.com/fXnoFzeQzHQdc905vD6QLzfKuwfk3F0BXZZADgsaUaQ%3D)

1.  Now, select your **Display name** and click **OK**.
2.  Click **Next**.
3.  Mention the **Alert name** as `Inbound Traffic Alert`.
4.  Add a message in documentation, which will be included in the emailed alert.
5.  Click on **Save**.

You've created an alert! While you wait for the system to trigger an alert, create a dashboard and chart, and then check out Cloud Logging.

Click **Check my progress** below. A green check confirms you're on track.



Create an uptime check and alerting policy



👉 **Create a dashboard and chart**
-----------------------------------

You can display the metrics collected by Cloud Monitoring in your own charts and dashboards. In this section you create the charts for the lab metrics and a custom dashboard.

1.  In the left menu select **Dashboards**, and then **Create Dashboard**.
2.  Name the dashboard `Cloud Monitoring LAMP Qwik Start Dashboard`.

### Add the first chart

1.  Click **Line** option in Chart library.
2.  Name the chart title **CPU Load**.
3.  Set the Resource type to **VM Instance**.
4.  Set the Metric **CPU load (1m)**. Refresh the tab to view the graph.

![](https://cdn.qwiklabs.com/s66pEeItPgh5Xpx5%2FVW9wCUjO%2FFWffJ4%2FEWTLiYqobk%3D)

### Add the second chart

1.  Click **\+ Add Chart** and select **Line** option in Chart library.
2.  Name this chart **Received Packets**.
3.  Set the resource type to **VM Instance**.
4.  Set the Metric **Received packets** (gce\_instance). Refresh the tab to view the graph.
5.  Leave the other fields at their default values. You see the chart data.

👉 **View your logs**
---------------------

Cloud Monitoring and Cloud Logging are closely integrated. Check out the logs for your lab.

1.  Select **Navigation menu** > **Logging** > **Logs Explorer**.
2.  Select the logs you want to see, in this case, you select the logs for the lamp-1-vm instance you created at the start of this lab:
3.  Click on **Resource**.

![](https://cdn.qwiklabs.com/oQG0TLaDLkFzNOAC25twWtuq55mOUPJDw05rZ3hMPXM%3D)



*   Select **VM Instance** > **lamp-1-vm** in the Resource drop-down menu.

![](https://cdn.qwiklabs.com/At5somXo%2FLgoR0YnOtwttk6q1QZUNTJssq2lxhl5luE%3D)

*   Click **Add**.
*   Leave the other fields with their default values.
*   Click the **Stream logs**.

![](https://cdn.qwiklabs.com/47cMAwVFt6zz3jGKFihSNTzHxaWmxpdyeXFi0QnUptw%3D)



You see the logs for your VM instance:

![](https://cdn.qwiklabs.com/yhfhYnWNatsnKkjPBSrN0gzSS0chG0YZcAF2Y9HSPOg%3D)



### Check out what happens when you start and stop the VM instance.

To best see how Cloud Monitoring and Cloud Logging reflect VM instance changes, make changes to your instance in one browser window and then see what happens in the Cloud Monitoring, and then Cloud Logging windows.



1.  Open the Compute Engine window in a new browser window. Select **Navigation menu** > **Compute Engine**, right-click **VM instances** > **Open link in new window**.
2.  Move the Logs Viewer browser window next to the Compute Engine window. This makes it easier to view how changes to the VM are reflected in the logs.

![](https://cdn.qwiklabs.com/HNEkpniiVJn2WneNYtD9KYwYYpbSEza4A2%2FOYRdgvM4%3D)

*   In the Compute Engine window, select the lamp-1-vm instance, click **Stop** at the top of the screen, and then confirm to stop the instance.



![](https://cdn.qwiklabs.com/kdn7Q67o5L%2BUDZqHM57q6OyN6LBimxAPIM1nlTBhblw%3D)

It takes a few minutes for the instance to stop.

*   Watch in the Logs View tab for when the VM is stopped.



![](https://cdn.qwiklabs.com/Uilb7O2f84GHmmjvLrWsDJEywuBhHIij1jAV24Xkft4%3D)

*   In the VM instance details window, click **Start** at the top of the screen, and then confirm. It will take a few minutes for the instance to re-start. Watch the log messages to monitor the start up.



![](https://cdn.qwiklabs.com/6R4kvJJg4oJKucjrkvHIJedqvfJ2nemhArgDunrVES0%3D)

👉 **Check the uptime check results and triggered alerts**
----------------------------------------------------------

*   In the Cloud Logging window, select **Navigation menu** > **Monitoring** > **Uptime checks**. This view provides a list of all active uptime checks, and the status of each in different locations.

You will see Lamp Uptime Check listed. Since you have just restarted your instance, the regions are in a failed status. It may take up to 5 minutes for the regions to become active. Reload your browser window as necessary until the regions are active.

*   Click the name of the uptime check, `Lamp Uptime Check`.

Since you have just restarted your instance, it may take some minutes for the regions to become active. Reload your browser window as necessary.

### ![](https://t4668229.p.clickup-attachments.com/t4668229/6204b591-bbd5-4ffc-8958-cb0fa16adad2/image.png)

### ![](https://t4668229.p.clickup-attachments.com/t4668229/2812b617-26f4-4334-a457-95e11c6262d7/image.png)

### ![](https://t4668229.p.clickup-attachments.com/t4668229/fae6de24-1ed4-42ea-b257-09d506456fc7/image.png)



### Check if alerts have been triggered

1.  In the left menu, click **Alerting**.
2.  You see incidents and events listed in the Alerting window.
3.  Check your email account. You should see Cloud Monitoring Alerts.

**Note:** Remove the email notification from your alerting policy. The resources for the lab may be active for a while after the completion, and this may result in a few more email notifications getting sent out.



![](https://t4668229.p.clickup-attachments.com/t4668229/b573a9ff-1d03-4c3d-9336-239b5ee4c1c4/image.png)



---

**Congratulations!**
--------------------

You have successfully set up and monitored a VM with Cloud Monitoring.
